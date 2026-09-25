import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/weather.dart';

part 'weather_dtos.freezed.dart';
part 'weather_dtos.g.dart';

@freezed
abstract class WeatherConditionDto with _$WeatherConditionDto {
  const factory WeatherConditionDto({required String description, required String icon}) = _WeatherConditionDto;

  factory WeatherConditionDto.fromJson(Map<String, dynamic> json) => _$WeatherConditionDtoFromJson(json);
}

@freezed
abstract class MainDto with _$MainDto {
  const factory MainDto({
    required double temp,
    @JsonKey(name: 'feels_like') required double feelsLike,
    @JsonKey(name: 'temp_min') required double tempMin,
    @JsonKey(name: 'temp_max') required double tempMax,
    required int humidity,
  }) = _MainDto;

  factory MainDto.fromJson(Map<String, dynamic> json) => _$MainDtoFromJson(json);
}

@freezed
abstract class WindDto with _$WindDto {
  const factory WindDto({required double speed}) = _WindDto;

  factory WindDto.fromJson(Map<String, dynamic> json) => _$WindDtoFromJson(json);
}

/// `GET /data/2.5/weather`
@freezed
abstract class CurrentWeatherDto with _$CurrentWeatherDto {
  const factory CurrentWeatherDto({
    required String name,
    required int dt,
    required List<WeatherConditionDto> weather,
    required MainDto main,
    required WindDto wind,
  }) = _CurrentWeatherDto;

  factory CurrentWeatherDto.fromJson(Map<String, dynamic> json) => _$CurrentWeatherDtoFromJson(json);
}

@freezed
abstract class ForecastItemDto with _$ForecastItemDto {
  const factory ForecastItemDto({
    required int dt,
    required MainDto main,
    required List<WeatherConditionDto> weather,
    required WindDto wind,
  }) = _ForecastItemDto;

  factory ForecastItemDto.fromJson(Map<String, dynamic> json) => _$ForecastItemDtoFromJson(json);
}

/// `GET /data/2.5/forecast`
@freezed
abstract class ForecastDto with _$ForecastDto {
  const factory ForecastDto({required List<ForecastItemDto> list}) = _ForecastDto;

  factory ForecastDto.fromJson(Map<String, dynamic> json) => _$ForecastDtoFromJson(json);
}

DateTime _fromUnix(int seconds) => DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

extension CurrentWeatherDtoMapper on CurrentWeatherDto {
  CurrentWeather toEntity() => CurrentWeather(
        cityName: name,
        temperature: main.temp,
        feelsLike: main.feelsLike,
        humidity: main.humidity,
        windSpeed: wind.speed,
        description: weather.firstOrNull?.description ?? '',
        iconCode: weather.firstOrNull?.icon ?? '01d',
        date: _fromUnix(dt),
      );
}

extension ForecastItemDtoMapper on ForecastItemDto {
  ForecastEntry toEntity() => ForecastEntry(
        date: _fromUnix(dt),
        temperature: main.temp,
        tempMin: main.tempMin,
        tempMax: main.tempMax,
        description: weather.firstOrNull?.description ?? '',
        iconCode: weather.firstOrNull?.icon ?? '01d',
      );
}
