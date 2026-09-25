import 'package:dio/dio.dart';

/// Ajoute la clé API et les paramètres communs à toutes les requêtes OpenWeatherMap.
class OwmInterceptor extends Interceptor {
  OwmInterceptor(this.apiKey);

  final String apiKey;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters = {
      ...options.queryParameters,
      'appid': apiKey,
      'units': 'metric',
      'lang': 'fr',
    };
    handler.next(options);
  }
}
