// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherConditionDto {

 String get description; String get icon;
/// Create a copy of WeatherConditionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherConditionDtoCopyWith<WeatherConditionDto> get copyWith => _$WeatherConditionDtoCopyWithImpl<WeatherConditionDto>(this as WeatherConditionDto, _$identity);

  /// Serializes this WeatherConditionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherConditionDto&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,icon);

@override
String toString() {
  return 'WeatherConditionDto(description: $description, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $WeatherConditionDtoCopyWith<$Res>  {
  factory $WeatherConditionDtoCopyWith(WeatherConditionDto value, $Res Function(WeatherConditionDto) _then) = _$WeatherConditionDtoCopyWithImpl;
@useResult
$Res call({
 String description, String icon
});




}
/// @nodoc
class _$WeatherConditionDtoCopyWithImpl<$Res>
    implements $WeatherConditionDtoCopyWith<$Res> {
  _$WeatherConditionDtoCopyWithImpl(this._self, this._then);

  final WeatherConditionDto _self;
  final $Res Function(WeatherConditionDto) _then;

/// Create a copy of WeatherConditionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? description = null,Object? icon = null,}) {
  return _then(_self.copyWith(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherConditionDto].
extension WeatherConditionDtoPatterns on WeatherConditionDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherConditionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherConditionDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherConditionDto value)  $default,){
final _that = this;
switch (_that) {
case _WeatherConditionDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherConditionDto value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherConditionDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String description,  String icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherConditionDto() when $default != null:
return $default(_that.description,_that.icon);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String description,  String icon)  $default,) {final _that = this;
switch (_that) {
case _WeatherConditionDto():
return $default(_that.description,_that.icon);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String description,  String icon)?  $default,) {final _that = this;
switch (_that) {
case _WeatherConditionDto() when $default != null:
return $default(_that.description,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherConditionDto implements WeatherConditionDto {
  const _WeatherConditionDto({required this.description, required this.icon});
  factory _WeatherConditionDto.fromJson(Map<String, dynamic> json) => _$WeatherConditionDtoFromJson(json);

@override final  String description;
@override final  String icon;

/// Create a copy of WeatherConditionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherConditionDtoCopyWith<_WeatherConditionDto> get copyWith => __$WeatherConditionDtoCopyWithImpl<_WeatherConditionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherConditionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherConditionDto&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,description,icon);

@override
String toString() {
  return 'WeatherConditionDto(description: $description, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$WeatherConditionDtoCopyWith<$Res> implements $WeatherConditionDtoCopyWith<$Res> {
  factory _$WeatherConditionDtoCopyWith(_WeatherConditionDto value, $Res Function(_WeatherConditionDto) _then) = __$WeatherConditionDtoCopyWithImpl;
@override @useResult
$Res call({
 String description, String icon
});




}
/// @nodoc
class __$WeatherConditionDtoCopyWithImpl<$Res>
    implements _$WeatherConditionDtoCopyWith<$Res> {
  __$WeatherConditionDtoCopyWithImpl(this._self, this._then);

  final _WeatherConditionDto _self;
  final $Res Function(_WeatherConditionDto) _then;

/// Create a copy of WeatherConditionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? description = null,Object? icon = null,}) {
  return _then(_WeatherConditionDto(
description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$MainDto {

 double get temp;@JsonKey(name: 'feels_like') double get feelsLike;@JsonKey(name: 'temp_min') double get tempMin;@JsonKey(name: 'temp_max') double get tempMax; int get humidity;
/// Create a copy of MainDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainDtoCopyWith<MainDto> get copyWith => _$MainDtoCopyWithImpl<MainDto>(this as MainDto, _$identity);

  /// Serializes this MainDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainDto&&(identical(other.temp, temp) || other.temp == temp)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.tempMin, tempMin) || other.tempMin == tempMin)&&(identical(other.tempMax, tempMax) || other.tempMax == tempMax)&&(identical(other.humidity, humidity) || other.humidity == humidity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,temp,feelsLike,tempMin,tempMax,humidity);

@override
String toString() {
  return 'MainDto(temp: $temp, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, humidity: $humidity)';
}


}

/// @nodoc
abstract mixin class $MainDtoCopyWith<$Res>  {
  factory $MainDtoCopyWith(MainDto value, $Res Function(MainDto) _then) = _$MainDtoCopyWithImpl;
@useResult
$Res call({
 double temp,@JsonKey(name: 'feels_like') double feelsLike,@JsonKey(name: 'temp_min') double tempMin,@JsonKey(name: 'temp_max') double tempMax, int humidity
});




}
/// @nodoc
class _$MainDtoCopyWithImpl<$Res>
    implements $MainDtoCopyWith<$Res> {
  _$MainDtoCopyWithImpl(this._self, this._then);

  final MainDto _self;
  final $Res Function(MainDto) _then;

/// Create a copy of MainDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? temp = null,Object? feelsLike = null,Object? tempMin = null,Object? tempMax = null,Object? humidity = null,}) {
  return _then(_self.copyWith(
temp: null == temp ? _self.temp : temp // ignore: cast_nullable_to_non_nullable
as double,feelsLike: null == feelsLike ? _self.feelsLike : feelsLike // ignore: cast_nullable_to_non_nullable
as double,tempMin: null == tempMin ? _self.tempMin : tempMin // ignore: cast_nullable_to_non_nullable
as double,tempMax: null == tempMax ? _self.tempMax : tempMax // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MainDto].
extension MainDtoPatterns on MainDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MainDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MainDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MainDto value)  $default,){
final _that = this;
switch (_that) {
case _MainDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MainDto value)?  $default,){
final _that = this;
switch (_that) {
case _MainDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double temp, @JsonKey(name: 'feels_like')  double feelsLike, @JsonKey(name: 'temp_min')  double tempMin, @JsonKey(name: 'temp_max')  double tempMax,  int humidity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MainDto() when $default != null:
return $default(_that.temp,_that.feelsLike,_that.tempMin,_that.tempMax,_that.humidity);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double temp, @JsonKey(name: 'feels_like')  double feelsLike, @JsonKey(name: 'temp_min')  double tempMin, @JsonKey(name: 'temp_max')  double tempMax,  int humidity)  $default,) {final _that = this;
switch (_that) {
case _MainDto():
return $default(_that.temp,_that.feelsLike,_that.tempMin,_that.tempMax,_that.humidity);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double temp, @JsonKey(name: 'feels_like')  double feelsLike, @JsonKey(name: 'temp_min')  double tempMin, @JsonKey(name: 'temp_max')  double tempMax,  int humidity)?  $default,) {final _that = this;
switch (_that) {
case _MainDto() when $default != null:
return $default(_that.temp,_that.feelsLike,_that.tempMin,_that.tempMax,_that.humidity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MainDto implements MainDto {
  const _MainDto({required this.temp, @JsonKey(name: 'feels_like') required this.feelsLike, @JsonKey(name: 'temp_min') required this.tempMin, @JsonKey(name: 'temp_max') required this.tempMax, required this.humidity});
  factory _MainDto.fromJson(Map<String, dynamic> json) => _$MainDtoFromJson(json);

@override final  double temp;
@override@JsonKey(name: 'feels_like') final  double feelsLike;
@override@JsonKey(name: 'temp_min') final  double tempMin;
@override@JsonKey(name: 'temp_max') final  double tempMax;
@override final  int humidity;

/// Create a copy of MainDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MainDtoCopyWith<_MainDto> get copyWith => __$MainDtoCopyWithImpl<_MainDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MainDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MainDto&&(identical(other.temp, temp) || other.temp == temp)&&(identical(other.feelsLike, feelsLike) || other.feelsLike == feelsLike)&&(identical(other.tempMin, tempMin) || other.tempMin == tempMin)&&(identical(other.tempMax, tempMax) || other.tempMax == tempMax)&&(identical(other.humidity, humidity) || other.humidity == humidity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,temp,feelsLike,tempMin,tempMax,humidity);

@override
String toString() {
  return 'MainDto(temp: $temp, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, humidity: $humidity)';
}


}

/// @nodoc
abstract mixin class _$MainDtoCopyWith<$Res> implements $MainDtoCopyWith<$Res> {
  factory _$MainDtoCopyWith(_MainDto value, $Res Function(_MainDto) _then) = __$MainDtoCopyWithImpl;
@override @useResult
$Res call({
 double temp,@JsonKey(name: 'feels_like') double feelsLike,@JsonKey(name: 'temp_min') double tempMin,@JsonKey(name: 'temp_max') double tempMax, int humidity
});




}
/// @nodoc
class __$MainDtoCopyWithImpl<$Res>
    implements _$MainDtoCopyWith<$Res> {
  __$MainDtoCopyWithImpl(this._self, this._then);

  final _MainDto _self;
  final $Res Function(_MainDto) _then;

/// Create a copy of MainDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? temp = null,Object? feelsLike = null,Object? tempMin = null,Object? tempMax = null,Object? humidity = null,}) {
  return _then(_MainDto(
temp: null == temp ? _self.temp : temp // ignore: cast_nullable_to_non_nullable
as double,feelsLike: null == feelsLike ? _self.feelsLike : feelsLike // ignore: cast_nullable_to_non_nullable
as double,tempMin: null == tempMin ? _self.tempMin : tempMin // ignore: cast_nullable_to_non_nullable
as double,tempMax: null == tempMax ? _self.tempMax : tempMax // ignore: cast_nullable_to_non_nullable
as double,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$WindDto {

 double get speed;
/// Create a copy of WindDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WindDtoCopyWith<WindDto> get copyWith => _$WindDtoCopyWithImpl<WindDto>(this as WindDto, _$identity);

  /// Serializes this WindDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WindDto&&(identical(other.speed, speed) || other.speed == speed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speed);

@override
String toString() {
  return 'WindDto(speed: $speed)';
}


}

/// @nodoc
abstract mixin class $WindDtoCopyWith<$Res>  {
  factory $WindDtoCopyWith(WindDto value, $Res Function(WindDto) _then) = _$WindDtoCopyWithImpl;
@useResult
$Res call({
 double speed
});




}
/// @nodoc
class _$WindDtoCopyWithImpl<$Res>
    implements $WindDtoCopyWith<$Res> {
  _$WindDtoCopyWithImpl(this._self, this._then);

  final WindDto _self;
  final $Res Function(WindDto) _then;

/// Create a copy of WindDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? speed = null,}) {
  return _then(_self.copyWith(
speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [WindDto].
extension WindDtoPatterns on WindDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WindDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WindDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WindDto value)  $default,){
final _that = this;
switch (_that) {
case _WindDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WindDto value)?  $default,){
final _that = this;
switch (_that) {
case _WindDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double speed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WindDto() when $default != null:
return $default(_that.speed);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double speed)  $default,) {final _that = this;
switch (_that) {
case _WindDto():
return $default(_that.speed);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double speed)?  $default,) {final _that = this;
switch (_that) {
case _WindDto() when $default != null:
return $default(_that.speed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WindDto implements WindDto {
  const _WindDto({required this.speed});
  factory _WindDto.fromJson(Map<String, dynamic> json) => _$WindDtoFromJson(json);

@override final  double speed;

/// Create a copy of WindDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WindDtoCopyWith<_WindDto> get copyWith => __$WindDtoCopyWithImpl<_WindDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WindDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WindDto&&(identical(other.speed, speed) || other.speed == speed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,speed);

@override
String toString() {
  return 'WindDto(speed: $speed)';
}


}

/// @nodoc
abstract mixin class _$WindDtoCopyWith<$Res> implements $WindDtoCopyWith<$Res> {
  factory _$WindDtoCopyWith(_WindDto value, $Res Function(_WindDto) _then) = __$WindDtoCopyWithImpl;
@override @useResult
$Res call({
 double speed
});




}
/// @nodoc
class __$WindDtoCopyWithImpl<$Res>
    implements _$WindDtoCopyWith<$Res> {
  __$WindDtoCopyWithImpl(this._self, this._then);

  final _WindDto _self;
  final $Res Function(_WindDto) _then;

/// Create a copy of WindDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? speed = null,}) {
  return _then(_WindDto(
speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CurrentWeatherDto {

 String get name; int get dt; List<WeatherConditionDto> get weather; MainDto get main; WindDto get wind;
/// Create a copy of CurrentWeatherDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentWeatherDtoCopyWith<CurrentWeatherDto> get copyWith => _$CurrentWeatherDtoCopyWithImpl<CurrentWeatherDto>(this as CurrentWeatherDto, _$identity);

  /// Serializes this CurrentWeatherDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentWeatherDto&&(identical(other.name, name) || other.name == name)&&(identical(other.dt, dt) || other.dt == dt)&&const DeepCollectionEquality().equals(other.weather, weather)&&(identical(other.main, main) || other.main == main)&&(identical(other.wind, wind) || other.wind == wind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,dt,const DeepCollectionEquality().hash(weather),main,wind);

@override
String toString() {
  return 'CurrentWeatherDto(name: $name, dt: $dt, weather: $weather, main: $main, wind: $wind)';
}


}

/// @nodoc
abstract mixin class $CurrentWeatherDtoCopyWith<$Res>  {
  factory $CurrentWeatherDtoCopyWith(CurrentWeatherDto value, $Res Function(CurrentWeatherDto) _then) = _$CurrentWeatherDtoCopyWithImpl;
@useResult
$Res call({
 String name, int dt, List<WeatherConditionDto> weather, MainDto main, WindDto wind
});


$MainDtoCopyWith<$Res> get main;$WindDtoCopyWith<$Res> get wind;

}
/// @nodoc
class _$CurrentWeatherDtoCopyWithImpl<$Res>
    implements $CurrentWeatherDtoCopyWith<$Res> {
  _$CurrentWeatherDtoCopyWithImpl(this._self, this._then);

  final CurrentWeatherDto _self;
  final $Res Function(CurrentWeatherDto) _then;

/// Create a copy of CurrentWeatherDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? dt = null,Object? weather = null,Object? main = null,Object? wind = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dt: null == dt ? _self.dt : dt // ignore: cast_nullable_to_non_nullable
as int,weather: null == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as List<WeatherConditionDto>,main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as MainDto,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as WindDto,
  ));
}
/// Create a copy of CurrentWeatherDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MainDtoCopyWith<$Res> get main {
  
  return $MainDtoCopyWith<$Res>(_self.main, (value) {
    return _then(_self.copyWith(main: value));
  });
}/// Create a copy of CurrentWeatherDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WindDtoCopyWith<$Res> get wind {
  
  return $WindDtoCopyWith<$Res>(_self.wind, (value) {
    return _then(_self.copyWith(wind: value));
  });
}
}


/// Adds pattern-matching-related methods to [CurrentWeatherDto].
extension CurrentWeatherDtoPatterns on CurrentWeatherDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentWeatherDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentWeatherDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentWeatherDto value)  $default,){
final _that = this;
switch (_that) {
case _CurrentWeatherDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentWeatherDto value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentWeatherDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int dt,  List<WeatherConditionDto> weather,  MainDto main,  WindDto wind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentWeatherDto() when $default != null:
return $default(_that.name,_that.dt,_that.weather,_that.main,_that.wind);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int dt,  List<WeatherConditionDto> weather,  MainDto main,  WindDto wind)  $default,) {final _that = this;
switch (_that) {
case _CurrentWeatherDto():
return $default(_that.name,_that.dt,_that.weather,_that.main,_that.wind);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int dt,  List<WeatherConditionDto> weather,  MainDto main,  WindDto wind)?  $default,) {final _that = this;
switch (_that) {
case _CurrentWeatherDto() when $default != null:
return $default(_that.name,_that.dt,_that.weather,_that.main,_that.wind);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentWeatherDto implements CurrentWeatherDto {
  const _CurrentWeatherDto({required this.name, required this.dt, required final  List<WeatherConditionDto> weather, required this.main, required this.wind}): _weather = weather;
  factory _CurrentWeatherDto.fromJson(Map<String, dynamic> json) => _$CurrentWeatherDtoFromJson(json);

@override final  String name;
@override final  int dt;
 final  List<WeatherConditionDto> _weather;
@override List<WeatherConditionDto> get weather {
  if (_weather is EqualUnmodifiableListView) return _weather;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weather);
}

@override final  MainDto main;
@override final  WindDto wind;

/// Create a copy of CurrentWeatherDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentWeatherDtoCopyWith<_CurrentWeatherDto> get copyWith => __$CurrentWeatherDtoCopyWithImpl<_CurrentWeatherDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentWeatherDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentWeatherDto&&(identical(other.name, name) || other.name == name)&&(identical(other.dt, dt) || other.dt == dt)&&const DeepCollectionEquality().equals(other._weather, _weather)&&(identical(other.main, main) || other.main == main)&&(identical(other.wind, wind) || other.wind == wind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,dt,const DeepCollectionEquality().hash(_weather),main,wind);

@override
String toString() {
  return 'CurrentWeatherDto(name: $name, dt: $dt, weather: $weather, main: $main, wind: $wind)';
}


}

/// @nodoc
abstract mixin class _$CurrentWeatherDtoCopyWith<$Res> implements $CurrentWeatherDtoCopyWith<$Res> {
  factory _$CurrentWeatherDtoCopyWith(_CurrentWeatherDto value, $Res Function(_CurrentWeatherDto) _then) = __$CurrentWeatherDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, int dt, List<WeatherConditionDto> weather, MainDto main, WindDto wind
});


@override $MainDtoCopyWith<$Res> get main;@override $WindDtoCopyWith<$Res> get wind;

}
/// @nodoc
class __$CurrentWeatherDtoCopyWithImpl<$Res>
    implements _$CurrentWeatherDtoCopyWith<$Res> {
  __$CurrentWeatherDtoCopyWithImpl(this._self, this._then);

  final _CurrentWeatherDto _self;
  final $Res Function(_CurrentWeatherDto) _then;

/// Create a copy of CurrentWeatherDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? dt = null,Object? weather = null,Object? main = null,Object? wind = null,}) {
  return _then(_CurrentWeatherDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,dt: null == dt ? _self.dt : dt // ignore: cast_nullable_to_non_nullable
as int,weather: null == weather ? _self._weather : weather // ignore: cast_nullable_to_non_nullable
as List<WeatherConditionDto>,main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as MainDto,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as WindDto,
  ));
}

/// Create a copy of CurrentWeatherDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MainDtoCopyWith<$Res> get main {
  
  return $MainDtoCopyWith<$Res>(_self.main, (value) {
    return _then(_self.copyWith(main: value));
  });
}/// Create a copy of CurrentWeatherDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WindDtoCopyWith<$Res> get wind {
  
  return $WindDtoCopyWith<$Res>(_self.wind, (value) {
    return _then(_self.copyWith(wind: value));
  });
}
}


/// @nodoc
mixin _$ForecastItemDto {

 int get dt; MainDto get main; List<WeatherConditionDto> get weather; WindDto get wind;
/// Create a copy of ForecastItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForecastItemDtoCopyWith<ForecastItemDto> get copyWith => _$ForecastItemDtoCopyWithImpl<ForecastItemDto>(this as ForecastItemDto, _$identity);

  /// Serializes this ForecastItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForecastItemDto&&(identical(other.dt, dt) || other.dt == dt)&&(identical(other.main, main) || other.main == main)&&const DeepCollectionEquality().equals(other.weather, weather)&&(identical(other.wind, wind) || other.wind == wind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dt,main,const DeepCollectionEquality().hash(weather),wind);

@override
String toString() {
  return 'ForecastItemDto(dt: $dt, main: $main, weather: $weather, wind: $wind)';
}


}

/// @nodoc
abstract mixin class $ForecastItemDtoCopyWith<$Res>  {
  factory $ForecastItemDtoCopyWith(ForecastItemDto value, $Res Function(ForecastItemDto) _then) = _$ForecastItemDtoCopyWithImpl;
@useResult
$Res call({
 int dt, MainDto main, List<WeatherConditionDto> weather, WindDto wind
});


$MainDtoCopyWith<$Res> get main;$WindDtoCopyWith<$Res> get wind;

}
/// @nodoc
class _$ForecastItemDtoCopyWithImpl<$Res>
    implements $ForecastItemDtoCopyWith<$Res> {
  _$ForecastItemDtoCopyWithImpl(this._self, this._then);

  final ForecastItemDto _self;
  final $Res Function(ForecastItemDto) _then;

/// Create a copy of ForecastItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dt = null,Object? main = null,Object? weather = null,Object? wind = null,}) {
  return _then(_self.copyWith(
dt: null == dt ? _self.dt : dt // ignore: cast_nullable_to_non_nullable
as int,main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as MainDto,weather: null == weather ? _self.weather : weather // ignore: cast_nullable_to_non_nullable
as List<WeatherConditionDto>,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as WindDto,
  ));
}
/// Create a copy of ForecastItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MainDtoCopyWith<$Res> get main {
  
  return $MainDtoCopyWith<$Res>(_self.main, (value) {
    return _then(_self.copyWith(main: value));
  });
}/// Create a copy of ForecastItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WindDtoCopyWith<$Res> get wind {
  
  return $WindDtoCopyWith<$Res>(_self.wind, (value) {
    return _then(_self.copyWith(wind: value));
  });
}
}


/// Adds pattern-matching-related methods to [ForecastItemDto].
extension ForecastItemDtoPatterns on ForecastItemDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForecastItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForecastItemDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForecastItemDto value)  $default,){
final _that = this;
switch (_that) {
case _ForecastItemDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForecastItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _ForecastItemDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dt,  MainDto main,  List<WeatherConditionDto> weather,  WindDto wind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForecastItemDto() when $default != null:
return $default(_that.dt,_that.main,_that.weather,_that.wind);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dt,  MainDto main,  List<WeatherConditionDto> weather,  WindDto wind)  $default,) {final _that = this;
switch (_that) {
case _ForecastItemDto():
return $default(_that.dt,_that.main,_that.weather,_that.wind);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dt,  MainDto main,  List<WeatherConditionDto> weather,  WindDto wind)?  $default,) {final _that = this;
switch (_that) {
case _ForecastItemDto() when $default != null:
return $default(_that.dt,_that.main,_that.weather,_that.wind);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForecastItemDto implements ForecastItemDto {
  const _ForecastItemDto({required this.dt, required this.main, required final  List<WeatherConditionDto> weather, required this.wind}): _weather = weather;
  factory _ForecastItemDto.fromJson(Map<String, dynamic> json) => _$ForecastItemDtoFromJson(json);

@override final  int dt;
@override final  MainDto main;
 final  List<WeatherConditionDto> _weather;
@override List<WeatherConditionDto> get weather {
  if (_weather is EqualUnmodifiableListView) return _weather;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weather);
}

@override final  WindDto wind;

/// Create a copy of ForecastItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForecastItemDtoCopyWith<_ForecastItemDto> get copyWith => __$ForecastItemDtoCopyWithImpl<_ForecastItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForecastItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForecastItemDto&&(identical(other.dt, dt) || other.dt == dt)&&(identical(other.main, main) || other.main == main)&&const DeepCollectionEquality().equals(other._weather, _weather)&&(identical(other.wind, wind) || other.wind == wind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dt,main,const DeepCollectionEquality().hash(_weather),wind);

@override
String toString() {
  return 'ForecastItemDto(dt: $dt, main: $main, weather: $weather, wind: $wind)';
}


}

/// @nodoc
abstract mixin class _$ForecastItemDtoCopyWith<$Res> implements $ForecastItemDtoCopyWith<$Res> {
  factory _$ForecastItemDtoCopyWith(_ForecastItemDto value, $Res Function(_ForecastItemDto) _then) = __$ForecastItemDtoCopyWithImpl;
@override @useResult
$Res call({
 int dt, MainDto main, List<WeatherConditionDto> weather, WindDto wind
});


@override $MainDtoCopyWith<$Res> get main;@override $WindDtoCopyWith<$Res> get wind;

}
/// @nodoc
class __$ForecastItemDtoCopyWithImpl<$Res>
    implements _$ForecastItemDtoCopyWith<$Res> {
  __$ForecastItemDtoCopyWithImpl(this._self, this._then);

  final _ForecastItemDto _self;
  final $Res Function(_ForecastItemDto) _then;

/// Create a copy of ForecastItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dt = null,Object? main = null,Object? weather = null,Object? wind = null,}) {
  return _then(_ForecastItemDto(
dt: null == dt ? _self.dt : dt // ignore: cast_nullable_to_non_nullable
as int,main: null == main ? _self.main : main // ignore: cast_nullable_to_non_nullable
as MainDto,weather: null == weather ? _self._weather : weather // ignore: cast_nullable_to_non_nullable
as List<WeatherConditionDto>,wind: null == wind ? _self.wind : wind // ignore: cast_nullable_to_non_nullable
as WindDto,
  ));
}

/// Create a copy of ForecastItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MainDtoCopyWith<$Res> get main {
  
  return $MainDtoCopyWith<$Res>(_self.main, (value) {
    return _then(_self.copyWith(main: value));
  });
}/// Create a copy of ForecastItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WindDtoCopyWith<$Res> get wind {
  
  return $WindDtoCopyWith<$Res>(_self.wind, (value) {
    return _then(_self.copyWith(wind: value));
  });
}
}


/// @nodoc
mixin _$ForecastDto {

 List<ForecastItemDto> get list;
/// Create a copy of ForecastDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForecastDtoCopyWith<ForecastDto> get copyWith => _$ForecastDtoCopyWithImpl<ForecastDto>(this as ForecastDto, _$identity);

  /// Serializes this ForecastDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForecastDto&&const DeepCollectionEquality().equals(other.list, list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(list));

@override
String toString() {
  return 'ForecastDto(list: $list)';
}


}

/// @nodoc
abstract mixin class $ForecastDtoCopyWith<$Res>  {
  factory $ForecastDtoCopyWith(ForecastDto value, $Res Function(ForecastDto) _then) = _$ForecastDtoCopyWithImpl;
@useResult
$Res call({
 List<ForecastItemDto> list
});




}
/// @nodoc
class _$ForecastDtoCopyWithImpl<$Res>
    implements $ForecastDtoCopyWith<$Res> {
  _$ForecastDtoCopyWithImpl(this._self, this._then);

  final ForecastDto _self;
  final $Res Function(ForecastDto) _then;

/// Create a copy of ForecastDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? list = null,}) {
  return _then(_self.copyWith(
list: null == list ? _self.list : list // ignore: cast_nullable_to_non_nullable
as List<ForecastItemDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [ForecastDto].
extension ForecastDtoPatterns on ForecastDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ForecastDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ForecastDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ForecastDto value)  $default,){
final _that = this;
switch (_that) {
case _ForecastDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ForecastDto value)?  $default,){
final _that = this;
switch (_that) {
case _ForecastDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ForecastItemDto> list)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ForecastDto() when $default != null:
return $default(_that.list);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ForecastItemDto> list)  $default,) {final _that = this;
switch (_that) {
case _ForecastDto():
return $default(_that.list);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ForecastItemDto> list)?  $default,) {final _that = this;
switch (_that) {
case _ForecastDto() when $default != null:
return $default(_that.list);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ForecastDto implements ForecastDto {
  const _ForecastDto({required final  List<ForecastItemDto> list}): _list = list;
  factory _ForecastDto.fromJson(Map<String, dynamic> json) => _$ForecastDtoFromJson(json);

 final  List<ForecastItemDto> _list;
@override List<ForecastItemDto> get list {
  if (_list is EqualUnmodifiableListView) return _list;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_list);
}


/// Create a copy of ForecastDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForecastDtoCopyWith<_ForecastDto> get copyWith => __$ForecastDtoCopyWithImpl<_ForecastDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ForecastDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForecastDto&&const DeepCollectionEquality().equals(other._list, _list));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_list));

@override
String toString() {
  return 'ForecastDto(list: $list)';
}


}

/// @nodoc
abstract mixin class _$ForecastDtoCopyWith<$Res> implements $ForecastDtoCopyWith<$Res> {
  factory _$ForecastDtoCopyWith(_ForecastDto value, $Res Function(_ForecastDto) _then) = __$ForecastDtoCopyWithImpl;
@override @useResult
$Res call({
 List<ForecastItemDto> list
});




}
/// @nodoc
class __$ForecastDtoCopyWithImpl<$Res>
    implements _$ForecastDtoCopyWith<$Res> {
  __$ForecastDtoCopyWithImpl(this._self, this._then);

  final _ForecastDto _self;
  final $Res Function(_ForecastDto) _then;

/// Create a copy of ForecastDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? list = null,}) {
  return _then(_ForecastDto(
list: null == list ? _self._list : list // ignore: cast_nullable_to_non_nullable
as List<ForecastItemDto>,
  ));
}


}

// dart format on
