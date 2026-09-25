import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/core_providers.dart';
import '../../../core/repository/base_repository.dart';
import '../../../core/result/result.dart';
import '../domain/weather.dart';
import '../domain/weather_repository.dart';
import 'dtos/weather_dtos.dart';
import 'weather_remote_data_source.dart';

part 'weather_repository_impl.g.dart';

class WeatherRepositoryImpl extends BaseRepository implements WeatherRepository {
  WeatherRepositoryImpl({required this.remote, required super.cache, required super.networkInfo});

  final WeatherRemoteDataSource remote;

  @override
  Stream<Result<CurrentWeather>> watchCurrent({required double lat, required double lon}) => offlineFirst(
        cacheKey: 'weather:current:${_coords(lat, lon)}',
        fetch: () => remote.fetchCurrent(lat, lon),
        parse: (json) => CurrentWeatherDto.fromJson(json as Map<String, dynamic>).toEntity(),
      );

  @override
  Stream<Result<List<ForecastEntry>>> watchForecast({required double lat, required double lon}) => offlineFirst(
        cacheKey: 'weather:forecast:${_coords(lat, lon)}',
        fetch: () => remote.fetchForecast(lat, lon),
        parse: (json) =>
            ForecastDto.fromJson(json as Map<String, dynamic>).list.map((item) => item.toEntity()).toList(),
      );

  /// Arrondi à ~1 km : une même ville partage son entrée de cache.
  static String _coords(double lat, double lon) => '${lat.toStringAsFixed(2)},${lon.toStringAsFixed(2)}';
}

@Riverpod(keepAlive: true)
WeatherRepository weatherRepository(Ref ref) => WeatherRepositoryImpl(
      remote: WeatherRemoteDataSource(ref.watch(owmDioProvider)),
      cache: ref.watch(cacheStoreProvider),
      networkInfo: ref.watch(networkInfoProvider),
    );
