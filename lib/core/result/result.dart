import '../error/failure.dart';

/// Retour de tous les repositories : aucune exception ne remonte vers l'UI.
sealed class Result<T> {
  const Result();

  T? get dataOrNull => switch (this) {
        Success<T>(:final data) => data,
        Failed<T>() => null,
      };

  Failure? get failureOrNull => switch (this) {
        Success<T>() => null,
        Failed<T>(:final failure) => failure,
      };

  Result<R> map<R>(R Function(T data) transform) => switch (this) {
        Success<T>(:final data, :final fromCache, :final cachedAt) =>
          Success<R>(transform(data), fromCache: fromCache, cachedAt: cachedAt),
        Failed<T>(:final failure) => Failed<R>(failure),
      };
}

final class Success<T> extends Result<T> {
  const Success(this.data, {this.fromCache = false, this.cachedAt});

  final T data;

  /// `true` quand la donnée provient du cache local.
  final bool fromCache;
  final DateTime? cachedAt;
}

final class Failed<T> extends Result<T> {
  const Failed(this.failure);

  final Failure failure;
}
