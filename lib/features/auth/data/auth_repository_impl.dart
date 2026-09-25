import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/core_providers.dart';
import '../../../core/repository/base_repository.dart';
import '../../../core/result/result.dart';
import '../../../core/storage/auth_session.dart';
import '../../../core/storage/session_storage.dart';
import '../domain/app_user.dart';
import '../domain/auth_repository.dart';
import 'auth_remote_data_source.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  AuthRepositoryImpl({
    required this.remote,
    required this.sessionStorage,
    required super.cache,
    required super.networkInfo,
  });

  final AuthRemoteDataSource remote;
  final SessionStorage sessionStorage;

  @override
  Future<Result<AppUser>> signIn({required String email, required String password}) => guard(() async {
        final json = await remote.signIn(email.trim(), password);
        return _persist(json);
      });

  @override
  Future<Result<AppUser?>> signUp({required String email, required String password}) => guard(() async {
        final json = await remote.signUp(email.trim(), password);
        // Confirmation d'email active : Supabase renvoie l'utilisateur sans session.
        if (json['access_token'] == null) return null;
        return _persist(json);
      });

  @override
  Future<void> signOut() async {
    try {
      final session = await sessionStorage.read();
      if (session != null) await remote.signOut(session.accessToken);
    } catch (_) {
      // Session illisible ou API injoignable : déconnexion locale quoi qu'il arrive.
    }
    await clearLocalData();
  }

  /// Best-effort : chaque nettoyage local est isolé pour qu'une exception
  /// (keystore, Hive) n'empêche jamais l'appelant de se terminer, et pour que
  /// le cache soit vidé même si l'effacement de la session échoue.
  @override
  Future<void> clearLocalData() async {
    try {
      await sessionStorage.clear();
    } catch (_) {}
    await _clearCache();
  }

  Future<void> _clearCache() async {
    try {
      await cache.clear();
    } catch (_) {}
  }

  @override
  Future<AppUser?> currentUser() async {
    try {
      final session = await sessionStorage.read();
      return session == null ? null : AppUser(id: session.userId, email: session.email);
    } catch (_) {
      return null;
    }
  }

  /// Vide le cache avant d'enregistrer la nouvelle session : un nouvel
  /// utilisateur ne voit jamais les données du précédent, même si une écriture
  /// en vol a atterri dans le cache après la déconnexion.
  Future<AppUser> _persist(Map<String, dynamic> json) async {
    final session = AuthSession.fromSupabase(json);
    await _clearCache();
    await sessionStorage.save(session);
    return AppUser(id: session.userId, email: session.email);
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
      remote: AuthRemoteDataSource(ref.watch(supabaseAuthDioProvider)),
      sessionStorage: ref.watch(sessionStorageProvider),
      cache: ref.watch(cacheStoreProvider),
      networkInfo: ref.watch(networkInfoProvider),
    );
