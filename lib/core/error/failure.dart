import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Erreur métier affichable. Chaque variante porte son message utilisateur.
@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.network() = NetworkFailure;
  const factory Failure.timeout() = TimeoutFailure;
  const factory Failure.unauthorized() = UnauthorizedFailure;
  const factory Failure.invalidCredentials() = InvalidCredentialsFailure;
  const factory Failure.emailAlreadyUsed() = EmailAlreadyUsedFailure;
  const factory Failure.emailNotConfirmed() = EmailNotConfirmedFailure;
  const factory Failure.notFound() = NotFoundFailure;
  const factory Failure.server(int statusCode) = ServerFailure;
  const factory Failure.conflict() = ConflictFailure;
  const factory Failure.offlineAction() = OfflineActionFailure;
  const factory Failure.cache() = CacheFailure;
  const factory Failure.unknown() = UnknownFailure;

  String get message => switch (this) {
        NetworkFailure() => 'Pas de connexion internet',
        TimeoutFailure() => 'Le serveur met trop de temps à répondre',
        UnauthorizedFailure() => 'Session expirée, reconnectez-vous',
        InvalidCredentialsFailure() => 'Email ou mot de passe incorrect',
        EmailAlreadyUsedFailure() => 'Cet email est déjà utilisé',
        EmailNotConfirmedFailure() => 'Email non confirmé : cliquez sur le lien reçu par email avant de vous connecter',
        NotFoundFailure() => 'Ressource introuvable',
        ServerFailure(:final statusCode) => 'Erreur serveur ($statusCode)',
        ConflictFailure() => 'Cet élément existe déjà',
        OfflineActionFailure() => 'Action impossible hors ligne',
        CacheFailure() => 'Données locales indisponibles',
        UnknownFailure() => 'Une erreur inattendue est survenue',
      };
}
