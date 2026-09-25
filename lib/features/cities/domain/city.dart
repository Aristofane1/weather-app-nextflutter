import 'package:freezed_annotation/freezed_annotation.dart';

part 'city.freezed.dart';

@freezed
abstract class City with _$City {
  const City._();

  /// `id` n'est renseigné que pour un favori stocké dans Supabase.
  const factory City({
    int? id,
    required String name,
    String? country,
    String? state,
    required double lat,
    required double lon,
  }) = _City;

  /// Même ville si les coordonnées coïncident à ~1 km près.
  bool sameLocation(City other) => (lat - other.lat).abs() < 0.01 && (lon - other.lon).abs() < 0.01;

  String get subtitle => [state, country].whereType<String>().where((s) => s.isNotEmpty).join(', ');
}
