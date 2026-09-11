// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_layout_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeLayoutEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLayoutEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeLayoutEvent()';
}


}

/// @nodoc
class $HomeLayoutEventCopyWith<$Res>  {
$HomeLayoutEventCopyWith(HomeLayoutEvent _, $Res Function(HomeLayoutEvent) __);
}


/// Adds pattern-matching-related methods to [HomeLayoutEvent].
extension HomeLayoutEventPatterns on HomeLayoutEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeLayoutStarted value)?  started,TResult Function( HomeLayoutRefreshed value)?  refreshed,TResult Function( HomeLayoutInterestsChanged value)?  interestsChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeLayoutStarted() when started != null:
return started(_that);case HomeLayoutRefreshed() when refreshed != null:
return refreshed(_that);case HomeLayoutInterestsChanged() when interestsChanged != null:
return interestsChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeLayoutStarted value)  started,required TResult Function( HomeLayoutRefreshed value)  refreshed,required TResult Function( HomeLayoutInterestsChanged value)  interestsChanged,}){
final _that = this;
switch (_that) {
case HomeLayoutStarted():
return started(_that);case HomeLayoutRefreshed():
return refreshed(_that);case HomeLayoutInterestsChanged():
return interestsChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeLayoutStarted value)?  started,TResult? Function( HomeLayoutRefreshed value)?  refreshed,TResult? Function( HomeLayoutInterestsChanged value)?  interestsChanged,}){
final _that = this;
switch (_that) {
case HomeLayoutStarted() when started != null:
return started(_that);case HomeLayoutRefreshed() when refreshed != null:
return refreshed(_that);case HomeLayoutInterestsChanged() when interestsChanged != null:
return interestsChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,TResult Function( List<String> interests)?  interestsChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeLayoutStarted() when started != null:
return started();case HomeLayoutRefreshed() when refreshed != null:
return refreshed();case HomeLayoutInterestsChanged() when interestsChanged != null:
return interestsChanged(_that.interests);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,required TResult Function( List<String> interests)  interestsChanged,}) {final _that = this;
switch (_that) {
case HomeLayoutStarted():
return started();case HomeLayoutRefreshed():
return refreshed();case HomeLayoutInterestsChanged():
return interestsChanged(_that.interests);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,TResult? Function( List<String> interests)?  interestsChanged,}) {final _that = this;
switch (_that) {
case HomeLayoutStarted() when started != null:
return started();case HomeLayoutRefreshed() when refreshed != null:
return refreshed();case HomeLayoutInterestsChanged() when interestsChanged != null:
return interestsChanged(_that.interests);case _:
  return null;

}
}

}

/// @nodoc


class HomeLayoutStarted implements HomeLayoutEvent {
  const HomeLayoutStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLayoutStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeLayoutEvent.started()';
}


}




/// @nodoc


class HomeLayoutRefreshed implements HomeLayoutEvent {
  const HomeLayoutRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLayoutRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeLayoutEvent.refreshed()';
}


}




/// @nodoc


class HomeLayoutInterestsChanged implements HomeLayoutEvent {
  const HomeLayoutInterestsChanged(final  List<String> interests): _interests = interests;
  

 final  List<String> _interests;
 List<String> get interests {
  if (_interests is EqualUnmodifiableListView) return _interests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_interests);
}


/// Create a copy of HomeLayoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeLayoutInterestsChangedCopyWith<HomeLayoutInterestsChanged> get copyWith => _$HomeLayoutInterestsChangedCopyWithImpl<HomeLayoutInterestsChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLayoutInterestsChanged&&const DeepCollectionEquality().equals(other._interests, _interests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_interests));

@override
String toString() {
  return 'HomeLayoutEvent.interestsChanged(interests: $interests)';
}


}

/// @nodoc
abstract mixin class $HomeLayoutInterestsChangedCopyWith<$Res> implements $HomeLayoutEventCopyWith<$Res> {
  factory $HomeLayoutInterestsChangedCopyWith(HomeLayoutInterestsChanged value, $Res Function(HomeLayoutInterestsChanged) _then) = _$HomeLayoutInterestsChangedCopyWithImpl;
@useResult
$Res call({
 List<String> interests
});




}
/// @nodoc
class _$HomeLayoutInterestsChangedCopyWithImpl<$Res>
    implements $HomeLayoutInterestsChangedCopyWith<$Res> {
  _$HomeLayoutInterestsChangedCopyWithImpl(this._self, this._then);

  final HomeLayoutInterestsChanged _self;
  final $Res Function(HomeLayoutInterestsChanged) _then;

/// Create a copy of HomeLayoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? interests = null,}) {
  return _then(HomeLayoutInterestsChanged(
null == interests ? _self._interests : interests // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

/// @nodoc
mixin _$HomeLayoutState {

 SectionStatus get status; HomeLayout? get layout; String? get error;
/// Create a copy of HomeLayoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeLayoutStateCopyWith<HomeLayoutState> get copyWith => _$HomeLayoutStateCopyWithImpl<HomeLayoutState>(this as HomeLayoutState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLayoutState&&(identical(other.status, status) || other.status == status)&&(identical(other.layout, layout) || other.layout == layout)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,layout,error);

@override
String toString() {
  return 'HomeLayoutState(status: $status, layout: $layout, error: $error)';
}


}

/// @nodoc
abstract mixin class $HomeLayoutStateCopyWith<$Res>  {
  factory $HomeLayoutStateCopyWith(HomeLayoutState value, $Res Function(HomeLayoutState) _then) = _$HomeLayoutStateCopyWithImpl;
@useResult
$Res call({
 SectionStatus status, HomeLayout? layout, String? error
});




}
/// @nodoc
class _$HomeLayoutStateCopyWithImpl<$Res>
    implements $HomeLayoutStateCopyWith<$Res> {
  _$HomeLayoutStateCopyWithImpl(this._self, this._then);

  final HomeLayoutState _self;
  final $Res Function(HomeLayoutState) _then;

/// Create a copy of HomeLayoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? layout = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SectionStatus,layout: freezed == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as HomeLayout?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeLayoutState].
extension HomeLayoutStatePatterns on HomeLayoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeLayoutState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeLayoutState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeLayoutState value)  $default,){
final _that = this;
switch (_that) {
case _HomeLayoutState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeLayoutState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeLayoutState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SectionStatus status,  HomeLayout? layout,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeLayoutState() when $default != null:
return $default(_that.status,_that.layout,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SectionStatus status,  HomeLayout? layout,  String? error)  $default,) {final _that = this;
switch (_that) {
case _HomeLayoutState():
return $default(_that.status,_that.layout,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SectionStatus status,  HomeLayout? layout,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _HomeLayoutState() when $default != null:
return $default(_that.status,_that.layout,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _HomeLayoutState extends HomeLayoutState {
  const _HomeLayoutState({this.status = SectionStatus.idle, this.layout, this.error}): super._();
  

@override@JsonKey() final  SectionStatus status;
@override final  HomeLayout? layout;
@override final  String? error;

/// Create a copy of HomeLayoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeLayoutStateCopyWith<_HomeLayoutState> get copyWith => __$HomeLayoutStateCopyWithImpl<_HomeLayoutState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeLayoutState&&(identical(other.status, status) || other.status == status)&&(identical(other.layout, layout) || other.layout == layout)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,layout,error);

@override
String toString() {
  return 'HomeLayoutState(status: $status, layout: $layout, error: $error)';
}


}

/// @nodoc
abstract mixin class _$HomeLayoutStateCopyWith<$Res> implements $HomeLayoutStateCopyWith<$Res> {
  factory _$HomeLayoutStateCopyWith(_HomeLayoutState value, $Res Function(_HomeLayoutState) _then) = __$HomeLayoutStateCopyWithImpl;
@override @useResult
$Res call({
 SectionStatus status, HomeLayout? layout, String? error
});




}
/// @nodoc
class __$HomeLayoutStateCopyWithImpl<$Res>
    implements _$HomeLayoutStateCopyWith<$Res> {
  __$HomeLayoutStateCopyWithImpl(this._self, this._then);

  final _HomeLayoutState _self;
  final $Res Function(_HomeLayoutState) _then;

/// Create a copy of HomeLayoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? layout = freezed,Object? error = freezed,}) {
  return _then(_HomeLayoutState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SectionStatus,layout: freezed == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as HomeLayout?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
