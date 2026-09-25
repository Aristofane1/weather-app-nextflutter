import 'package:dio/dio.dart';

/// Appels OpenWeatherMap. Retourne le JSON brut, qui est mis en cache tel quel.
class WeatherRemoteDataSource {
  WeatherRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchCurrent(double lat, double lon) async {
    final res = await _dio.get<Map<String, dynamic>>('/data/2.5/weather', queryParameters: {'lat': lat, 'lon': lon});
    return res.data!;
  }

  Future<Map<String, dynamic>> fetchForecast(double lat, double lon) async {
    final res = await _dio.get<Map<String, dynamic>>('/data/2.5/forecast', queryParameters: {'lat': lat, 'lon': lon});
    return res.data!;
  }
}
