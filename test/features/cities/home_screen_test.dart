import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/result/result.dart';
import 'package:weather_app/core/widgets/skeleton.dart';
import 'package:weather_app/features/cities/data/cities_repository_impl.dart';
import 'package:weather_app/features/cities/domain/cities_repository.dart';
import 'package:weather_app/features/cities/domain/city.dart';
import 'package:weather_app/features/cities/presentation/home_screen.dart';
import 'package:weather_app/features/weather/data/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/weather.dart';
import 'package:weather_app/features/weather/domain/weather_repository.dart';

import '../../helpers/localized_app.dart';

class MockCitiesRepository extends Mock implements CitiesRepository {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late MockCitiesRepository cities;
  late MockWeatherRepository weather;
  const paris = City(id: 1, name: 'Paris', country: 'FR', lat: 48.85, lon: 2.35);

  setUpAll(() => initializeDateFormatting());

  setUp(() {
    cities = MockCitiesRepository();
    weather = MockWeatherRepository();
  });

  Widget app() => ProviderScope(
        overrides: [
          citiesRepositoryProvider.overrideWithValue(cities),
          weatherRepositoryProvider.overrideWithValue(weather),
          ...testOverrides,
        ],
        child: localizedApp(home: const HomeScreen()),
      );

  testWidgets('shows skeleton while favorites load', (tester) async {
    final controller = StreamController<Result<List<City>>>();
    addTearDown(controller.close);
    when(() => cities.watchFavorites()).thenAnswer((_) => controller.stream);

    await tester.pumpWidget(app());
    await tester.pump();

    expect(find.byType(SkeletonList), findsOneWidget);
  });

  testWidgets('shows cached favorites with temperature', (tester) async {
    when(() => cities.watchFavorites()).thenAnswer(
      (_) => Stream.value(Success([paris], fromCache: true, cachedAt: DateTime(2026, 9, 24, 14, 5))),
    );
    when(() => weather.watchCurrent(lat: any(named: 'lat'), lon: any(named: 'lon'))).thenAnswer(
      (_) => Stream.value(Success(CurrentWeather(
        cityName: 'Paris',
        temperature: 21.4,
        feelsLike: 20,
        humidity: 50,
        windSpeed: 3,
        description: 'ciel dégagé',
        iconCode: '01d',
        date: DateTime(2026, 9, 24, 14),
      ))),
    );

    await tester.pumpWidget(app());
    await tester.pump();
    await tester.pump();

    expect(find.text('Paris'), findsOneWidget);
    expect(find.text('21°'), findsOneWidget);
    expect(find.textContaining('cache'), findsNothing);
  });

  testWidgets('shows empty state when no favorites', (tester) async {
    when(() => cities.watchFavorites()).thenAnswer((_) => Stream.value(const Success(<City>[])));

    await tester.pumpWidget(app());
    await tester.pump();

    expect(find.text('Aucune ville favorite pour le moment'), findsOneWidget);
  });

  testWidgets('pull-to-refresh works on the empty state', (tester) async {
    when(() => cities.watchFavorites()).thenAnswer((_) => Stream.value(const Success(<City>[])));

    await tester.pumpWidget(app());
    await tester.pump();
    await tester.fling(find.text('Aucune ville favorite pour le moment'), const Offset(0, 300), 1000);
    await tester.pumpAndSettle();

    verify(() => cities.watchFavorites()).called(2);
  });

  testWidgets('pull-to-refresh works on the error state', (tester) async {
    when(() => cities.watchFavorites())
        .thenAnswer((_) => Stream.value(const Failed<List<City>>(Failure.network())));

    await tester.pumpWidget(app());
    await tester.pump();
    expect(find.text('Pas de connexion internet'), findsOneWidget);
    await tester.fling(find.text('Pas de connexion internet'), const Offset(0, 300), 1000);
    await tester.pumpAndSettle();

    verify(() => cities.watchFavorites()).called(2);
  });
}
