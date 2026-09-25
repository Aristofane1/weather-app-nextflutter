import '../../../core/result/result.dart';
import 'weather.dart';

abstract interface class WeatherRepository {
  Stream<Result<CurrentWeather>> watchCurrent({required double lat, required double lon});
  Stream<Result<List<ForecastEntry>>> watchForecast({required double lat, required double lon});
}
