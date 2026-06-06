// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'choose_location_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChooseLocationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseLocationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChooseLocationEvent()';
}


}

/// @nodoc
class $ChooseLocationEventCopyWith<$Res>  {
$ChooseLocationEventCopyWith(ChooseLocationEvent _, $Res Function(ChooseLocationEvent) __);
}


/// Adds pattern-matching-related methods to [ChooseLocationEvent].
extension ChooseLocationEventPatterns on ChooseLocationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChooseLocationStarted value)?  started,TResult Function( ChooseLocationQueryChanged value)?  queryChanged,TResult Function( ChooseLocationUseCurrentRequested value)?  useCurrentRequested,TResult Function( ChooseLocationSelected value)?  locationSelected,TResult Function( ChooseLocationErrorDismissed value)?  errorDismissed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChooseLocationStarted() when started != null:
return started(_that);case ChooseLocationQueryChanged() when queryChanged != null:
return queryChanged(_that);case ChooseLocationUseCurrentRequested() when useCurrentRequested != null:
return useCurrentRequested(_that);case ChooseLocationSelected() when locationSelected != null:
return locationSelected(_that);case ChooseLocationErrorDismissed() when errorDismissed != null:
return errorDismissed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChooseLocationStarted value)  started,required TResult Function( ChooseLocationQueryChanged value)  queryChanged,required TResult Function( ChooseLocationUseCurrentRequested value)  useCurrentRequested,required TResult Function( ChooseLocationSelected value)  locationSelected,required TResult Function( ChooseLocationErrorDismissed value)  errorDismissed,}){
final _that = this;
switch (_that) {
case ChooseLocationStarted():
return started(_that);case ChooseLocationQueryChanged():
return queryChanged(_that);case ChooseLocationUseCurrentRequested():
return useCurrentRequested(_that);case ChooseLocationSelected():
return locationSelected(_that);case ChooseLocationErrorDismissed():
return errorDismissed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChooseLocationStarted value)?  started,TResult? Function( ChooseLocationQueryChanged value)?  queryChanged,TResult? Function( ChooseLocationUseCurrentRequested value)?  useCurrentRequested,TResult? Function( ChooseLocationSelected value)?  locationSelected,TResult? Function( ChooseLocationErrorDismissed value)?  errorDismissed,}){
final _that = this;
switch (_that) {
case ChooseLocationStarted() when started != null:
return started(_that);case ChooseLocationQueryChanged() when queryChanged != null:
return queryChanged(_that);case ChooseLocationUseCurrentRequested() when useCurrentRequested != null:
return useCurrentRequested(_that);case ChooseLocationSelected() when locationSelected != null:
return locationSelected(_that);case ChooseLocationErrorDismissed() when errorDismissed != null:
return errorDismissed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String query)?  queryChanged,TResult Function()?  useCurrentRequested,TResult Function( String city,  String? country)?  locationSelected,TResult Function()?  errorDismissed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChooseLocationStarted() when started != null:
return started();case ChooseLocationQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case ChooseLocationUseCurrentRequested() when useCurrentRequested != null:
return useCurrentRequested();case ChooseLocationSelected() when locationSelected != null:
return locationSelected(_that.city,_that.country);case ChooseLocationErrorDismissed() when errorDismissed != null:
return errorDismissed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String query)  queryChanged,required TResult Function()  useCurrentRequested,required TResult Function( String city,  String? country)  locationSelected,required TResult Function()  errorDismissed,}) {final _that = this;
switch (_that) {
case ChooseLocationStarted():
return started();case ChooseLocationQueryChanged():
return queryChanged(_that.query);case ChooseLocationUseCurrentRequested():
return useCurrentRequested();case ChooseLocationSelected():
return locationSelected(_that.city,_that.country);case ChooseLocationErrorDismissed():
return errorDismissed();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String query)?  queryChanged,TResult? Function()?  useCurrentRequested,TResult? Function( String city,  String? country)?  locationSelected,TResult? Function()?  errorDismissed,}) {final _that = this;
switch (_that) {
case ChooseLocationStarted() when started != null:
return started();case ChooseLocationQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case ChooseLocationUseCurrentRequested() when useCurrentRequested != null:
return useCurrentRequested();case ChooseLocationSelected() when locationSelected != null:
return locationSelected(_that.city,_that.country);case ChooseLocationErrorDismissed() when errorDismissed != null:
return errorDismissed();case _:
  return null;

}
}

}

/// @nodoc


class ChooseLocationStarted implements ChooseLocationEvent {
  const ChooseLocationStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseLocationStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChooseLocationEvent.started()';
}


}




/// @nodoc


class ChooseLocationQueryChanged implements ChooseLocationEvent {
  const ChooseLocationQueryChanged(this.query);
  

 final  String query;

/// Create a copy of ChooseLocationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChooseLocationQueryChangedCopyWith<ChooseLocationQueryChanged> get copyWith => _$ChooseLocationQueryChangedCopyWithImpl<ChooseLocationQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseLocationQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'ChooseLocationEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $ChooseLocationQueryChangedCopyWith<$Res> implements $ChooseLocationEventCopyWith<$Res> {
  factory $ChooseLocationQueryChangedCopyWith(ChooseLocationQueryChanged value, $Res Function(ChooseLocationQueryChanged) _then) = _$ChooseLocationQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$ChooseLocationQueryChangedCopyWithImpl<$Res>
    implements $ChooseLocationQueryChangedCopyWith<$Res> {
  _$ChooseLocationQueryChangedCopyWithImpl(this._self, this._then);

  final ChooseLocationQueryChanged _self;
  final $Res Function(ChooseLocationQueryChanged) _then;

/// Create a copy of ChooseLocationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(ChooseLocationQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ChooseLocationUseCurrentRequested implements ChooseLocationEvent {
  const ChooseLocationUseCurrentRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseLocationUseCurrentRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChooseLocationEvent.useCurrentRequested()';
}


}




/// @nodoc


class ChooseLocationSelected implements ChooseLocationEvent {
  const ChooseLocationSelected({required this.city, this.country});
  

 final  String city;
 final  String? country;

/// Create a copy of ChooseLocationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChooseLocationSelectedCopyWith<ChooseLocationSelected> get copyWith => _$ChooseLocationSelectedCopyWithImpl<ChooseLocationSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseLocationSelected&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode => Object.hash(runtimeType,city,country);

@override
String toString() {
  return 'ChooseLocationEvent.locationSelected(city: $city, country: $country)';
}


}

/// @nodoc
abstract mixin class $ChooseLocationSelectedCopyWith<$Res> implements $ChooseLocationEventCopyWith<$Res> {
  factory $ChooseLocationSelectedCopyWith(ChooseLocationSelected value, $Res Function(ChooseLocationSelected) _then) = _$ChooseLocationSelectedCopyWithImpl;
@useResult
$Res call({
 String city, String? country
});




}
/// @nodoc
class _$ChooseLocationSelectedCopyWithImpl<$Res>
    implements $ChooseLocationSelectedCopyWith<$Res> {
  _$ChooseLocationSelectedCopyWithImpl(this._self, this._then);

  final ChooseLocationSelected _self;
  final $Res Function(ChooseLocationSelected) _then;

/// Create a copy of ChooseLocationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? city = null,Object? country = freezed,}) {
  return _then(ChooseLocationSelected(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ChooseLocationErrorDismissed implements ChooseLocationEvent {
  const ChooseLocationErrorDismissed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseLocationErrorDismissed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChooseLocationEvent.errorDismissed()';
}


}




/// @nodoc
mixin _$ChooseLocationState {

 List<PopularLocation> get popular; String get query; ChooseLocationStatus get status; String? get failureMessage;
/// Create a copy of ChooseLocationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChooseLocationStateCopyWith<ChooseLocationState> get copyWith => _$ChooseLocationStateCopyWithImpl<ChooseLocationState>(this as ChooseLocationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChooseLocationState&&const DeepCollectionEquality().equals(other.popular, popular)&&(identical(other.query, query) || other.query == query)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(popular),query,status,failureMessage);

@override
String toString() {
  return 'ChooseLocationState(popular: $popular, query: $query, status: $status, failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class $ChooseLocationStateCopyWith<$Res>  {
  factory $ChooseLocationStateCopyWith(ChooseLocationState value, $Res Function(ChooseLocationState) _then) = _$ChooseLocationStateCopyWithImpl;
@useResult
$Res call({
 List<PopularLocation> popular, String query, ChooseLocationStatus status, String? failureMessage
});




}
/// @nodoc
class _$ChooseLocationStateCopyWithImpl<$Res>
    implements $ChooseLocationStateCopyWith<$Res> {
  _$ChooseLocationStateCopyWithImpl(this._self, this._then);

  final ChooseLocationState _self;
  final $Res Function(ChooseLocationState) _then;

/// Create a copy of ChooseLocationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? popular = null,Object? query = null,Object? status = null,Object? failureMessage = freezed,}) {
  return _then(_self.copyWith(
popular: null == popular ? _self.popular : popular // ignore: cast_nullable_to_non_nullable
as List<PopularLocation>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChooseLocationStatus,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChooseLocationState].
extension ChooseLocationStatePatterns on ChooseLocationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChooseLocationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChooseLocationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChooseLocationState value)  $default,){
final _that = this;
switch (_that) {
case _ChooseLocationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChooseLocationState value)?  $default,){
final _that = this;
switch (_that) {
case _ChooseLocationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PopularLocation> popular,  String query,  ChooseLocationStatus status,  String? failureMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChooseLocationState() when $default != null:
return $default(_that.popular,_that.query,_that.status,_that.failureMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PopularLocation> popular,  String query,  ChooseLocationStatus status,  String? failureMessage)  $default,) {final _that = this;
switch (_that) {
case _ChooseLocationState():
return $default(_that.popular,_that.query,_that.status,_that.failureMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PopularLocation> popular,  String query,  ChooseLocationStatus status,  String? failureMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChooseLocationState() when $default != null:
return $default(_that.popular,_that.query,_that.status,_that.failureMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ChooseLocationState extends ChooseLocationState {
  const _ChooseLocationState({final  List<PopularLocation> popular = const <PopularLocation>[], this.query = '', this.status = ChooseLocationStatus.idle, this.failureMessage}): _popular = popular,super._();
  

 final  List<PopularLocation> _popular;
@override@JsonKey() List<PopularLocation> get popular {
  if (_popular is EqualUnmodifiableListView) return _popular;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popular);
}

@override@JsonKey() final  String query;
@override@JsonKey() final  ChooseLocationStatus status;
@override final  String? failureMessage;

/// Create a copy of ChooseLocationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChooseLocationStateCopyWith<_ChooseLocationState> get copyWith => __$ChooseLocationStateCopyWithImpl<_ChooseLocationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChooseLocationState&&const DeepCollectionEquality().equals(other._popular, _popular)&&(identical(other.query, query) || other.query == query)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_popular),query,status,failureMessage);

@override
String toString() {
  return 'ChooseLocationState(popular: $popular, query: $query, status: $status, failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class _$ChooseLocationStateCopyWith<$Res> implements $ChooseLocationStateCopyWith<$Res> {
  factory _$ChooseLocationStateCopyWith(_ChooseLocationState value, $Res Function(_ChooseLocationState) _then) = __$ChooseLocationStateCopyWithImpl;
@override @useResult
$Res call({
 List<PopularLocation> popular, String query, ChooseLocationStatus status, String? failureMessage
});




}
/// @nodoc
class __$ChooseLocationStateCopyWithImpl<$Res>
    implements _$ChooseLocationStateCopyWith<$Res> {
  __$ChooseLocationStateCopyWithImpl(this._self, this._then);

  final _ChooseLocationState _self;
  final $Res Function(_ChooseLocationState) _then;

/// Create a copy of ChooseLocationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? popular = null,Object? query = null,Object? status = null,Object? failureMessage = freezed,}) {
  return _then(_ChooseLocationState(
popular: null == popular ? _self._popular : popular // ignore: cast_nullable_to_non_nullable
as List<PopularLocation>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChooseLocationStatus,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
