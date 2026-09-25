import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/result/result.dart';
import '../data/weather_repository_impl.dart';
import '../domain/weather.dart';

part 'weather_providers.g.dart';

@riverpod
Stream<Result<CurrentWeather>> currentWeather(Ref ref, double lat, double lon) =>
    ref.watch(weatherRepositoryProvider).watchCurrent(lat: lat, lon: lon);

@riverpod
Stream<Result<List<DailyForecast>>> dailyForecast(Ref ref, double lat, double lon) => ref
    .watch(weatherRepositoryProvider)
    .watchForecast(lat: lat, lon: lon)
    .map((result) => result.map(groupByDay));
