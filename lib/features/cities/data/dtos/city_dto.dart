import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/city.dart';

part 'city_dto.freezed.dart';
part 'city_dto.g.dart';

/// Format partagé par le geocoding OWM et la table Supabase `favorite_cities`.
@freezed
abstract class CityDto with _$CityDto {
  const factory CityDto({
    @JsonKey(includeIfNull: false) int? id,
    required String name,
    String? country,
    String? state,
    required double lat,
    required double lon,
  }) = _CityDto;

  factory CityDto.fromJson(Map<String, dynamic> json) => _$CityDtoFromJson(json);
}

extension CityDtoMapper on CityDto {
  City toEntity() => City(id: id, name: name, country: country, state: state, lat: lat, lon: lon);
}

extension CityMapper on City {
  CityDto toDto() => CityDto(id: id, name: name, country: country, state: state, lat: lat, lon: lon);
}
