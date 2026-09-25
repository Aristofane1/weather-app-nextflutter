// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CityDto _$CityDtoFromJson(Map<String, dynamic> json) => _CityDto(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String,
  country: json['country'] as String?,
  state: json['state'] as String?,
  lat: (json['lat'] as num).toDouble(),
  lon: (json['lon'] as num).toDouble(),
);

Map<String, dynamic> _$CityDtoToJson(_CityDto instance) => <String, dynamic>{
  'id': ?instance.id,
  'name': instance.name,
  'country': instance.country,
  'state': instance.state,
  'lat': instance.lat,
  'lon': instance.lon,
};
