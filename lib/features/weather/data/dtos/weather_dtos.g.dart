// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WeatherConditionDto _$WeatherConditionDtoFromJson(Map<String, dynamic> json) =>
    _WeatherConditionDto(
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherConditionDtoToJson(
  _WeatherConditionDto instance,
) => <String, dynamic>{
  'description': instance.description,
  'icon': instance.icon,
};

_MainDto _$MainDtoFromJson(Map<String, dynamic> json) => _MainDto(
  temp: (json['temp'] as num).toDouble(),
  feelsLike: (json['feels_like'] as num).toDouble(),
  tempMin: (json['temp_min'] as num).toDouble(),
  tempMax: (json['temp_max'] as num).toDouble(),
  humidity: (json['humidity'] as num).toInt(),
);

Map<String, dynamic> _$MainDtoToJson(_MainDto instance) => <String, dynamic>{
  'temp': instance.temp,
  'feels_like': instance.feelsLike,
  'temp_min': instance.tempMin,
  'temp_max': instance.tempMax,
  'humidity': instance.humidity,
};

_WindDto _$WindDtoFromJson(Map<String, dynamic> json) =>
    _WindDto(speed: (json['speed'] as num).toDouble());

Map<String, dynamic> _$WindDtoToJson(_WindDto instance) => <String, dynamic>{
  'speed': instance.speed,
};

_CurrentWeatherDto _$CurrentWeatherDtoFromJson(Map<String, dynamic> json) =>
    _CurrentWeatherDto(
      name: json['name'] as String,
      dt: (json['dt'] as num).toInt(),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherConditionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      main: MainDto.fromJson(json['main'] as Map<String, dynamic>),
      wind: WindDto.fromJson(json['wind'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CurrentWeatherDtoToJson(_CurrentWeatherDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'dt': instance.dt,
      'weather': instance.weather,
      'main': instance.main,
      'wind': instance.wind,
    };

_ForecastItemDto _$ForecastItemDtoFromJson(Map<String, dynamic> json) =>
    _ForecastItemDto(
      dt: (json['dt'] as num).toInt(),
      main: MainDto.fromJson(json['main'] as Map<String, dynamic>),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherConditionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      wind: WindDto.fromJson(json['wind'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForecastItemDtoToJson(_ForecastItemDto instance) =>
    <String, dynamic>{
      'dt': instance.dt,
      'main': instance.main,
      'weather': instance.weather,
      'wind': instance.wind,
    };

_ForecastDto _$ForecastDtoFromJson(Map<String, dynamic> json) => _ForecastDto(
  list: (json['list'] as List<dynamic>)
      .map((e) => ForecastItemDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ForecastDtoToJson(_ForecastDto instance) =>
    <String, dynamic>{'list': instance.list};
