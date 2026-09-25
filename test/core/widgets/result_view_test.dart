import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/result/result.dart';
import 'package:weather_app/core/widgets/result_view.dart';

import '../../helpers/localized_app.dart';

void main() {
  Widget host(AsyncValue<Result<String>> value, {VoidCallback? onRetry}) => localizedApp(
        home: Scaffold(
          body: ResultView<String>(
            value: value,
            skeleton: const Text('skeleton'),
            onRetry: onRetry,
            builder: (_, data) => Text('data:$data'),
          ),
        ),
      );

  testWidgets('loading shows skeleton', (tester) async {
    await tester.pumpWidget(host(const AsyncLoading()));
    expect(find.text('skeleton'), findsOneWidget);
  });

  testWidgets('cached data shows content only', (tester) async {
    await tester.pumpWidget(host(AsyncData(Success('x', fromCache: true, cachedAt: DateTime(2026, 9, 24, 14, 5)))));
    expect(find.text('data:x'), findsOneWidget);
    expect(find.textContaining('cache'), findsNothing);
  });

  testWidgets('failure shows message and retry', (tester) async {
    var retried = 0;
    await tester.pumpWidget(host(const AsyncData(Failed(Failure.network())), onRetry: () => retried++));
    expect(find.text('Pas de connexion internet'), findsOneWidget);
    await tester.tap(find.text('Réessayer'));
    expect(retried, 1);
  });
}
