import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/core_providers.dart';
import 'package:weather_app/core/result/result.dart';
import 'package:weather_app/core/settings/locale_controller.dart';
import 'package:weather_app/core/settings/settings_store.dart';
import 'package:weather_app/features/weather/data/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/weather.dart';
import 'package:weather_app/features/weather/domain/weather_repository.dart';
import 'package:weather_app/features/weather/presentation/weather_providers.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  test('changer de langue relance la requête météo courante', () async {
    final weather = MockWeatherRepository();
    final current = CurrentWeather(
      cityName: 'Paris',
      temperature: 21,
      feelsLike: 20,
      humidity: 50,
      windSpeed: 3,
      description: 'ciel dégagé',
      iconCode: '01d',
      date: DateTime(2026, 9, 25),
    );
    when(() => weather.watchCurrent(lat: any(named: 'lat'), lon: any(named: 'lon')))
        .thenAnswer((_) => Stream.value(Success(current)));

    // Départ en français : l'appareil de test est en en_US, passer de « appareil » à `en`
    // ne changerait pas la langue envoyée à OWM.
    final store = MemorySettingsStore();
    await store.write('locale', 'fr');
    final container = ProviderContainer(overrides: [
      settingsStoreProvider.overrideWithValue(store),
      weatherRepositoryProvider.overrideWithValue(weather),
    ]);
    addTearDown(container.dispose);

    container.listen(currentWeatherProvider(1, 2), (_, _) {});
    await pumpEventQueue();
    expect(container.read(apiLanguageProvider), 'fr');
    verify(() => weather.watchCurrent(lat: 1, lon: 2)).called(1);

    await container.read(localeControllerProvider.notifier).setLocale(const Locale('en'));
    await pumpEventQueue();
    verify(() => weather.watchCurrent(lat: 1, lon: 2)).called(1);
    expect(container.read(apiLanguageProvider), 'en');
  });
}
