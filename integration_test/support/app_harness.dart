import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/app/app.dart';
import 'package:weather_app/core/core_providers.dart';
import 'package:weather_app/core/network/session_events.dart';
import 'package:weather_app/core/settings/settings_store.dart';
import 'package:weather_app/features/auth/data/auth_repository_impl.dart';
import 'package:weather_app/features/cities/data/cities_repository_impl.dart';
import 'package:weather_app/features/weather/data/weather_repository_impl.dart';

import 'fakes.dart';

/// Monte la vraie app (routeur, écrans, providers) sur des repositories factices, en français.
Future<void> pumpWeatherApp(WidgetTester tester, {bool signedIn = false, FakeCitiesRepository? cities}) async {
  await initializeDateFormatting();
  tester.platformDispatcher.localesTestValue = const [Locale('fr')];
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);

  await tester.pumpWidget(ProviderScope(
    overrides: [
      authRepositoryProvider.overrideWithValue(FakeAuthRepository(signedIn: signedIn)),
      citiesRepositoryProvider.overrideWithValue(cities ?? FakeCitiesRepository()),
      weatherRepositoryProvider.overrideWithValue(FakeWeatherRepository()),
      cacheStoreProvider.overrideWithValue(MemoryCacheStore()),
      settingsStoreProvider.overrideWithValue(MemorySettingsStore()),
      sessionEventsProvider.overrideWithValue(SessionEvents()),
      iconCacheManagerProvider.overrideWithValue(null),
    ],
    child: const WeatherApp(),
  ));
  await tester.pumpAndSettle();
}
