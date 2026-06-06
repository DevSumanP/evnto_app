// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeStarted value)?  started,TResult Function( HomeRefreshed value)?  refreshed,TResult Function( HomeQueryChanged value)?  queryChanged,TResult Function( HomeUpcomingRetried value)?  upcomingRetried,TResult Function( HomePopularRetried value)?  popularRetried,TResult Function( HomeSuggestionsRetried value)?  suggestionsRetried,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started(_that);case HomeRefreshed() when refreshed != null:
return refreshed(_that);case HomeQueryChanged() when queryChanged != null:
return queryChanged(_that);case HomeUpcomingRetried() when upcomingRetried != null:
return upcomingRetried(_that);case HomePopularRetried() when popularRetried != null:
return popularRetried(_that);case HomeSuggestionsRetried() when suggestionsRetried != null:
return suggestionsRetried(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeStarted value)  started,required TResult Function( HomeRefreshed value)  refreshed,required TResult Function( HomeQueryChanged value)  queryChanged,required TResult Function( HomeUpcomingRetried value)  upcomingRetried,required TResult Function( HomePopularRetried value)  popularRetried,required TResult Function( HomeSuggestionsRetried value)  suggestionsRetried,}){
final _that = this;
switch (_that) {
case HomeStarted():
return started(_that);case HomeRefreshed():
return refreshed(_that);case HomeQueryChanged():
return queryChanged(_that);case HomeUpcomingRetried():
return upcomingRetried(_that);case HomePopularRetried():
return popularRetried(_that);case HomeSuggestionsRetried():
return suggestionsRetried(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeStarted value)?  started,TResult? Function( HomeRefreshed value)?  refreshed,TResult? Function( HomeQueryChanged value)?  queryChanged,TResult? Function( HomeUpcomingRetried value)?  upcomingRetried,TResult? Function( HomePopularRetried value)?  popularRetried,TResult? Function( HomeSuggestionsRetried value)?  suggestionsRetried,}){
final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started(_that);case HomeRefreshed() when refreshed != null:
return refreshed(_that);case HomeQueryChanged() when queryChanged != null:
return queryChanged(_that);case HomeUpcomingRetried() when upcomingRetried != null:
return upcomingRetried(_that);case HomePopularRetried() when popularRetried != null:
return popularRetried(_that);case HomeSuggestionsRetried() when suggestionsRetried != null:
return suggestionsRetried(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,TResult Function( String query)?  queryChanged,TResult Function()?  upcomingRetried,TResult Function()?  popularRetried,TResult Function()?  suggestionsRetried,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started();case HomeRefreshed() when refreshed != null:
return refreshed();case HomeQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case HomeUpcomingRetried() when upcomingRetried != null:
return upcomingRetried();case HomePopularRetried() when popularRetried != null:
return popularRetried();case HomeSuggestionsRetried() when suggestionsRetried != null:
return suggestionsRetried();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,required TResult Function( String query)  queryChanged,required TResult Function()  upcomingRetried,required TResult Function()  popularRetried,required TResult Function()  suggestionsRetried,}) {final _that = this;
switch (_that) {
case HomeStarted():
return started();case HomeRefreshed():
return refreshed();case HomeQueryChanged():
return queryChanged(_that.query);case HomeUpcomingRetried():
return upcomingRetried();case HomePopularRetried():
return popularRetried();case HomeSuggestionsRetried():
return suggestionsRetried();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,TResult? Function( String query)?  queryChanged,TResult? Function()?  upcomingRetried,TResult? Function()?  popularRetried,TResult? Function()?  suggestionsRetried,}) {final _that = this;
switch (_that) {
case HomeStarted() when started != null:
return started();case HomeRefreshed() when refreshed != null:
return refreshed();case HomeQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case HomeUpcomingRetried() when upcomingRetried != null:
return upcomingRetried();case HomePopularRetried() when popularRetried != null:
return popularRetried();case HomeSuggestionsRetried() when suggestionsRetried != null:
return suggestionsRetried();case _:
  return null;

}
}

}

/// @nodoc


class HomeStarted implements HomeEvent {
  const HomeStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.started()';
}


}




/// @nodoc


class HomeRefreshed implements HomeEvent {
  const HomeRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.refreshed()';
}


}




/// @nodoc


class HomeQueryChanged implements HomeEvent {
  const HomeQueryChanged(this.query);
  

 final  String query;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeQueryChangedCopyWith<HomeQueryChanged> get copyWith => _$HomeQueryChangedCopyWithImpl<HomeQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'HomeEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $HomeQueryChangedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $HomeQueryChangedCopyWith(HomeQueryChanged value, $Res Function(HomeQueryChanged) _then) = _$HomeQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$HomeQueryChangedCopyWithImpl<$Res>
    implements $HomeQueryChangedCopyWith<$Res> {
  _$HomeQueryChangedCopyWithImpl(this._self, this._then);

  final HomeQueryChanged _self;
  final $Res Function(HomeQueryChanged) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(HomeQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class HomeUpcomingRetried implements HomeEvent {
  const HomeUpcomingRetried();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeUpcomingRetried);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.upcomingRetried()';
}


}




/// @nodoc


class HomePopularRetried implements HomeEvent {
  const HomePopularRetried();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomePopularRetried);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.popularRetried()';
}


}




/// @nodoc


class HomeSuggestionsRetried implements HomeEvent {
  const HomeSuggestionsRetried();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeSuggestionsRetried);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeEvent.suggestionsRetried()';
}


}




/// @nodoc
mixin _$HomeState {

 String get query; List<Event> get upcoming; List<Event> get popular; List<Event> get suggested; SectionStatus get upcomingStatus; SectionStatus get popularStatus; SectionStatus get suggestedStatus; String? get upcomingError; String? get popularError; String? get suggestedError; String? get city; String? get country;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.upcoming, upcoming)&&const DeepCollectionEquality().equals(other.popular, popular)&&const DeepCollectionEquality().equals(other.suggested, suggested)&&(identical(other.upcomingStatus, upcomingStatus) || other.upcomingStatus == upcomingStatus)&&(identical(other.popularStatus, popularStatus) || other.popularStatus == popularStatus)&&(identical(other.suggestedStatus, suggestedStatus) || other.suggestedStatus == suggestedStatus)&&(identical(other.upcomingError, upcomingError) || other.upcomingError == upcomingError)&&(identical(other.popularError, popularError) || other.popularError == popularError)&&(identical(other.suggestedError, suggestedError) || other.suggestedError == suggestedError)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(upcoming),const DeepCollectionEquality().hash(popular),const DeepCollectionEquality().hash(suggested),upcomingStatus,popularStatus,suggestedStatus,upcomingError,popularError,suggestedError,city,country);

@override
String toString() {
  return 'HomeState(query: $query, upcoming: $upcoming, popular: $popular, suggested: $suggested, upcomingStatus: $upcomingStatus, popularStatus: $popularStatus, suggestedStatus: $suggestedStatus, upcomingError: $upcomingError, popularError: $popularError, suggestedError: $suggestedError, city: $city, country: $country)';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 String query, List<Event> upcoming, List<Event> popular, List<Event> suggested, SectionStatus upcomingStatus, SectionStatus popularStatus, SectionStatus suggestedStatus, String? upcomingError, String? popularError, String? suggestedError, String? city, String? country
});




}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? upcoming = null,Object? popular = null,Object? suggested = null,Object? upcomingStatus = null,Object? popularStatus = null,Object? suggestedStatus = null,Object? upcomingError = freezed,Object? popularError = freezed,Object? suggestedError = freezed,Object? city = freezed,Object? country = freezed,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<Event>,popular: null == popular ? _self.popular : popular // ignore: cast_nullable_to_non_nullable
as List<Event>,suggested: null == suggested ? _self.suggested : suggested // ignore: cast_nullable_to_non_nullable
as List<Event>,upcomingStatus: null == upcomingStatus ? _self.upcomingStatus : upcomingStatus // ignore: cast_nullable_to_non_nullable
as SectionStatus,popularStatus: null == popularStatus ? _self.popularStatus : popularStatus // ignore: cast_nullable_to_non_nullable
as SectionStatus,suggestedStatus: null == suggestedStatus ? _self.suggestedStatus : suggestedStatus // ignore: cast_nullable_to_non_nullable
as SectionStatus,upcomingError: freezed == upcomingError ? _self.upcomingError : upcomingError // ignore: cast_nullable_to_non_nullable
as String?,popularError: freezed == popularError ? _self.popularError : popularError // ignore: cast_nullable_to_non_nullable
as String?,suggestedError: freezed == suggestedError ? _self.suggestedError : suggestedError // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  List<Event> upcoming,  List<Event> popular,  List<Event> suggested,  SectionStatus upcomingStatus,  SectionStatus popularStatus,  SectionStatus suggestedStatus,  String? upcomingError,  String? popularError,  String? suggestedError,  String? city,  String? country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.query,_that.upcoming,_that.popular,_that.suggested,_that.upcomingStatus,_that.popularStatus,_that.suggestedStatus,_that.upcomingError,_that.popularError,_that.suggestedError,_that.city,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  List<Event> upcoming,  List<Event> popular,  List<Event> suggested,  SectionStatus upcomingStatus,  SectionStatus popularStatus,  SectionStatus suggestedStatus,  String? upcomingError,  String? popularError,  String? suggestedError,  String? city,  String? country)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.query,_that.upcoming,_that.popular,_that.suggested,_that.upcomingStatus,_that.popularStatus,_that.suggestedStatus,_that.upcomingError,_that.popularError,_that.suggestedError,_that.city,_that.country);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  List<Event> upcoming,  List<Event> popular,  List<Event> suggested,  SectionStatus upcomingStatus,  SectionStatus popularStatus,  SectionStatus suggestedStatus,  String? upcomingError,  String? popularError,  String? suggestedError,  String? city,  String? country)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.query,_that.upcoming,_that.popular,_that.suggested,_that.upcomingStatus,_that.popularStatus,_that.suggestedStatus,_that.upcomingError,_that.popularError,_that.suggestedError,_that.city,_that.country);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState extends HomeState {
  const _HomeState({this.query = '', final  List<Event> upcoming = const <Event>[], final  List<Event> popular = const <Event>[], final  List<Event> suggested = const <Event>[], this.upcomingStatus = SectionStatus.idle, this.popularStatus = SectionStatus.idle, this.suggestedStatus = SectionStatus.idle, this.upcomingError, this.popularError, this.suggestedError, this.city, this.country}): _upcoming = upcoming,_popular = popular,_suggested = suggested,super._();
  

@override@JsonKey() final  String query;
 final  List<Event> _upcoming;
@override@JsonKey() List<Event> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

 final  List<Event> _popular;
@override@JsonKey() List<Event> get popular {
  if (_popular is EqualUnmodifiableListView) return _popular;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popular);
}

 final  List<Event> _suggested;
@override@JsonKey() List<Event> get suggested {
  if (_suggested is EqualUnmodifiableListView) return _suggested;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_suggested);
}

@override@JsonKey() final  SectionStatus upcomingStatus;
@override@JsonKey() final  SectionStatus popularStatus;
@override@JsonKey() final  SectionStatus suggestedStatus;
@override final  String? upcomingError;
@override final  String? popularError;
@override final  String? suggestedError;
@override final  String? city;
@override final  String? country;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other._upcoming, _upcoming)&&const DeepCollectionEquality().equals(other._popular, _popular)&&const DeepCollectionEquality().equals(other._suggested, _suggested)&&(identical(other.upcomingStatus, upcomingStatus) || other.upcomingStatus == upcomingStatus)&&(identical(other.popularStatus, popularStatus) || other.popularStatus == popularStatus)&&(identical(other.suggestedStatus, suggestedStatus) || other.suggestedStatus == suggestedStatus)&&(identical(other.upcomingError, upcomingError) || other.upcomingError == upcomingError)&&(identical(other.popularError, popularError) || other.popularError == popularError)&&(identical(other.suggestedError, suggestedError) || other.suggestedError == suggestedError)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode => Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_upcoming),const DeepCollectionEquality().hash(_popular),const DeepCollectionEquality().hash(_suggested),upcomingStatus,popularStatus,suggestedStatus,upcomingError,popularError,suggestedError,city,country);

@override
String toString() {
  return 'HomeState(query: $query, upcoming: $upcoming, popular: $popular, suggested: $suggested, upcomingStatus: $upcomingStatus, popularStatus: $popularStatus, suggestedStatus: $suggestedStatus, upcomingError: $upcomingError, popularError: $popularError, suggestedError: $suggestedError, city: $city, country: $country)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 String query, List<Event> upcoming, List<Event> popular, List<Event> suggested, SectionStatus upcomingStatus, SectionStatus popularStatus, SectionStatus suggestedStatus, String? upcomingError, String? popularError, String? suggestedError, String? city, String? country
});




}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? upcoming = null,Object? popular = null,Object? suggested = null,Object? upcomingStatus = null,Object? popularStatus = null,Object? suggestedStatus = null,Object? upcomingError = freezed,Object? popularError = freezed,Object? suggestedError = freezed,Object? city = freezed,Object? country = freezed,}) {
  return _then(_HomeState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<Event>,popular: null == popular ? _self._popular : popular // ignore: cast_nullable_to_non_nullable
as List<Event>,suggested: null == suggested ? _self._suggested : suggested // ignore: cast_nullable_to_non_nullable
as List<Event>,upcomingStatus: null == upcomingStatus ? _self.upcomingStatus : upcomingStatus // ignore: cast_nullable_to_non_nullable
as SectionStatus,popularStatus: null == popularStatus ? _self.popularStatus : popularStatus // ignore: cast_nullable_to_non_nullable
as SectionStatus,suggestedStatus: null == suggestedStatus ? _self.suggestedStatus : suggestedStatus // ignore: cast_nullable_to_non_nullable
as SectionStatus,upcomingError: freezed == upcomingError ? _self.upcomingError : upcomingError // ignore: cast_nullable_to_non_nullable
as String?,popularError: freezed == popularError ? _self.popularError : popularError // ignore: cast_nullable_to_non_nullable
as String?,suggestedError: freezed == suggestedError ? _self.suggestedError : suggestedError // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
