import '../../l10n/l10n.dart';
import 'failure.dart';

/// Traduction des erreurs métier : le core reste indépendant de la langue.
extension FailureL10n on Failure {
  String message(AppLocalizations l10n) => switch (this) {
        NetworkFailure() => l10n.errorNetwork,
        TimeoutFailure() => l10n.errorTimeout,
        UnauthorizedFailure() => l10n.errorUnauthorized,
        InvalidCredentialsFailure() => l10n.errorInvalidCredentials,
        EmailAlreadyUsedFailure() => l10n.errorEmailAlreadyUsed,
        EmailNotConfirmedFailure() => l10n.errorEmailNotConfirmed,
        NotFoundFailure() => l10n.errorNotFound,
        ServerFailure(:final statusCode) => l10n.errorServer(statusCode),
        ConflictFailure() => l10n.errorConflict,
        OfflineActionFailure() => l10n.errorOfflineAction,
        CacheFailure() => l10n.errorCache,
        UnknownFailure() => l10n.errorUnknown,
      };
}
