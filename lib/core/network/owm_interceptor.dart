import 'package:dio/dio.dart';

/// Ajoute la clé API et les paramètres communs à toutes les requêtes OpenWeatherMap.
class OwmInterceptor extends Interceptor {
  OwmInterceptor(this.apiKey, {String Function()? language}) : _language = language ?? (() => 'fr');

  final String apiKey;
  final String Function() _language;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters = {
      ...options.queryParameters,
      'appid': apiKey,
      'units': 'metric',
      'lang': _language(),
    };
    handler.next(options);
  }
}
