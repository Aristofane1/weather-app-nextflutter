import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/cache/cache_store.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/repository/base_repository.dart';
import 'package:weather_app/core/result/result.dart';

import '../../helpers/fakes.dart';

class _TestRepository extends BaseRepository {
  _TestRepository({required super.cache, required super.networkInfo});
}

String parse(Object json) => (json as Map)['value'] as String;

void main() {
  late MockCacheStore cache;
  late MockNetworkInfo network;
  late _TestRepository repo;
  final cachedAt = DateTime(2026, 9, 24, 8);
  var fetchCalls = 0;

  setUpAll(registerFallbacks);

  setUp(() {
    cache = MockCacheStore();
    network = MockNetworkInfo();
    repo = _TestRepository(cache: cache, networkInfo: network);
    stubEmptyCache(cache);
    fetchCalls = 0;
  });

  Future<Object> fetchFresh() async {
    fetchCalls++;
    return {'value': 'fresh'};
  }

  void givenCache(Object json) {
    when(() => cache.read('k')).thenAnswer((_) async => CacheEntry(json: json, cachedAt: cachedAt));
  }

  Future<List<Result<String>>> run(Future<Object> Function() fetch) =>
      repo.offlineFirst(cacheKey: 'k', fetch: fetch, parse: parse).toList();

  test('online without cache: emits fresh data and writes cache', () async {
    when(() => network.isConnected).thenAnswer((_) async => true);
    final results = await run(fetchFresh);
    expect(results, hasLength(1));
    final s = results.single as Success<String>;
    expect(s.data, 'fresh');
    expect(s.fromCache, isFalse);
    verify(() => cache.write('k', {'value': 'fresh'})).called(1);
  });

  test('online with cache: emits cached then fresh', () async {
    when(() => network.isConnected).thenAnswer((_) async => true);
    givenCache({'value': 'old'});
    final results = await run(fetchFresh);
    expect(results.map((r) => r.dataOrNull), ['old', 'fresh']);
    expect((results.first as Success).fromCache, isTrue);
    expect((results.first as Success).cachedAt, cachedAt);
    expect((results.last as Success).fromCache, isFalse);
  });

  test('offline with cache: emits cached only, no fetch', () async {
    when(() => network.isConnected).thenAnswer((_) async => false);
    givenCache({'value': 'old'});
    final results = await run(fetchFresh);
    expect(results.map((r) => r.dataOrNull), ['old']);
    expect(fetchCalls, 0);
  });

  test('offline without cache: emits network failure', () async {
    when(() => network.isConnected).thenAnswer((_) async => false);
    final results = await run(fetchFresh);
    expect(results.single.failureOrNull, isA<NetworkFailure>());
  });

  test('fetch failure keeps cached data', () async {
    when(() => network.isConnected).thenAnswer((_) async => true);
    givenCache({'value': 'old'});
    final results = await run(() async => throw DioException(
          requestOptions: RequestOptions(path: '/x'),
          type: DioExceptionType.receiveTimeout,
        ));
    expect(results.map((r) => r.dataOrNull), ['old']);
  });

  test('fetch failure without cache emits mapped failure', () async {
    when(() => network.isConnected).thenAnswer((_) async => true);
    final results = await run(() async => throw DioException(
          requestOptions: RequestOptions(path: '/x'),
          type: DioExceptionType.receiveTimeout,
        ));
    expect(results.single.failureOrNull, isA<TimeoutFailure>());
  });

  test('corrupt cache entry is dropped and fresh data fetched', () async {
    when(() => network.isConnected).thenAnswer((_) async => true);
    givenCache({'unexpected': 42});
    final results = await run(fetchFresh);
    expect(results.map((r) => r.dataOrNull), ['fresh']);
    verify(() => cache.delete('k')).called(1);
  });

  test('isConnected throwing still fetches and emits fresh data', () async {
    when(() => network.isConnected).thenThrow(Exception('plugin'));
    final results = await run(fetchFresh);
    expect(results.map((r) => r.dataOrNull), ['fresh']);
  });

  group('guard', () {
    test('offline returns network failure without running action', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      var ran = false;
      final r = await repo.guard(() async => ran = true);
      expect(r.failureOrNull, isA<NetworkFailure>());
      expect(ran, isFalse);
    });

    test('offline uses the provided offlineFailure', () async {
      when(() => network.isConnected).thenAnswer((_) async => false);
      final r = await repo.guard(() async => 42, offlineFailure: const Failure.offlineAction());
      expect(r.failureOrNull, isA<OfflineActionFailure>());
    });

    test('maps thrown errors', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      final r = await repo.guard<int>(() async => throw const Failure.notFound());
      expect(r.failureOrNull, isA<NotFoundFailure>());
    });

    test('wraps success', () async {
      when(() => network.isConnected).thenAnswer((_) async => true);
      final r = await repo.guard(() async => 42);
      expect(r.dataOrNull, 42);
    });

    test('isConnected throwing still runs the action and returns Success', () async {
      when(() => network.isConnected).thenThrow(Exception('plugin'));
      final r = await repo.guard(() async => 42);
      expect(r.dataOrNull, 42);
    });
  });
}
