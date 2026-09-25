import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/l10n.dart';
import '../error/error_mapper.dart';
import '../error/failure_l10n.dart';
import '../result/result.dart';
import 'error_view.dart';
import 'scrollable_fill.dart';

/// Rend un `AsyncValue<Result<T>>` : skeleton → données → erreur.
/// C'est le point d'entrée standard des écrans alimentés par un repository.
class ResultView<T> extends StatelessWidget {
  const ResultView({
    super.key,
    required this.value,
    required this.builder,
    required this.skeleton,
    this.onRetry,
    this.scrollableError = false,
  });

  final AsyncValue<Result<T>> value;
  final Widget Function(BuildContext context, T data) builder;
  final Widget skeleton;
  final VoidCallback? onRetry;
  /// `true` : l'erreur est défilable (écran enveloppé dans un `RefreshIndicator`).
  final bool scrollableError;

  @override
  Widget build(BuildContext context) {
    final result = value.value;
    if (result != null) {
      return switch (result) {
        Success<T>(:final data) => builder(context, data),
        Failed<T>(:final failure) => _error(context, failure.message(context.l10n)),
      };
    }
    if (value.hasError) return _error(context, toFailure(value.error!).message(context.l10n));
    return skeleton;
  }

  Widget _error(BuildContext context, String message) {
    final view = ErrorView(message: message, onRetry: onRetry);
    return scrollableError ? ScrollableFill(child: view) : view;
  }
}
