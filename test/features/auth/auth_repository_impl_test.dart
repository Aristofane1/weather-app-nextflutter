import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/storage/auth_session.dart';
import 'package:weather_app/features/auth/data/auth_remote_data_source.dart';
import 'package:weather_app/features/auth/data/auth_repository_impl.dart';
import 'package:weather_app/features/auth/domain/app_user.dart';

import '../../helpers/fakes.dart';

class MockAuthRemote extends Mock implements AuthRemoteDataSource {}

Map<String, dynamic> sessionJson() => {
      'access_token': 'acc',
      'refresh_token': 'ref',
      'expires_in': 3600,
      'token_type': 'bearer',
      'user': {'id': 'u1', 'email': 'a@b.c'},
    };

void main() {
  late MockAuthRemote remote;
  late MockCacheStore cache;
  late MockNetworkInfo network;
  late InMemorySessionStorage storage;
  late AuthRepositoryImpl repo;

  setUpAll(registerFallbacks);

  setUp(() {
    remote = MockAuthRemote();
    cache = MockCacheStore();
    network = MockNetworkInfo();
    storage = InMemorySessionStorage();
    stubEmptyCache(cache);
    when(() => network.isConnected).thenAnswer((_) async => true);
    repo = AuthRepositoryImpl(remote: remote, sessionStorage: storage, cache: cache, networkInfo: network);
  });

  test('signIn stores session and returns user (email trimmed)', () async {
    when(() => remote.signIn('a@b.c', 'pw')).thenAnswer((_) async => sessionJson());
    final r = await repo.signIn(email: '  a@b.c ', password: 'pw');
    expect(r.dataOrNull, const AppUser(id: 'u1', email: 'a@b.c'));
    expect(storage.session!.accessToken, 'acc');
    expect(storage.session!.refreshToken, 'ref');
  });

  test('signIn with bad credentials returns invalidCredentials and stores nothing', () async {
    final options = RequestOptions(path: '/auth/v1/token');
    when(() => remote.signIn(any(), any())).thenThrow(DioException(
      requestOptions: options,
      type: DioExceptionType.badResponse,
      response: Response<dynamic>(
        requestOptions: options,
        statusCode: 400,
        data: {'error_code': 'invalid_credentials', 'msg': 'Invalid login credentials'},
      ),
    ));
    final r = await repo.signIn(email: 'a@b.c', password: 'bad');
    expect(r.failureOrNull, isA<InvalidCredentialsFailure>());
    expect(storage.session, isNull);
  });

  test('signIn offline returns network failure without calling API', () async {
    when(() => network.isConnected).thenAnswer((_) async => false);
    final r = await repo.signIn(email: 'a@b.c', password: 'pw');
    expect(r.failureOrNull, isA<NetworkFailure>());
    verifyNever(() => remote.signIn(any(), any()));
  });

  test('signUp with email confirmation returns Success(null)', () async {
    when(() => remote.signUp('a@b.c', 'pw1234')).thenAnswer((_) async => {'id': 'u1', 'email': 'a@b.c'});
    final r = await repo.signUp(email: 'a@b.c', password: 'pw1234');
    expect(r.failureOrNull, isNull);
    expect(r.dataOrNull, isNull);
    expect(storage.session, isNull);
  });

  test('signOut clears session and cache even if API fails', () async {
    storage.session = testSession(access: 'acc');
    when(() => remote.signOut('acc')).thenThrow(Exception('offline'));
    await repo.signOut();
    verify(() => remote.signOut('acc')).called(1);
    expect(storage.session, isNull);
    verify(() => cache.clear()).called(1);
  });

  test('currentUser reads stored session', () async {
    expect(await repo.currentUser(), isNull);
    storage.session = testSession();
    expect(await repo.currentUser(), const AppUser(id: 'u1', email: 'a@b.c'));
  });

  test('signOut completes and still clears cache when session clear throws', () async {
    final throwingStorage = _ThrowingClearStorage()..session = testSession(access: 'acc');
    final repoWithThrowingStorage =
        AuthRepositoryImpl(remote: remote, sessionStorage: throwingStorage, cache: cache, networkInfo: network);
    when(() => remote.signOut('acc')).thenAnswer((_) async {});
    await expectLater(repoWithThrowingStorage.signOut(), completes);
    verify(() => cache.clear()).called(1);
  });

  test('signIn clears previous cache before persisting the new session', () async {
    when(() => remote.signIn('a@b.c', 'pw')).thenAnswer((_) async => sessionJson());
    final r = await repo.signIn(email: 'a@b.c', password: 'pw');
    expect(r.dataOrNull, isNotNull);
    verify(() => cache.clear()).called(1);
  });

  test('signIn still succeeds when cache clear throws', () async {
    when(() => cache.clear()).thenThrow(Exception('hive'));
    when(() => remote.signIn('a@b.c', 'pw')).thenAnswer((_) async => sessionJson());
    final r = await repo.signIn(email: 'a@b.c', password: 'pw');
    expect(r.dataOrNull, const AppUser(id: 'u1', email: 'a@b.c'));
    expect(storage.session!.accessToken, 'acc');
  });

  test('signUp with session clears previous cache', () async {
    when(() => remote.signUp('a@b.c', 'pw1234')).thenAnswer((_) async => sessionJson());
    final r = await repo.signUp(email: 'a@b.c', password: 'pw1234');
    expect(r.dataOrNull, isNotNull);
    verify(() => cache.clear()).called(1);
  });

  test('clearLocalData clears cache and session', () async {
    storage.session = testSession();
    await repo.clearLocalData();
    expect(storage.session, isNull);
    verify(() => cache.clear()).called(1);
    verifyNever(() => remote.signOut(any()));
  });

  test('signOut completes and clears cache when session read throws', () async {
    final throwingStorage = _ThrowingReadStorage();
    final repoWithThrowingStorage =
        AuthRepositoryImpl(remote: remote, sessionStorage: throwingStorage, cache: cache, networkInfo: network);
    await expectLater(repoWithThrowingStorage.signOut(), completes);
    verify(() => cache.clear()).called(1);
    verifyNever(() => remote.signOut(any()));
  });
}

class _ThrowingReadStorage extends InMemorySessionStorage {
  @override
  Future<AuthSession?> read() async => throw Exception('keystore');
}

class _ThrowingClearStorage extends InMemorySessionStorage {
  @override
  Future<void> clear() async => throw Exception('keystore');
}
