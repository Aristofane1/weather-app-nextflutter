import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/result/result.dart';
import 'package:weather_app/features/cities/data/cities_repository_impl.dart';
import 'package:weather_app/features/cities/domain/cities_repository.dart';
import 'package:weather_app/features/cities/domain/city.dart';
import 'package:weather_app/features/cities/presentation/search_screen.dart';

class MockCitiesRepository extends Mock implements CitiesRepository {}

void main() {
  const paris = City(name: 'Paris', country: 'FR', lat: 48.85, lon: 2.35);

  setUpAll(() => registerFallbackValue(paris));

  testWidgets('favorite button ignores taps while the add is in flight', (tester) async {
    final cities = MockCitiesRepository();
    final pending = Completer<Result<City>>();
    when(() => cities.watchFavorites()).thenAnswer((_) => Stream.value(const Success(<City>[])));
    when(() => cities.search('Paris')).thenAnswer((_) async => const Success([paris]));
    when(() => cities.addFavorite(any())).thenAnswer((_) => pending.future);

    await tester.pumpWidget(ProviderScope(
      overrides: [citiesRepositoryProvider.overrideWithValue(cities)],
      child: const MaterialApp(home: SearchScreen()),
    ));
    await tester.enterText(find.byType(TextField), 'Paris');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pump();

    final star = find.byTooltip('Ajouter aux favoris');
    await tester.tap(star);
    await tester.pump();
    await tester.tap(star, warnIfMissed: false);
    await tester.pump();

    verify(() => cities.addFavorite(any())).called(1);
    expect(tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.star_border)).onPressed, isNull);

    pending.complete(const Success(paris));
    await tester.pumpAndSettle();
    expect(tester.widget<IconButton>(find.widgetWithIcon(IconButton, Icons.star_border)).onPressed, isNotNull);
  });
}
