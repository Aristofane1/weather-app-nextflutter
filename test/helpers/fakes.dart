import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/cache/cache_store.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/core/storage/auth_session.dart';
import 'package:weather_app/core/storage/session_storage.dart';

class MockCacheStore extends Mock implements CacheStore {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void registerFallbacks() {
  registerFallbackValue(Object());
}

/// Cache vide qui accepte toutes les écritures.
void stubEmptyCache(MockCacheStore cache) {
  when(() => cache.read(any())).thenAnswer((_) async => null);
  when(() => cache.write(any(), any())).thenAnswer((_) async {});
  when(() => cache.delete(any())).thenAnswer((_) async {});
  when(() => cache.clear()).thenAnswer((_) async {});
}

class InMemorySessionStorage implements SessionStorage {
  InMemorySessionStorage([this.session]);

  AuthSession? session;

  @override
  Future<AuthSession?> read() async => session;

  @override
  Future<void> save(AuthSession value) async => session = value;

  @override
  Future<void> clear() async => session = null;
}

AuthSession testSession({String access = 'old', DateTime? expiresAt}) => AuthSession(
      accessToken: access,
      refreshToken: 'refresh-$access',
      expiresAt: expiresAt ?? DateTime.now().add(const Duration(hours: 1)),
      userId: 'u1',
      email: 'a@b.c',
    );

ResponseBody jsonBody(int status, Object body) => ResponseBody.fromString(
      jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

/// Adaptateur HTTP factice : enregistre les requêtes et répond via [handler].
class FakeAdapter implements HttpClientAdapter {
  FakeAdapter(this.handler);

  final ResponseBody Function(RequestOptions options) handler;
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}
