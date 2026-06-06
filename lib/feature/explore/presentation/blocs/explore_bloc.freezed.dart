// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExploreEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreEvent()';
}


}

/// @nodoc
class $ExploreEventCopyWith<$Res>  {
$ExploreEventCopyWith(ExploreEvent _, $Res Function(ExploreEvent) __);
}


/// Adds pattern-matching-related methods to [ExploreEvent].
extension ExploreEventPatterns on ExploreEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ExploreStarted value)?  started,TResult Function( ExploreQueryChanged value)?  queryChanged,TResult Function( ExploreSearchSubmitted value)?  searchSubmitted,TResult Function( ExploreCategorySelected value)?  categorySelected,TResult Function( ExploreSortChanged value)?  sortChanged,TResult Function( ExploreFiltersApplied value)?  filtersApplied,TResult Function( ExploreLoadMore value)?  loadMore,TResult Function( ExploreRefreshed value)?  refreshed,TResult Function( ExploreCleared value)?  cleared,TResult Function( ExploreRecentCleared value)?  recentCleared,TResult Function( ExploreModeToggled value)?  modeToggled,TResult Function( ExploreNearbyRequested value)?  nearbyRequested,TResult Function( ExploreLocationResolved value)?  locationResolved,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ExploreStarted() when started != null:
return started(_that);case ExploreQueryChanged() when queryChanged != null:
return queryChanged(_that);case ExploreSearchSubmitted() when searchSubmitted != null:
return searchSubmitted(_that);case ExploreCategorySelected() when categorySelected != null:
return categorySelected(_that);case ExploreSortChanged() when sortChanged != null:
return sortChanged(_that);case ExploreFiltersApplied() when filtersApplied != null:
return filtersApplied(_that);case ExploreLoadMore() when loadMore != null:
return loadMore(_that);case ExploreRefreshed() when refreshed != null:
return refreshed(_that);case ExploreCleared() when cleared != null:
return cleared(_that);case ExploreRecentCleared() when recentCleared != null:
return recentCleared(_that);case ExploreModeToggled() when modeToggled != null:
return modeToggled(_that);case ExploreNearbyRequested() when nearbyRequested != null:
return nearbyRequested(_that);case ExploreLocationResolved() when locationResolved != null:
return locationResolved(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ExploreStarted value)  started,required TResult Function( ExploreQueryChanged value)  queryChanged,required TResult Function( ExploreSearchSubmitted value)  searchSubmitted,required TResult Function( ExploreCategorySelected value)  categorySelected,required TResult Function( ExploreSortChanged value)  sortChanged,required TResult Function( ExploreFiltersApplied value)  filtersApplied,required TResult Function( ExploreLoadMore value)  loadMore,required TResult Function( ExploreRefreshed value)  refreshed,required TResult Function( ExploreCleared value)  cleared,required TResult Function( ExploreRecentCleared value)  recentCleared,required TResult Function( ExploreModeToggled value)  modeToggled,required TResult Function( ExploreNearbyRequested value)  nearbyRequested,required TResult Function( ExploreLocationResolved value)  locationResolved,}){
final _that = this;
switch (_that) {
case ExploreStarted():
return started(_that);case ExploreQueryChanged():
return queryChanged(_that);case ExploreSearchSubmitted():
return searchSubmitted(_that);case ExploreCategorySelected():
return categorySelected(_that);case ExploreSortChanged():
return sortChanged(_that);case ExploreFiltersApplied():
return filtersApplied(_that);case ExploreLoadMore():
return loadMore(_that);case ExploreRefreshed():
return refreshed(_that);case ExploreCleared():
return cleared(_that);case ExploreRecentCleared():
return recentCleared(_that);case ExploreModeToggled():
return modeToggled(_that);case ExploreNearbyRequested():
return nearbyRequested(_that);case ExploreLocationResolved():
return locationResolved(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ExploreStarted value)?  started,TResult? Function( ExploreQueryChanged value)?  queryChanged,TResult? Function( ExploreSearchSubmitted value)?  searchSubmitted,TResult? Function( ExploreCategorySelected value)?  categorySelected,TResult? Function( ExploreSortChanged value)?  sortChanged,TResult? Function( ExploreFiltersApplied value)?  filtersApplied,TResult? Function( ExploreLoadMore value)?  loadMore,TResult? Function( ExploreRefreshed value)?  refreshed,TResult? Function( ExploreCleared value)?  cleared,TResult? Function( ExploreRecentCleared value)?  recentCleared,TResult? Function( ExploreModeToggled value)?  modeToggled,TResult? Function( ExploreNearbyRequested value)?  nearbyRequested,TResult? Function( ExploreLocationResolved value)?  locationResolved,}){
final _that = this;
switch (_that) {
case ExploreStarted() when started != null:
return started(_that);case ExploreQueryChanged() when queryChanged != null:
return queryChanged(_that);case ExploreSearchSubmitted() when searchSubmitted != null:
return searchSubmitted(_that);case ExploreCategorySelected() when categorySelected != null:
return categorySelected(_that);case ExploreSortChanged() when sortChanged != null:
return sortChanged(_that);case ExploreFiltersApplied() when filtersApplied != null:
return filtersApplied(_that);case ExploreLoadMore() when loadMore != null:
return loadMore(_that);case ExploreRefreshed() when refreshed != null:
return refreshed(_that);case ExploreCleared() when cleared != null:
return cleared(_that);case ExploreRecentCleared() when recentCleared != null:
return recentCleared(_that);case ExploreModeToggled() when modeToggled != null:
return modeToggled(_that);case ExploreNearbyRequested() when nearbyRequested != null:
return nearbyRequested(_that);case ExploreLocationResolved() when locationResolved != null:
return locationResolved(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String query)?  queryChanged,TResult Function( String query)?  searchSubmitted,TResult Function( String? category)?  categorySelected,TResult Function( ExploreSort sort)?  sortChanged,TResult Function( ExploreFilters filters)?  filtersApplied,TResult Function()?  loadMore,TResult Function()?  refreshed,TResult Function()?  cleared,TResult Function()?  recentCleared,TResult Function()?  modeToggled,TResult Function( double lat,  double lng,  int radiusM)?  nearbyRequested,TResult Function( double lat,  double lng,  String? city)?  locationResolved,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ExploreStarted() when started != null:
return started();case ExploreQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case ExploreSearchSubmitted() when searchSubmitted != null:
return searchSubmitted(_that.query);case ExploreCategorySelected() when categorySelected != null:
return categorySelected(_that.category);case ExploreSortChanged() when sortChanged != null:
return sortChanged(_that.sort);case ExploreFiltersApplied() when filtersApplied != null:
return filtersApplied(_that.filters);case ExploreLoadMore() when loadMore != null:
return loadMore();case ExploreRefreshed() when refreshed != null:
return refreshed();case ExploreCleared() when cleared != null:
return cleared();case ExploreRecentCleared() when recentCleared != null:
return recentCleared();case ExploreModeToggled() when modeToggled != null:
return modeToggled();case ExploreNearbyRequested() when nearbyRequested != null:
return nearbyRequested(_that.lat,_that.lng,_that.radiusM);case ExploreLocationResolved() when locationResolved != null:
return locationResolved(_that.lat,_that.lng,_that.city);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String query)  queryChanged,required TResult Function( String query)  searchSubmitted,required TResult Function( String? category)  categorySelected,required TResult Function( ExploreSort sort)  sortChanged,required TResult Function( ExploreFilters filters)  filtersApplied,required TResult Function()  loadMore,required TResult Function()  refreshed,required TResult Function()  cleared,required TResult Function()  recentCleared,required TResult Function()  modeToggled,required TResult Function( double lat,  double lng,  int radiusM)  nearbyRequested,required TResult Function( double lat,  double lng,  String? city)  locationResolved,}) {final _that = this;
switch (_that) {
case ExploreStarted():
return started();case ExploreQueryChanged():
return queryChanged(_that.query);case ExploreSearchSubmitted():
return searchSubmitted(_that.query);case ExploreCategorySelected():
return categorySelected(_that.category);case ExploreSortChanged():
return sortChanged(_that.sort);case ExploreFiltersApplied():
return filtersApplied(_that.filters);case ExploreLoadMore():
return loadMore();case ExploreRefreshed():
return refreshed();case ExploreCleared():
return cleared();case ExploreRecentCleared():
return recentCleared();case ExploreModeToggled():
return modeToggled();case ExploreNearbyRequested():
return nearbyRequested(_that.lat,_that.lng,_that.radiusM);case ExploreLocationResolved():
return locationResolved(_that.lat,_that.lng,_that.city);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String query)?  queryChanged,TResult? Function( String query)?  searchSubmitted,TResult? Function( String? category)?  categorySelected,TResult? Function( ExploreSort sort)?  sortChanged,TResult? Function( ExploreFilters filters)?  filtersApplied,TResult? Function()?  loadMore,TResult? Function()?  refreshed,TResult? Function()?  cleared,TResult? Function()?  recentCleared,TResult? Function()?  modeToggled,TResult? Function( double lat,  double lng,  int radiusM)?  nearbyRequested,TResult? Function( double lat,  double lng,  String? city)?  locationResolved,}) {final _that = this;
switch (_that) {
case ExploreStarted() when started != null:
return started();case ExploreQueryChanged() when queryChanged != null:
return queryChanged(_that.query);case ExploreSearchSubmitted() when searchSubmitted != null:
return searchSubmitted(_that.query);case ExploreCategorySelected() when categorySelected != null:
return categorySelected(_that.category);case ExploreSortChanged() when sortChanged != null:
return sortChanged(_that.sort);case ExploreFiltersApplied() when filtersApplied != null:
return filtersApplied(_that.filters);case ExploreLoadMore() when loadMore != null:
return loadMore();case ExploreRefreshed() when refreshed != null:
return refreshed();case ExploreCleared() when cleared != null:
return cleared();case ExploreRecentCleared() when recentCleared != null:
return recentCleared();case ExploreModeToggled() when modeToggled != null:
return modeToggled();case ExploreNearbyRequested() when nearbyRequested != null:
return nearbyRequested(_that.lat,_that.lng,_that.radiusM);case ExploreLocationResolved() when locationResolved != null:
return locationResolved(_that.lat,_that.lng,_that.city);case _:
  return null;

}
}

}

/// @nodoc


class ExploreStarted implements ExploreEvent {
  const ExploreStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreEvent.started()';
}


}




/// @nodoc


class ExploreQueryChanged implements ExploreEvent {
  const ExploreQueryChanged(this.query);
  

 final  String query;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreQueryChangedCopyWith<ExploreQueryChanged> get copyWith => _$ExploreQueryChangedCopyWithImpl<ExploreQueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreQueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'ExploreEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class $ExploreQueryChangedCopyWith<$Res> implements $ExploreEventCopyWith<$Res> {
  factory $ExploreQueryChangedCopyWith(ExploreQueryChanged value, $Res Function(ExploreQueryChanged) _then) = _$ExploreQueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$ExploreQueryChangedCopyWithImpl<$Res>
    implements $ExploreQueryChangedCopyWith<$Res> {
  _$ExploreQueryChangedCopyWithImpl(this._self, this._then);

  final ExploreQueryChanged _self;
  final $Res Function(ExploreQueryChanged) _then;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(ExploreQueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExploreSearchSubmitted implements ExploreEvent {
  const ExploreSearchSubmitted(this.query);
  

 final  String query;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreSearchSubmittedCopyWith<ExploreSearchSubmitted> get copyWith => _$ExploreSearchSubmittedCopyWithImpl<ExploreSearchSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreSearchSubmitted&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'ExploreEvent.searchSubmitted(query: $query)';
}


}

/// @nodoc
abstract mixin class $ExploreSearchSubmittedCopyWith<$Res> implements $ExploreEventCopyWith<$Res> {
  factory $ExploreSearchSubmittedCopyWith(ExploreSearchSubmitted value, $Res Function(ExploreSearchSubmitted) _then) = _$ExploreSearchSubmittedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$ExploreSearchSubmittedCopyWithImpl<$Res>
    implements $ExploreSearchSubmittedCopyWith<$Res> {
  _$ExploreSearchSubmittedCopyWithImpl(this._self, this._then);

  final ExploreSearchSubmitted _self;
  final $Res Function(ExploreSearchSubmitted) _then;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(ExploreSearchSubmitted(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExploreCategorySelected implements ExploreEvent {
  const ExploreCategorySelected(this.category);
  

 final  String? category;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreCategorySelectedCopyWith<ExploreCategorySelected> get copyWith => _$ExploreCategorySelectedCopyWithImpl<ExploreCategorySelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreCategorySelected&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,category);

@override
String toString() {
  return 'ExploreEvent.categorySelected(category: $category)';
}


}

/// @nodoc
abstract mixin class $ExploreCategorySelectedCopyWith<$Res> implements $ExploreEventCopyWith<$Res> {
  factory $ExploreCategorySelectedCopyWith(ExploreCategorySelected value, $Res Function(ExploreCategorySelected) _then) = _$ExploreCategorySelectedCopyWithImpl;
@useResult
$Res call({
 String? category
});




}
/// @nodoc
class _$ExploreCategorySelectedCopyWithImpl<$Res>
    implements $ExploreCategorySelectedCopyWith<$Res> {
  _$ExploreCategorySelectedCopyWithImpl(this._self, this._then);

  final ExploreCategorySelected _self;
  final $Res Function(ExploreCategorySelected) _then;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? category = freezed,}) {
  return _then(ExploreCategorySelected(
freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ExploreSortChanged implements ExploreEvent {
  const ExploreSortChanged(this.sort);
  

 final  ExploreSort sort;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreSortChangedCopyWith<ExploreSortChanged> get copyWith => _$ExploreSortChangedCopyWithImpl<ExploreSortChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreSortChanged&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode => Object.hash(runtimeType,sort);

@override
String toString() {
  return 'ExploreEvent.sortChanged(sort: $sort)';
}


}

/// @nodoc
abstract mixin class $ExploreSortChangedCopyWith<$Res> implements $ExploreEventCopyWith<$Res> {
  factory $ExploreSortChangedCopyWith(ExploreSortChanged value, $Res Function(ExploreSortChanged) _then) = _$ExploreSortChangedCopyWithImpl;
@useResult
$Res call({
 ExploreSort sort
});




}
/// @nodoc
class _$ExploreSortChangedCopyWithImpl<$Res>
    implements $ExploreSortChangedCopyWith<$Res> {
  _$ExploreSortChangedCopyWithImpl(this._self, this._then);

  final ExploreSortChanged _self;
  final $Res Function(ExploreSortChanged) _then;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sort = null,}) {
  return _then(ExploreSortChanged(
null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ExploreSort,
  ));
}


}

/// @nodoc


class ExploreFiltersApplied implements ExploreEvent {
  const ExploreFiltersApplied(this.filters);
  

 final  ExploreFilters filters;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreFiltersAppliedCopyWith<ExploreFiltersApplied> get copyWith => _$ExploreFiltersAppliedCopyWithImpl<ExploreFiltersApplied>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreFiltersApplied&&(identical(other.filters, filters) || other.filters == filters));
}


@override
int get hashCode => Object.hash(runtimeType,filters);

@override
String toString() {
  return 'ExploreEvent.filtersApplied(filters: $filters)';
}


}

/// @nodoc
abstract mixin class $ExploreFiltersAppliedCopyWith<$Res> implements $ExploreEventCopyWith<$Res> {
  factory $ExploreFiltersAppliedCopyWith(ExploreFiltersApplied value, $Res Function(ExploreFiltersApplied) _then) = _$ExploreFiltersAppliedCopyWithImpl;
@useResult
$Res call({
 ExploreFilters filters
});




}
/// @nodoc
class _$ExploreFiltersAppliedCopyWithImpl<$Res>
    implements $ExploreFiltersAppliedCopyWith<$Res> {
  _$ExploreFiltersAppliedCopyWithImpl(this._self, this._then);

  final ExploreFiltersApplied _self;
  final $Res Function(ExploreFiltersApplied) _then;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filters = null,}) {
  return _then(ExploreFiltersApplied(
null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as ExploreFilters,
  ));
}


}

/// @nodoc


class ExploreLoadMore implements ExploreEvent {
  const ExploreLoadMore();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreLoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreEvent.loadMore()';
}


}




/// @nodoc


class ExploreRefreshed implements ExploreEvent {
  const ExploreRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreEvent.refreshed()';
}


}




/// @nodoc


class ExploreCleared implements ExploreEvent {
  const ExploreCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreEvent.cleared()';
}


}




/// @nodoc


class ExploreRecentCleared implements ExploreEvent {
  const ExploreRecentCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreRecentCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreEvent.recentCleared()';
}


}




/// @nodoc


class ExploreModeToggled implements ExploreEvent {
  const ExploreModeToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreModeToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ExploreEvent.modeToggled()';
}


}




/// @nodoc


class ExploreNearbyRequested implements ExploreEvent {
  const ExploreNearbyRequested({required this.lat, required this.lng, this.radiusM = 20000});
  

 final  double lat;
 final  double lng;
@JsonKey() final  int radiusM;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreNearbyRequestedCopyWith<ExploreNearbyRequested> get copyWith => _$ExploreNearbyRequestedCopyWithImpl<ExploreNearbyRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreNearbyRequested&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.radiusM, radiusM) || other.radiusM == radiusM));
}


@override
int get hashCode => Object.hash(runtimeType,lat,lng,radiusM);

@override
String toString() {
  return 'ExploreEvent.nearbyRequested(lat: $lat, lng: $lng, radiusM: $radiusM)';
}


}

/// @nodoc
abstract mixin class $ExploreNearbyRequestedCopyWith<$Res> implements $ExploreEventCopyWith<$Res> {
  factory $ExploreNearbyRequestedCopyWith(ExploreNearbyRequested value, $Res Function(ExploreNearbyRequested) _then) = _$ExploreNearbyRequestedCopyWithImpl;
@useResult
$Res call({
 double lat, double lng, int radiusM
});




}
/// @nodoc
class _$ExploreNearbyRequestedCopyWithImpl<$Res>
    implements $ExploreNearbyRequestedCopyWith<$Res> {
  _$ExploreNearbyRequestedCopyWithImpl(this._self, this._then);

  final ExploreNearbyRequested _self;
  final $Res Function(ExploreNearbyRequested) _then;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,Object? radiusM = null,}) {
  return _then(ExploreNearbyRequested(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,radiusM: null == radiusM ? _self.radiusM : radiusM // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ExploreLocationResolved implements ExploreEvent {
  const ExploreLocationResolved({required this.lat, required this.lng, this.city});
  

 final  double lat;
 final  double lng;
 final  String? city;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreLocationResolvedCopyWith<ExploreLocationResolved> get copyWith => _$ExploreLocationResolvedCopyWithImpl<ExploreLocationResolved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreLocationResolved&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.city, city) || other.city == city));
}


@override
int get hashCode => Object.hash(runtimeType,lat,lng,city);

@override
String toString() {
  return 'ExploreEvent.locationResolved(lat: $lat, lng: $lng, city: $city)';
}


}

/// @nodoc
abstract mixin class $ExploreLocationResolvedCopyWith<$Res> implements $ExploreEventCopyWith<$Res> {
  factory $ExploreLocationResolvedCopyWith(ExploreLocationResolved value, $Res Function(ExploreLocationResolved) _then) = _$ExploreLocationResolvedCopyWithImpl;
@useResult
$Res call({
 double lat, double lng, String? city
});




}
/// @nodoc
class _$ExploreLocationResolvedCopyWithImpl<$Res>
    implements $ExploreLocationResolvedCopyWith<$Res> {
  _$ExploreLocationResolvedCopyWithImpl(this._self, this._then);

  final ExploreLocationResolved _self;
  final $Res Function(ExploreLocationResolved) _then;

/// Create a copy of ExploreEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lat = null,Object? lng = null,Object? city = freezed,}) {
  return _then(ExploreLocationResolved(
lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$ExploreState {

// Map is the primary surface; the list is the filtered-results view.
 ExploreMode get mode; ExploreStatus get status; ExploreFilters get filters; List<Event> get items; int get page; int get total; List<String> get recent; String? get error;// Map mode (independent of the list so toggling doesn't clobber results).
 ExploreStatus get mapStatus; List<Event> get mapItems; String? get mapError; double? get centerLat; double? get centerLng; String? get city;
/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExploreStateCopyWith<ExploreState> get copyWith => _$ExploreStateCopyWithImpl<ExploreState>(this as ExploreState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExploreState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.status, status) || other.status == status)&&(identical(other.filters, filters) || other.filters == filters)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.page, page) || other.page == page)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.recent, recent)&&(identical(other.error, error) || other.error == error)&&(identical(other.mapStatus, mapStatus) || other.mapStatus == mapStatus)&&const DeepCollectionEquality().equals(other.mapItems, mapItems)&&(identical(other.mapError, mapError) || other.mapError == mapError)&&(identical(other.centerLat, centerLat) || other.centerLat == centerLat)&&(identical(other.centerLng, centerLng) || other.centerLng == centerLng)&&(identical(other.city, city) || other.city == city));
}


@override
int get hashCode => Object.hash(runtimeType,mode,status,filters,const DeepCollectionEquality().hash(items),page,total,const DeepCollectionEquality().hash(recent),error,mapStatus,const DeepCollectionEquality().hash(mapItems),mapError,centerLat,centerLng,city);

@override
String toString() {
  return 'ExploreState(mode: $mode, status: $status, filters: $filters, items: $items, page: $page, total: $total, recent: $recent, error: $error, mapStatus: $mapStatus, mapItems: $mapItems, mapError: $mapError, centerLat: $centerLat, centerLng: $centerLng, city: $city)';
}


}

/// @nodoc
abstract mixin class $ExploreStateCopyWith<$Res>  {
  factory $ExploreStateCopyWith(ExploreState value, $Res Function(ExploreState) _then) = _$ExploreStateCopyWithImpl;
@useResult
$Res call({
 ExploreMode mode, ExploreStatus status, ExploreFilters filters, List<Event> items, int page, int total, List<String> recent, String? error, ExploreStatus mapStatus, List<Event> mapItems, String? mapError, double? centerLat, double? centerLng, String? city
});




}
/// @nodoc
class _$ExploreStateCopyWithImpl<$Res>
    implements $ExploreStateCopyWith<$Res> {
  _$ExploreStateCopyWithImpl(this._self, this._then);

  final ExploreState _self;
  final $Res Function(ExploreState) _then;

/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? status = null,Object? filters = null,Object? items = null,Object? page = null,Object? total = null,Object? recent = null,Object? error = freezed,Object? mapStatus = null,Object? mapItems = null,Object? mapError = freezed,Object? centerLat = freezed,Object? centerLng = freezed,Object? city = freezed,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ExploreMode,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExploreStatus,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as ExploreFilters,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Event>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,recent: null == recent ? _self.recent : recent // ignore: cast_nullable_to_non_nullable
as List<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,mapStatus: null == mapStatus ? _self.mapStatus : mapStatus // ignore: cast_nullable_to_non_nullable
as ExploreStatus,mapItems: null == mapItems ? _self.mapItems : mapItems // ignore: cast_nullable_to_non_nullable
as List<Event>,mapError: freezed == mapError ? _self.mapError : mapError // ignore: cast_nullable_to_non_nullable
as String?,centerLat: freezed == centerLat ? _self.centerLat : centerLat // ignore: cast_nullable_to_non_nullable
as double?,centerLng: freezed == centerLng ? _self.centerLng : centerLng // ignore: cast_nullable_to_non_nullable
as double?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExploreState].
extension ExploreStatePatterns on ExploreState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExploreState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExploreState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExploreState value)  $default,){
final _that = this;
switch (_that) {
case _ExploreState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExploreState value)?  $default,){
final _that = this;
switch (_that) {
case _ExploreState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExploreMode mode,  ExploreStatus status,  ExploreFilters filters,  List<Event> items,  int page,  int total,  List<String> recent,  String? error,  ExploreStatus mapStatus,  List<Event> mapItems,  String? mapError,  double? centerLat,  double? centerLng,  String? city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExploreState() when $default != null:
return $default(_that.mode,_that.status,_that.filters,_that.items,_that.page,_that.total,_that.recent,_that.error,_that.mapStatus,_that.mapItems,_that.mapError,_that.centerLat,_that.centerLng,_that.city);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExploreMode mode,  ExploreStatus status,  ExploreFilters filters,  List<Event> items,  int page,  int total,  List<String> recent,  String? error,  ExploreStatus mapStatus,  List<Event> mapItems,  String? mapError,  double? centerLat,  double? centerLng,  String? city)  $default,) {final _that = this;
switch (_that) {
case _ExploreState():
return $default(_that.mode,_that.status,_that.filters,_that.items,_that.page,_that.total,_that.recent,_that.error,_that.mapStatus,_that.mapItems,_that.mapError,_that.centerLat,_that.centerLng,_that.city);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExploreMode mode,  ExploreStatus status,  ExploreFilters filters,  List<Event> items,  int page,  int total,  List<String> recent,  String? error,  ExploreStatus mapStatus,  List<Event> mapItems,  String? mapError,  double? centerLat,  double? centerLng,  String? city)?  $default,) {final _that = this;
switch (_that) {
case _ExploreState() when $default != null:
return $default(_that.mode,_that.status,_that.filters,_that.items,_that.page,_that.total,_that.recent,_that.error,_that.mapStatus,_that.mapItems,_that.mapError,_that.centerLat,_that.centerLng,_that.city);case _:
  return null;

}
}

}

/// @nodoc


class _ExploreState extends ExploreState {
  const _ExploreState({this.mode = ExploreMode.map, this.status = ExploreStatus.idle, this.filters = const ExploreFilters(), final  List<Event> items = const <Event>[], this.page = 1, this.total = 0, final  List<String> recent = const <String>[], this.error, this.mapStatus = ExploreStatus.idle, final  List<Event> mapItems = const <Event>[], this.mapError, this.centerLat, this.centerLng, this.city}): _items = items,_recent = recent,_mapItems = mapItems,super._();
  

// Map is the primary surface; the list is the filtered-results view.
@override@JsonKey() final  ExploreMode mode;
@override@JsonKey() final  ExploreStatus status;
@override@JsonKey() final  ExploreFilters filters;
 final  List<Event> _items;
@override@JsonKey() List<Event> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  int total;
 final  List<String> _recent;
@override@JsonKey() List<String> get recent {
  if (_recent is EqualUnmodifiableListView) return _recent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recent);
}

@override final  String? error;
// Map mode (independent of the list so toggling doesn't clobber results).
@override@JsonKey() final  ExploreStatus mapStatus;
 final  List<Event> _mapItems;
@override@JsonKey() List<Event> get mapItems {
  if (_mapItems is EqualUnmodifiableListView) return _mapItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mapItems);
}

@override final  String? mapError;
@override final  double? centerLat;
@override final  double? centerLng;
@override final  String? city;

/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExploreStateCopyWith<_ExploreState> get copyWith => __$ExploreStateCopyWithImpl<_ExploreState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExploreState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.status, status) || other.status == status)&&(identical(other.filters, filters) || other.filters == filters)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other._recent, _recent)&&(identical(other.error, error) || other.error == error)&&(identical(other.mapStatus, mapStatus) || other.mapStatus == mapStatus)&&const DeepCollectionEquality().equals(other._mapItems, _mapItems)&&(identical(other.mapError, mapError) || other.mapError == mapError)&&(identical(other.centerLat, centerLat) || other.centerLat == centerLat)&&(identical(other.centerLng, centerLng) || other.centerLng == centerLng)&&(identical(other.city, city) || other.city == city));
}


@override
int get hashCode => Object.hash(runtimeType,mode,status,filters,const DeepCollectionEquality().hash(_items),page,total,const DeepCollectionEquality().hash(_recent),error,mapStatus,const DeepCollectionEquality().hash(_mapItems),mapError,centerLat,centerLng,city);

@override
String toString() {
  return 'ExploreState(mode: $mode, status: $status, filters: $filters, items: $items, page: $page, total: $total, recent: $recent, error: $error, mapStatus: $mapStatus, mapItems: $mapItems, mapError: $mapError, centerLat: $centerLat, centerLng: $centerLng, city: $city)';
}


}

/// @nodoc
abstract mixin class _$ExploreStateCopyWith<$Res> implements $ExploreStateCopyWith<$Res> {
  factory _$ExploreStateCopyWith(_ExploreState value, $Res Function(_ExploreState) _then) = __$ExploreStateCopyWithImpl;
@override @useResult
$Res call({
 ExploreMode mode, ExploreStatus status, ExploreFilters filters, List<Event> items, int page, int total, List<String> recent, String? error, ExploreStatus mapStatus, List<Event> mapItems, String? mapError, double? centerLat, double? centerLng, String? city
});




}
/// @nodoc
class __$ExploreStateCopyWithImpl<$Res>
    implements _$ExploreStateCopyWith<$Res> {
  __$ExploreStateCopyWithImpl(this._self, this._then);

  final _ExploreState _self;
  final $Res Function(_ExploreState) _then;

/// Create a copy of ExploreState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? status = null,Object? filters = null,Object? items = null,Object? page = null,Object? total = null,Object? recent = null,Object? error = freezed,Object? mapStatus = null,Object? mapItems = null,Object? mapError = freezed,Object? centerLat = freezed,Object? centerLng = freezed,Object? city = freezed,}) {
  return _then(_ExploreState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ExploreMode,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ExploreStatus,filters: null == filters ? _self.filters : filters // ignore: cast_nullable_to_non_nullable
as ExploreFilters,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Event>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,recent: null == recent ? _self._recent : recent // ignore: cast_nullable_to_non_nullable
as List<String>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,mapStatus: null == mapStatus ? _self.mapStatus : mapStatus // ignore: cast_nullable_to_non_nullable
as ExploreStatus,mapItems: null == mapItems ? _self._mapItems : mapItems // ignore: cast_nullable_to_non_nullable
as List<Event>,mapError: freezed == mapError ? _self.mapError : mapError // ignore: cast_nullable_to_non_nullable
as String?,centerLat: freezed == centerLat ? _self.centerLat : centerLat // ignore: cast_nullable_to_non_nullable
as double?,centerLng: freezed == centerLng ? _self.centerLng : centerLng // ignore: cast_nullable_to_non_nullable
as double?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
