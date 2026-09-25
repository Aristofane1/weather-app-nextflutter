import '../cache/cache_store.dart';
import '../error/error_mapper.dart';
import '../error/failure.dart';
import '../network/network_info.dart';
import '../result/result.dart';

/// Socle des repositories : lecture offline-first et appels protégés.
abstract class BaseRepository {
  BaseRepository({required this.cache, required this.networkInfo});

  final CacheStore cache;
  final NetworkInfo networkInfo;

  /// Émet d'abord le cache (s'il existe), puis la donnée réseau fraîche.
  /// Si le réseau échoue alors que le cache est déjà affiché, rien de plus n'est émis.
  Stream<Result<T>> offlineFirst<T>({
    required String cacheKey,
    required Future<Object> Function() fetch,
    required T Function(Object json) parse,
  }) async* {
    final cached = await _readCache(cacheKey, parse);
    if (cached != null) yield cached;

    if (!await _isConnected()) {
      if (cached == null) yield Failed<T>(const Failure.network());
      return;
    }

    try {
      final json = await fetch();
      final data = parse(json);
      await cache.write(cacheKey, json);
      yield Success<T>(data);
    } catch (error) {
      if (cached == null) yield Failed<T>(toFailure(error));
    }
  }

  /// Exécute une action réseau et transforme toute erreur en [Failed].
  /// [offlineFailure] : erreur renvoyée sans appel réseau quand l'appareil est hors ligne.
  Future<Result<T>> guard<T>(
    Future<T> Function() action, {
    bool requiresNetwork = true,
    Failure offlineFailure = const Failure.network(),
  }) async {
    if (requiresNetwork && !await _isConnected()) {
      return Failed<T>(offlineFailure);
    }
    try {
      return Success<T>(await action());
    } catch (error) {
      return Failed<T>(toFailure(error));
    }
  }

  /// Si l'état de la connectivité est inconnu (erreur du plugin), on tente quand
  /// même le réseau : en cas d'échec du fetch, on retombe sur le cache ou une [Failure].
  Future<bool> _isConnected() async {
    try {
      return await networkInfo.isConnected;
    } catch (_) {
      return true;
    }
  }

  Future<Success<T>?> _readCache<T>(String key, T Function(Object json) parse) async {
    try {
      final entry = await cache.read(key);
      if (entry == null) return null;
      return Success<T>(parse(entry.json), fromCache: true, cachedAt: entry.cachedAt);
    } catch (_) {
      // Entrée illisible (format d'API changé) : on l'ignore.
      try {
        await cache.delete(key);
      } catch (_) {}
      return null;
    }
  }
}
