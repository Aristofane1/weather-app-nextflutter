import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

@freezed
abstract class CurrentWeather with _$CurrentWeather {
  const factory CurrentWeather({
    required String cityName,
    required double temperature,
    required double feelsLike,
    required int humidity,
    required double windSpeed,
    required String description,
    required String iconCode,
    required DateTime date,
  }) = _CurrentWeather;
}

@freezed
abstract class ForecastEntry with _$ForecastEntry {
  const factory ForecastEntry({
    required DateTime date,
    required double temperature,
    required double tempMin,
    required double tempMax,
    required String description,
    required String iconCode,
  }) = _ForecastEntry;
}

@freezed
abstract class DailyForecast with _$DailyForecast {
  const factory DailyForecast({
    required DateTime day,
    required double tempMin,
    required double tempMax,
    required String description,
    required String iconCode,
  }) = _DailyForecast;
}

/// Regroupe les pas de 3 h par jour local. L'icône retenue est celle du créneau le plus proche de midi.
List<DailyForecast> groupByDay(List<ForecastEntry> entries) {
  final byDay = <DateTime, List<ForecastEntry>>{};
  for (final e in entries) {
    (byDay[DateTime(e.date.year, e.date.month, e.date.day)] ??= []).add(e);
  }
  final days = byDay.keys.toList()..sort();
  return [for (final day in days) _summarize(day, byDay[day]!)];
}

DailyForecast _summarize(DateTime day, List<ForecastEntry> items) {
  final midday = items.reduce((a, b) => (a.date.hour - 12).abs() <= (b.date.hour - 12).abs() ? a : b);
  return DailyForecast(
    day: day,
    tempMin: items.map((e) => e.tempMin).reduce(min),
    tempMax: items.map((e) => e.tempMax).reduce(max),
    description: midday.description,
    iconCode: midday.iconCode,
  );
}
