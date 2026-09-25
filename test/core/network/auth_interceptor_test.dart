import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/auth_interceptor.dart';
import 'package:weather_app/core/storage/auth_session.dart';

import '../../helpers/fakes.dart';

void main() {
  late InMemorySessionStorage storage;
  late FakeAdapter adapter;
  late Dio dio;
  late int refreshCalls;
  late int expiredCalls;
  late Future<AuthSession> Function(String refreshToken) refresh;

  DioException refreshError(DioExceptionType type, {int? status}) {
    final options = RequestOptions(path: '/auth/v1/token');
    return DioException(
      requestOptions: options,
      type: type,
      response: status == null ? null : Response<dynamic>(requestOptions: options, statusCode: status),
    );
  }

  void build(ResponseBody Function(RequestOptions) handler) {
    adapter = FakeAdapter(handler);
    dio = Dio(BaseOptions(baseUrl: 'https://test.local'))..httpClientAdapter = adapter;
    dio.interceptors.add(AuthInterceptor(
      retryDio: Dio(BaseOptions(baseUrl: 'https://test.local'))..httpClientAdapter = adapter,
      storage: storage,
      refresh: (token) {
        refreshCalls++;
        return refresh(token);
      },
      onSessionExpired: () => expiredCalls++,
    ));
  }

  ResponseBody okOnlyWithNewToken(RequestOptions o) =>
      o.headers['Authorization'] == 'Bearer new' ? jsonBody(200, {'ok': true}) : jsonBody(401, {'message': 'JWT expired'});

  setUp(() {
    storage = InMemorySessionStorage(testSession());
    refreshCalls = 0;
    expiredCalls = 0;
    refresh = (_) async => testSession(access: 'new');
  });

  test('adds bearer header from stored session', () async {
    build((_) => jsonBody(200, {}));
    await dio.get<dynamic>('/rest/v1/x');
    expect(adapter.requests.single.headers['Authorization'], 'Bearer old');
  });

  test('no session: no Authorization header', () async {
    storage.session = null;
    build((_) => jsonBody(200, {}));
    await dio.get<dynamic>('/rest/v1/x');
    expect(adapter.requests.single.headers.containsKey('Authorization'), isFalse);
  });

  test('401 refreshes session and replays request', () async {
    build(okOnlyWithNewToken);
    final res = await dio.get<dynamic>('/rest/v1/x');
    expect(res.statusCode, 200);
    expect(refreshCalls, 1);
    expect(storage.session!.accessToken, 'new');
    expect(adapter.requests.last.headers['Authorization'], 'Bearer new');
  });

  test('concurrent 401s refresh once', () async {
    build(okOnlyWithNewToken);
    final results = await Future.wait([dio.get<dynamic>('/a'), dio.get<dynamic>('/b')]);
    expect(results.map((r) => r.statusCode), [200, 200]);
    expect(refreshCalls, 1);
  });

  test('refresh rejected: clears session, notifies, propagates 401', () async {
    refresh = (_) async => throw refreshError(DioExceptionType.badResponse, status: 400);
    build((_) => jsonBody(401, {}));
    await expectLater(
      dio.get<dynamic>('/rest/v1/x'),
      throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'status', 401)),
    );
    expect(storage.session, isNull);
    expect(expiredCalls, 1);
  });

  test('expired session + network failure keeps session', () async {
    storage.session = testSession(expiresAt: DateTime.now().subtract(const Duration(minutes: 5)));
    refresh = (_) async => throw refreshError(DioExceptionType.connectionError);
    build((_) => jsonBody(200, {}));
    await dio.get<dynamic>('/rest/v1/x');
    expect(storage.session, isNotNull);
    expect(expiredCalls, 0);
    expect(adapter.requests.single.headers['Authorization'], 'Bearer old');
  });

  test('replayed request failing again does not loop', () async {
    build((_) => jsonBody(401, {}));
    await expectLater(dio.get<dynamic>('/rest/v1/x'), throwsA(isA<DioException>()));
    expect(refreshCalls, 1);
    expect(adapter.requests, hasLength(2));
  });

  test('expired session + refresh rejected: request rejected with 401, nothing sent', () async {
    storage.session = testSession(expiresAt: DateTime.now().subtract(const Duration(minutes: 5)));
    refresh = (_) async => throw refreshError(DioExceptionType.badResponse, status: 400);
    build((_) => jsonBody(200, {}));
    await expectLater(
      dio.get<dynamic>('/rest/v1/x'),
      throwsA(isA<DioException>().having((e) => e.response?.statusCode, 'status', 401)),
    );
    expect(adapter.requests, isEmpty);
    expect(storage.session, isNull);
    expect(expiredCalls, 1);
  });

  test('expired session + refresh succeeds: request sent with new token', () async {
    storage.session = testSession(expiresAt: DateTime.now().subtract(const Duration(minutes: 5)));
    build((_) => jsonBody(200, {}));
    final res = await dio.get<dynamic>('/rest/v1/x');
    expect(res.statusCode, 200);
    expect(refreshCalls, 1);
    expect(storage.session!.accessToken, 'new');
    expect(adapter.requests.single.headers['Authorization'], 'Bearer new');
  });
}
