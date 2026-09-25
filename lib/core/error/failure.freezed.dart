// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NetworkFailure value)?  network,TResult Function( TimeoutFailure value)?  timeout,TResult Function( UnauthorizedFailure value)?  unauthorized,TResult Function( InvalidCredentialsFailure value)?  invalidCredentials,TResult Function( EmailAlreadyUsedFailure value)?  emailAlreadyUsed,TResult Function( EmailNotConfirmedFailure value)?  emailNotConfirmed,TResult Function( NotFoundFailure value)?  notFound,TResult Function( ServerFailure value)?  server,TResult Function( ConflictFailure value)?  conflict,TResult Function( OfflineActionFailure value)?  offlineAction,TResult Function( CacheFailure value)?  cache,TResult Function( UnknownFailure value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case InvalidCredentialsFailure() when invalidCredentials != null:
return invalidCredentials(_that);case EmailAlreadyUsedFailure() when emailAlreadyUsed != null:
return emailAlreadyUsed(_that);case EmailNotConfirmedFailure() when emailNotConfirmed != null:
return emailNotConfirmed(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case ServerFailure() when server != null:
return server(_that);case ConflictFailure() when conflict != null:
return conflict(_that);case OfflineActionFailure() when offlineAction != null:
return offlineAction(_that);case CacheFailure() when cache != null:
return cache(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NetworkFailure value)  network,required TResult Function( TimeoutFailure value)  timeout,required TResult Function( UnauthorizedFailure value)  unauthorized,required TResult Function( InvalidCredentialsFailure value)  invalidCredentials,required TResult Function( EmailAlreadyUsedFailure value)  emailAlreadyUsed,required TResult Function( EmailNotConfirmedFailure value)  emailNotConfirmed,required TResult Function( NotFoundFailure value)  notFound,required TResult Function( ServerFailure value)  server,required TResult Function( ConflictFailure value)  conflict,required TResult Function( OfflineActionFailure value)  offlineAction,required TResult Function( CacheFailure value)  cache,required TResult Function( UnknownFailure value)  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure():
return network(_that);case TimeoutFailure():
return timeout(_that);case UnauthorizedFailure():
return unauthorized(_that);case InvalidCredentialsFailure():
return invalidCredentials(_that);case EmailAlreadyUsedFailure():
return emailAlreadyUsed(_that);case EmailNotConfirmedFailure():
return emailNotConfirmed(_that);case NotFoundFailure():
return notFound(_that);case ServerFailure():
return server(_that);case ConflictFailure():
return conflict(_that);case OfflineActionFailure():
return offlineAction(_that);case CacheFailure():
return cache(_that);case UnknownFailure():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NetworkFailure value)?  network,TResult? Function( TimeoutFailure value)?  timeout,TResult? Function( UnauthorizedFailure value)?  unauthorized,TResult? Function( InvalidCredentialsFailure value)?  invalidCredentials,TResult? Function( EmailAlreadyUsedFailure value)?  emailAlreadyUsed,TResult? Function( EmailNotConfirmedFailure value)?  emailNotConfirmed,TResult? Function( NotFoundFailure value)?  notFound,TResult? Function( ServerFailure value)?  server,TResult? Function( ConflictFailure value)?  conflict,TResult? Function( OfflineActionFailure value)?  offlineAction,TResult? Function( CacheFailure value)?  cache,TResult? Function( UnknownFailure value)?  unknown,}){
final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network(_that);case TimeoutFailure() when timeout != null:
return timeout(_that);case UnauthorizedFailure() when unauthorized != null:
return unauthorized(_that);case InvalidCredentialsFailure() when invalidCredentials != null:
return invalidCredentials(_that);case EmailAlreadyUsedFailure() when emailAlreadyUsed != null:
return emailAlreadyUsed(_that);case EmailNotConfirmedFailure() when emailNotConfirmed != null:
return emailNotConfirmed(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case ServerFailure() when server != null:
return server(_that);case ConflictFailure() when conflict != null:
return conflict(_that);case OfflineActionFailure() when offlineAction != null:
return offlineAction(_that);case CacheFailure() when cache != null:
return cache(_that);case UnknownFailure() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  network,TResult Function()?  timeout,TResult Function()?  unauthorized,TResult Function()?  invalidCredentials,TResult Function()?  emailAlreadyUsed,TResult Function()?  emailNotConfirmed,TResult Function()?  notFound,TResult Function( int statusCode)?  server,TResult Function()?  conflict,TResult Function()?  offlineAction,TResult Function()?  cache,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network();case TimeoutFailure() when timeout != null:
return timeout();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case InvalidCredentialsFailure() when invalidCredentials != null:
return invalidCredentials();case EmailAlreadyUsedFailure() when emailAlreadyUsed != null:
return emailAlreadyUsed();case EmailNotConfirmedFailure() when emailNotConfirmed != null:
return emailNotConfirmed();case NotFoundFailure() when notFound != null:
return notFound();case ServerFailure() when server != null:
return server(_that.statusCode);case ConflictFailure() when conflict != null:
return conflict();case OfflineActionFailure() when offlineAction != null:
return offlineAction();case CacheFailure() when cache != null:
return cache();case UnknownFailure() when unknown != null:
return unknown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  network,required TResult Function()  timeout,required TResult Function()  unauthorized,required TResult Function()  invalidCredentials,required TResult Function()  emailAlreadyUsed,required TResult Function()  emailNotConfirmed,required TResult Function()  notFound,required TResult Function( int statusCode)  server,required TResult Function()  conflict,required TResult Function()  offlineAction,required TResult Function()  cache,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure():
return network();case TimeoutFailure():
return timeout();case UnauthorizedFailure():
return unauthorized();case InvalidCredentialsFailure():
return invalidCredentials();case EmailAlreadyUsedFailure():
return emailAlreadyUsed();case EmailNotConfirmedFailure():
return emailNotConfirmed();case NotFoundFailure():
return notFound();case ServerFailure():
return server(_that.statusCode);case ConflictFailure():
return conflict();case OfflineActionFailure():
return offlineAction();case CacheFailure():
return cache();case UnknownFailure():
return unknown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  network,TResult? Function()?  timeout,TResult? Function()?  unauthorized,TResult? Function()?  invalidCredentials,TResult? Function()?  emailAlreadyUsed,TResult? Function()?  emailNotConfirmed,TResult? Function()?  notFound,TResult? Function( int statusCode)?  server,TResult? Function()?  conflict,TResult? Function()?  offlineAction,TResult? Function()?  cache,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case NetworkFailure() when network != null:
return network();case TimeoutFailure() when timeout != null:
return timeout();case UnauthorizedFailure() when unauthorized != null:
return unauthorized();case InvalidCredentialsFailure() when invalidCredentials != null:
return invalidCredentials();case EmailAlreadyUsedFailure() when emailAlreadyUsed != null:
return emailAlreadyUsed();case EmailNotConfirmedFailure() when emailNotConfirmed != null:
return emailNotConfirmed();case NotFoundFailure() when notFound != null:
return notFound();case ServerFailure() when server != null:
return server(_that.statusCode);case ConflictFailure() when conflict != null:
return conflict();case OfflineActionFailure() when offlineAction != null:
return offlineAction();case CacheFailure() when cache != null:
return cache();case UnknownFailure() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc


class NetworkFailure extends Failure {
  const NetworkFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.network()';
}


}




/// @nodoc


class TimeoutFailure extends Failure {
  const TimeoutFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeoutFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.timeout()';
}


}




/// @nodoc


class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnauthorizedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.unauthorized()';
}


}




/// @nodoc


class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidCredentialsFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.invalidCredentials()';
}


}




/// @nodoc


class EmailAlreadyUsedFailure extends Failure {
  const EmailAlreadyUsedFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailAlreadyUsedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.emailAlreadyUsed()';
}


}




/// @nodoc


class EmailNotConfirmedFailure extends Failure {
  const EmailNotConfirmedFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailNotConfirmedFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.emailNotConfirmed()';
}


}




/// @nodoc


class NotFoundFailure extends Failure {
  const NotFoundFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFoundFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.notFound()';
}


}




/// @nodoc


class ServerFailure extends Failure {
  const ServerFailure(this.statusCode): super._();
  

 final  int statusCode;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServerFailureCopyWith<ServerFailure> get copyWith => _$ServerFailureCopyWithImpl<ServerFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerFailure&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode => Object.hash(runtimeType,statusCode);

@override
String toString() {
  return 'Failure.server(statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $ServerFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ServerFailureCopyWith(ServerFailure value, $Res Function(ServerFailure) _then) = _$ServerFailureCopyWithImpl;
@useResult
$Res call({
 int statusCode
});




}
/// @nodoc
class _$ServerFailureCopyWithImpl<$Res>
    implements $ServerFailureCopyWith<$Res> {
  _$ServerFailureCopyWithImpl(this._self, this._then);

  final ServerFailure _self;
  final $Res Function(ServerFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? statusCode = null,}) {
  return _then(ServerFailure(
null == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ConflictFailure extends Failure {
  const ConflictFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConflictFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.conflict()';
}


}




/// @nodoc


class OfflineActionFailure extends Failure {
  const OfflineActionFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OfflineActionFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.offlineAction()';
}


}




/// @nodoc


class CacheFailure extends Failure {
  const CacheFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CacheFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.cache()';
}


}




/// @nodoc


class UnknownFailure extends Failure {
  const UnknownFailure(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnknownFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure.unknown()';
}


}




// dart format on
