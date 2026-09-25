import 'package:dio/dio.dart';

import '../storage/auth_session.dart';
import '../storage/session_storage.dart';

typedef SessionRefresher = Future<AuthSession> Function(String refreshToken);

/// Injecte le JWT et rafraîchit la session (préventivement ou sur 401).
/// [QueuedInterceptor] : les requêtes concurrentes attendent le même refresh.
class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required this.retryDio,
    required this.storage,
    required this.refresh,
    required this.onSessionExpired,
  });

  /// Client SANS AuthInterceptor, utilisé pour rejouer la requête (rejouer via
  /// le client intercepté bloque la file d'erreurs de QueuedInterceptor).
  final Dio retryDio;
  final SessionStorage storage;
  final SessionRefresher refresh;
  final void Function() onSessionExpired;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var session = await storage.read();
    if (session != null && session.isExpired()) {
      session = await _refresh(session) ?? await storage.read();
      // Refresh refusé (session effacée) : ne pas envoyer la requête en anonyme.
      if (session == null) {
        handler.reject(DioException(
          requestOptions: options,
          type: DioExceptionType.badResponse,
          response: Response<dynamic>(requestOptions: options, statusCode: 401),
        ));
        return;
      }
    }
    if (session != null) {
      options.headers['Authorization'] = 'Bearer ${session.accessToken}';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final current = await storage.read();
    if (err.response?.statusCode != 401 || current == null) {
      handler.next(err);
      return;
    }

    // Si une autre requête a déjà rafraîchi la session, on rejoue directement.
    final sentWithCurrent = options.headers['Authorization'] == 'Bearer ${current.accessToken}';
    final session = sentWithCurrent ? await _refresh(current) : current;
    if (session == null) {
      handler.next(err);
      return;
    }

    options.headers['Authorization'] = 'Bearer ${session.accessToken}';
    try {
      handler.resolve(await retryDio.fetch<dynamic>(options));
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  Future<AuthSession?> _refresh(AuthSession session) async {
    try {
      final fresh = await refresh(session.refreshToken);
      await storage.save(fresh);
      return fresh;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      // Refresh refusé par le serveur : la session est morte.
      // Erreur réseau : on garde la session (offline-first).
      if (status != null && status >= 400 && status < 500) {
        await storage.clear();
        onSessionExpired();
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
