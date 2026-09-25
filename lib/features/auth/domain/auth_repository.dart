import '../../../core/result/result.dart';
import 'app_user.dart';

abstract interface class AuthRepository {
  Future<Result<AppUser>> signIn({required String email, required String password});

  /// `Success(null)` : compte créé, confirmation d'email requise avant connexion.
  Future<Result<AppUser?>> signUp({required String email, required String password});

  /// Déconnexion locale garantie, même hors ligne.
  Future<void> signOut();

  /// Efface les données locales (cache et session), sans appel réseau.
  /// Best-effort : ne lève jamais. Utilisé à l'expiration de la session.
  Future<void> clearLocalData();

  /// Utilisateur de la session stockée. Aucun appel réseau (offline-first).
  Future<AppUser?> currentUser();
}
