import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Erreur métier. Le texte affiché vient de FailureL10n (lib/core/error/failure_l10n.dart).
@freezed
sealed class Failure with _$Failure {
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
}
