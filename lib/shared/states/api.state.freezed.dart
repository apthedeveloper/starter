// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api.state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiState<T> {

 bool get isLoading; bool get isRefreshing; bool get isLoadingMore; T? get data; String? get error;
/// Create a copy of ApiState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiStateCopyWith<T, ApiState<T>> get copyWith => _$ApiStateCopyWithImpl<T, ApiState<T>>(this as ApiState<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiState<T>&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,isLoadingMore,const DeepCollectionEquality().hash(data),error);

@override
String toString() {
  return 'ApiState<$T>(isLoading: $isLoading, isRefreshing: $isRefreshing, isLoadingMore: $isLoadingMore, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class $ApiStateCopyWith<T,$Res>  {
  factory $ApiStateCopyWith(ApiState<T> value, $Res Function(ApiState<T>) _then) = _$ApiStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isRefreshing, bool isLoadingMore, T? data, String? error
});




}
/// @nodoc
class _$ApiStateCopyWithImpl<T,$Res>
    implements $ApiStateCopyWith<T, $Res> {
  _$ApiStateCopyWithImpl(this._self, this._then);

  final ApiState<T> _self;
  final $Res Function(ApiState<T>) _then;

/// Create a copy of ApiState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? isLoadingMore = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiState].
extension ApiStatePatterns<T> on ApiState<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApiState<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApiState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApiState<T> value)  $default,){
final _that = this;
switch (_that) {
case _ApiState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApiState<T> value)?  $default,){
final _that = this;
switch (_that) {
case _ApiState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  bool isLoadingMore,  T? data,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApiState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.isLoadingMore,_that.data,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isRefreshing,  bool isLoadingMore,  T? data,  String? error)  $default,) {final _that = this;
switch (_that) {
case _ApiState():
return $default(_that.isLoading,_that.isRefreshing,_that.isLoadingMore,_that.data,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isRefreshing,  bool isLoadingMore,  T? data,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _ApiState() when $default != null:
return $default(_that.isLoading,_that.isRefreshing,_that.isLoadingMore,_that.data,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _ApiState<T> extends ApiState<T> {
  const _ApiState({this.isLoading = false, this.isRefreshing = false, this.isLoadingMore = false, this.data, this.error}): super._();
  

@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isRefreshing;
@override@JsonKey() final  bool isLoadingMore;
@override final  T? data;
@override final  String? error;

/// Create a copy of ApiState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApiStateCopyWith<T, _ApiState<T>> get copyWith => __$ApiStateCopyWithImpl<T, _ApiState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApiState<T>&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isRefreshing, isRefreshing) || other.isRefreshing == isRefreshing)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isRefreshing,isLoadingMore,const DeepCollectionEquality().hash(data),error);

@override
String toString() {
  return 'ApiState<$T>(isLoading: $isLoading, isRefreshing: $isRefreshing, isLoadingMore: $isLoadingMore, data: $data, error: $error)';
}


}

/// @nodoc
abstract mixin class _$ApiStateCopyWith<T,$Res> implements $ApiStateCopyWith<T, $Res> {
  factory _$ApiStateCopyWith(_ApiState<T> value, $Res Function(_ApiState<T>) _then) = __$ApiStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isRefreshing, bool isLoadingMore, T? data, String? error
});




}
/// @nodoc
class __$ApiStateCopyWithImpl<T,$Res>
    implements _$ApiStateCopyWith<T, $Res> {
  __$ApiStateCopyWithImpl(this._self, this._then);

  final _ApiState<T> _self;
  final $Res Function(_ApiState<T>) _then;

/// Create a copy of ApiState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isRefreshing = null,Object? isLoadingMore = null,Object? data = freezed,Object? error = freezed,}) {
  return _then(_ApiState<T>(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isRefreshing: null == isRefreshing ? _self.isRefreshing : isRefreshing // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
