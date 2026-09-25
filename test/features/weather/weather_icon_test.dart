import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/core_providers.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_icon.dart';

void main() {
  Widget host(String? code) => ProviderScope(
        overrides: [iconCacheManagerProvider.overrideWithValue(null)],
        child: MaterialApp(home: Scaffold(body: WeatherIcon(code: code, size: 40))),
      );

  testWidgets('without network images shows the fallback icon', (tester) async {
    await tester.pumpWidget(host('01d'));
    expect(find.byIcon(Icons.cloud_outlined), findsOneWidget);
    expect(tester.getSize(find.byType(WeatherIcon)), const Size(40, 40));
  });

  testWidgets('without code reserves the space only', (tester) async {
    await tester.pumpWidget(host(null));
    expect(find.byIcon(Icons.cloud_outlined), findsNothing);
    expect(tester.getSize(find.byType(WeatherIcon)), const Size(40, 40));
  });
}
