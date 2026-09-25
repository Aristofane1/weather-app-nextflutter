import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/error/failure_l10n.dart';
import 'package:weather_app/features/cities/data/cities_remote_data_source.dart';
import 'package:weather_app/features/cities/data/cities_repository_impl.dart';
import 'package:weather_app/features/cities/domain/city.dart';

import '../../helpers/fakes.dart';
import '../../helpers/localized_app.dart';

class MockCitiesRemote extends Mock implements CitiesRemoteDataSource {}

Map<String, dynamic> parisRow({int? id}) => {
      'id': ?id,
      'name': 'Paris',
      'country': 'FR',
      'state': 'Ile-de-France',
      'lat': 48.8566,
      'lon': 2.3522,
    };

void main() {
  late MockCitiesRemote remote;
  late MockCacheStore cache;
  late MockNetworkInfo network;
  late CitiesRepositoryImpl repo;
  const paris = City(name: 'Paris', country: 'FR', lat: 48.8566, lon: 2.3522);

  setUpAll(() {
    registerFallbacks();
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    remote = MockCitiesRemote();
    cache = MockCacheStore();
    network = MockNetworkInfo();
    stubEmptyCache(cache);
    when(() => network.isConnected).thenAnswer((_) async => true);
    repo = CitiesRepositoryImpl(remote: remote, cache: cache, networkInfo: network);
  });

  test('watchFavorites online: parses rows and caches them', () async {
    final rows = [parisRow(id: 7)];
    when(() => remote.fetchFavorites()).thenAnswer((_) async => rows);
    final results = await repo.watchFavorites().toList();
    final cities = results.single.dataOrNull!;
    expect(cities.single.id, 7);
    expect(cities.single.name, 'Paris');
    verify(() => cache.write(CitiesRepositoryImpl.favoritesKey, rows)).called(1);
  });

  test('blank query returns empty list without API call', () async {
    final r = await repo.search('   ');
    expect(r.dataOrNull, isEmpty);
    verifyNever(() => remote.search(any()));
  });

  test('search trims query and parses geocoding results', () async {
    when(() => remote.search('Paris')).thenAnswer((_) async => [parisRow()]);
    final r = await repo.search(' Paris ');
    expect(r.dataOrNull!.single.subtitle, 'Ile-de-France, FR');
  });

  test('search drops duplicate locations, keeping the first', () async {
    final lyon = {'name': 'Lyon', 'country': 'FR', 'state': 'Auvergne-Rhône-Alpes', 'lat': 45.7578, 'lon': 4.8320};
    when(() => remote.search('Lyon')).thenAnswer((_) async => [
          lyon,
          {...lyon, 'lat': 45.7579},
          {'name': 'Lyon', 'country': 'US', 'state': 'Mississippi', 'lat': 34.2176, 'lon': -90.5409},
        ]);
    final cities = (await repo.search('Lyon')).dataOrNull!;
    expect(cities, hasLength(2));
    expect(cities.first.lat, 45.7578);
    expect(cities.last.country, 'US');
  });

  test('search drops results with the same label (name, state, country), keeping the first', () async {
    // Cas réel OWM « Lyon » : même libellé, coordonnées à ~7 km (hors tolérance de sameLocation).
    final lyon = {'name': 'Lyon', 'country': 'FR', 'state': 'Auvergne-Rhône-Alpes', 'lat': 45.7578, 'lon': 4.8320};
    when(() => remote.search('Lyon')).thenAnswer((_) async => [
          lyon,
          {...lyon, 'lat': 45.6963, 'lon': 4.7359},
          {'name': 'Lyon', 'country': 'US', 'state': 'Mississippi', 'lat': 34.2176, 'lon': -90.5409},
        ]);
    final cities = (await repo.search('Lyon')).dataOrNull!;
    expect(cities, hasLength(2));
    expect(cities.first.lat, 45.7578);
    expect(cities.last.country, 'US');
  });

  test('addFavorite offline returns offlineAction failure', () async {
    when(() => network.isConnected).thenAnswer((_) async => false);
    final r = await repo.addFavorite(paris);
    expect(r.failureOrNull, isA<OfflineActionFailure>());
    expect(r.failureOrNull!.message(l10nFr), 'Action impossible hors ligne');
    verifyNever(() => remote.addFavorite(any()));
  });

  test('removeFavorite offline returns offlineAction failure', () async {
    when(() => network.isConnected).thenAnswer((_) async => false);
    final r = await repo.removeFavorite(paris.copyWith(id: 3));
    expect(r.failureOrNull, isA<OfflineActionFailure>());
    verifyNever(() => remote.removeFavorite(any()));
  });

  test('addFavorite sends city without id and returns created row', () async {
    when(() => remote.addFavorite(any())).thenAnswer((_) async => parisRow(id: 12));
    final r = await repo.addFavorite(paris);
    expect(r.dataOrNull!.id, 12);
    final sent = verify(() => remote.addFavorite(captureAny())).captured.single as Map<String, dynamic>;
    expect(sent.containsKey('id'), isFalse);
    expect(sent['name'], 'Paris');
  });

  test('removeFavorite without id returns notFound', () async {
    final r = await repo.removeFavorite(paris);
    expect(r.failureOrNull, isA<NotFoundFailure>());
  });
}
