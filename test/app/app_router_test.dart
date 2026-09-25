import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/app/app_router.dart';
import 'package:weather_app/core/core_providers.dart';
import 'package:weather_app/core/network/session_events.dart';
import 'package:weather_app/core/result/result.dart';
import 'package:weather_app/features/auth/data/auth_repository_impl.dart';
import 'package:weather_app/features/auth/domain/app_user.dart';
import 'package:weather_app/features/auth/domain/auth_repository.dart';
import 'package:weather_app/features/cities/data/cities_repository_impl.dart';
import 'package:weather_app/features/cities/domain/cities_repository.dart';
import 'package:weather_app/features/cities/domain/city.dart';
import 'package:weather_app/features/cities/presentation/home_screen.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockCitiesRepository extends Mock implements CitiesRepository {}

void main() {
  for (final location in ['/city?lat=abc&lon=2.35', '/city?lon=2.35', '/city?lat=48.85&lon=']) {
    testWidgets('malformed city URL $location redirects to home', (tester) async {
      final auth = MockAuthRepository();
      final cities = MockCitiesRepository();
      final favorites = StreamController<Result<List<City>>>();
      addTearDown(favorites.close);
      when(() => auth.currentUser()).thenAnswer((_) async => const AppUser(id: 'u1', email: 'a@b.c'));
      when(() => cities.watchFavorites()).thenAnswer((_) => favorites.stream);

      final container = ProviderContainer(overrides: [
        authRepositoryProvider.overrideWithValue(auth),
        sessionEventsProvider.overrideWithValue(SessionEvents()),
        citiesRepositoryProvider.overrideWithValue(cities),
      ]);
      addTearDown(container.dispose);
      final router = container.read(appRouterProvider);

      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ));
      await tester.pump();
      await tester.pump();

      router.go(location);
      await tester.pump();
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(router.routerDelegate.currentConfiguration.uri.path, '/');
    });
  }
}
