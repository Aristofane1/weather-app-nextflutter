import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/owm_interceptor.dart';

import '../../helpers/fakes.dart';

void main() {
  test('adds appid, metric units and french language', () async {
    final adapter = FakeAdapter((_) => jsonBody(200, {}));
    final dio = Dio(BaseOptions(baseUrl: 'https://owm.test'))
      ..httpClientAdapter = adapter
      ..interceptors.add(OwmInterceptor('KEY'));
    await dio.get<dynamic>('/data/2.5/weather', queryParameters: {'lat': 1.0});
    final q = adapter.requests.single.queryParameters;
    expect(q, containsPair('appid', 'KEY'));
    expect(q, containsPair('units', 'metric'));
    expect(q, containsPair('lang', 'fr'));
    expect(q, containsPair('lat', 1.0));
  });

  test('uses the provided language', () async {
    final adapter = FakeAdapter((_) => jsonBody(200, {}));
    final dio = Dio(BaseOptions(baseUrl: 'https://owm.test'))
      ..httpClientAdapter = adapter
      ..interceptors.add(OwmInterceptor('KEY', language: () => 'en'));
    await dio.get<dynamic>('/data/2.5/weather');
    expect(adapter.requests.single.queryParameters, containsPair('lang', 'en'));
  });
}
