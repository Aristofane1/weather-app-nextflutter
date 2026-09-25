import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/cache/cache_store.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/result/result.dart';
import 'package:weather_app/features/weather/data/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/weather.dart';

import '../../helpers/fakes.dart';

class MockWeatherRemote extends Mock implements WeatherRemoteDataSource {}

// Températures entières volontaires : OWM renvoie parfois des int.
Map<String, dynamic> currentJson() => {
      'name': 'Paris',
      'dt': 1758700800,
      'weather': [
        {'id': 800, 'main': 'Clear', 'description': 'ciel dégagé', 'icon': '01d'},
      ],
      'main': {'temp': 20, 'feels_like': 19.5, 'temp_min': 18, 'temp_max': 22.1, 'pressure': 1015, 'humidity': 60},
      'wind': {'speed': 3.6, 'deg': 200},
    };

Map<String, dynamic> forecastItem(int dt) => {
      'dt': dt,
      'main': {'temp': 15.2, 'feels_like': 14, 'temp_min': 14, 'temp_max': 16, 'humidity': 70},
      'weather': [
        {'description': 'nuageux', 'icon': '03d'},
      ],
      'wind': {'speed': 2},
      'dt_txt': '2026-09-24 12:00:00',
    };

void main() {
  late MockWeatherRemote remote;
  late MockCacheStore cache;
  late MockNetworkInfo network;
  late WeatherRepositoryImpl repo;
  const lat = 48.8566, lon = 2.3522;
  const currentKey = 'weather:current:48.86,2.35';

  setUpAll(registerFallbacks);

  setUp(() {
    remote = MockWeatherRemote();
    cache = MockCacheStore();
    network = MockNetworkInfo();
    stubEmptyCache(cache);
    repo = WeatherRepositoryImpl(remote: remote, cache: cache, networkInfo: network);
  });

  test('online: emits parsed weather and caches raw json', () async {
    when(() => network.isConnected).thenAnswer((_) async => true);
    when(() => remote.fetchCurrent(lat, lon)).thenAnswer((_) async => currentJson());

    final results = await repo.watchCurrent(lat: lat, lon: lon).toList();

    final s = results.single as Success<CurrentWeather>;
    expect(s.fromCache, isFalse);
    expect(s.data.cityName, 'Paris');
    expect(s.data.temperature, 20.0);
    expect(s.data.description, 'ciel dégagé');
    expect(s.data.iconCode, '01d');
    verify(() => cache.write(currentKey, currentJson())).called(1);
  });

  test('offline with cache: emits cached weather without API call', () async {
    final cachedAt = DateTime(2026, 9, 24, 7);
    when(() => network.isConnected).thenAnswer((_) async => false);
    when(() => cache.read(currentKey)).thenAnswer((_) async => CacheEntry(json: currentJson(), cachedAt: cachedAt));

    final results = await repo.watchCurrent(lat: lat, lon: lon).toList();

    final s = results.single as Success<CurrentWeather>;
    expect(s.fromCache, isTrue);
    expect(s.cachedAt, cachedAt);
    expect(s.data.cityName, 'Paris');
    verifyNever(() => remote.fetchCurrent(any(), any()));
  });

  test('offline without cache: emits network failure', () async {
    when(() => network.isConnected).thenAnswer((_) async => false);
    final results = await repo.watchCurrent(lat: lat, lon: lon).toList();
    expect(results.single.failureOrNull, isA<NetworkFailure>());
  });

  test('forecast: parses every 3h entry', () async {
    when(() => network.isConnected).thenAnswer((_) async => true);
    when(() => remote.fetchForecast(lat, lon)).thenAnswer((_) async => {
          'list': [forecastItem(1758715200), forecastItem(1758726000)],
          'city': {'name': 'Paris'},
        });
    final results = await repo.watchForecast(lat: lat, lon: lon).toList();
    final entries = results.single.dataOrNull!;
    expect(entries, hasLength(2));
    expect(entries.first.tempMax, 16.0);
    expect(entries.first.iconCode, '03d');
  });
}
