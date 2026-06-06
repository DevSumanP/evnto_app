// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BaseEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseEvent()';
}


}

/// @nodoc
class $BaseEventCopyWith<$Res>  {
$BaseEventCopyWith(BaseEvent _, $Res Function(BaseEvent) __);
}


/// Adds pattern-matching-related methods to [BaseEvent].
extension BaseEventPatterns on BaseEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BaseFetchEvent value)?  fetch,TResult Function( BaseRefreshEvent value)?  refresh,TResult Function( BaseRetryEvent value)?  retry,TResult Function( BaseClearEvent value)?  clear,TResult Function( BaseResetEvent value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BaseFetchEvent() when fetch != null:
return fetch(_that);case BaseRefreshEvent() when refresh != null:
return refresh(_that);case BaseRetryEvent() when retry != null:
return retry(_that);case BaseClearEvent() when clear != null:
return clear(_that);case BaseResetEvent() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BaseFetchEvent value)  fetch,required TResult Function( BaseRefreshEvent value)  refresh,required TResult Function( BaseRetryEvent value)  retry,required TResult Function( BaseClearEvent value)  clear,required TResult Function( BaseResetEvent value)  reset,}){
final _that = this;
switch (_that) {
case BaseFetchEvent():
return fetch(_that);case BaseRefreshEvent():
return refresh(_that);case BaseRetryEvent():
return retry(_that);case BaseClearEvent():
return clear(_that);case BaseResetEvent():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BaseFetchEvent value)?  fetch,TResult? Function( BaseRefreshEvent value)?  refresh,TResult? Function( BaseRetryEvent value)?  retry,TResult? Function( BaseClearEvent value)?  clear,TResult? Function( BaseResetEvent value)?  reset,}){
final _that = this;
switch (_that) {
case BaseFetchEvent() when fetch != null:
return fetch(_that);case BaseRefreshEvent() when refresh != null:
return refresh(_that);case BaseRetryEvent() when retry != null:
return retry(_that);case BaseClearEvent() when clear != null:
return clear(_that);case BaseResetEvent() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool forceRefresh)?  fetch,TResult Function()?  refresh,TResult Function()?  retry,TResult Function()?  clear,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BaseFetchEvent() when fetch != null:
return fetch(_that.forceRefresh);case BaseRefreshEvent() when refresh != null:
return refresh();case BaseRetryEvent() when retry != null:
return retry();case BaseClearEvent() when clear != null:
return clear();case BaseResetEvent() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool forceRefresh)  fetch,required TResult Function()  refresh,required TResult Function()  retry,required TResult Function()  clear,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case BaseFetchEvent():
return fetch(_that.forceRefresh);case BaseRefreshEvent():
return refresh();case BaseRetryEvent():
return retry();case BaseClearEvent():
return clear();case BaseResetEvent():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool forceRefresh)?  fetch,TResult? Function()?  refresh,TResult? Function()?  retry,TResult? Function()?  clear,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case BaseFetchEvent() when fetch != null:
return fetch(_that.forceRefresh);case BaseRefreshEvent() when refresh != null:
return refresh();case BaseRetryEvent() when retry != null:
return retry();case BaseClearEvent() when clear != null:
return clear();case BaseResetEvent() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class BaseFetchEvent implements BaseEvent {
  const BaseFetchEvent({this.forceRefresh = false});
  

@JsonKey() final  bool forceRefresh;

/// Create a copy of BaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BaseFetchEventCopyWith<BaseFetchEvent> get copyWith => _$BaseFetchEventCopyWithImpl<BaseFetchEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseFetchEvent&&(identical(other.forceRefresh, forceRefresh) || other.forceRefresh == forceRefresh));
}


@override
int get hashCode => Object.hash(runtimeType,forceRefresh);

@override
String toString() {
  return 'BaseEvent.fetch(forceRefresh: $forceRefresh)';
}


}

/// @nodoc
abstract mixin class $BaseFetchEventCopyWith<$Res> implements $BaseEventCopyWith<$Res> {
  factory $BaseFetchEventCopyWith(BaseFetchEvent value, $Res Function(BaseFetchEvent) _then) = _$BaseFetchEventCopyWithImpl;
@useResult
$Res call({
 bool forceRefresh
});




}
/// @nodoc
class _$BaseFetchEventCopyWithImpl<$Res>
    implements $BaseFetchEventCopyWith<$Res> {
  _$BaseFetchEventCopyWithImpl(this._self, this._then);

  final BaseFetchEvent _self;
  final $Res Function(BaseFetchEvent) _then;

/// Create a copy of BaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? forceRefresh = null,}) {
  return _then(BaseFetchEvent(
forceRefresh: null == forceRefresh ? _self.forceRefresh : forceRefresh // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class BaseRefreshEvent implements BaseEvent {
  const BaseRefreshEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseRefreshEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseEvent.refresh()';
}


}




/// @nodoc


class BaseRetryEvent implements BaseEvent {
  const BaseRetryEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseRetryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseEvent.retry()';
}


}




/// @nodoc


class BaseClearEvent implements BaseEvent {
  const BaseClearEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseClearEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseEvent.clear()';
}


}




/// @nodoc


class BaseResetEvent implements BaseEvent {
  const BaseResetEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BaseResetEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BaseEvent.reset()';
}


}




/// @nodoc
mixin _$CrudEvent<T> {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrudEvent<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CrudEvent<$T>()';
}


}

/// @nodoc
class $CrudEventCopyWith<T,$Res>  {
$CrudEventCopyWith(CrudEvent<T> _, $Res Function(CrudEvent<T>) __);
}


/// Adds pattern-matching-related methods to [CrudEvent].
extension CrudEventPatterns<T> on CrudEvent<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CrudCreateEvent<T> value)?  create,TResult Function( CrudReadEvent<T> value)?  read,TResult Function( CrudUpdateEvent<T> value)?  update,TResult Function( CrudDeleteEvent<T> value)?  delete,TResult Function( CrudListEvent<T> value)?  list,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CrudCreateEvent() when create != null:
return create(_that);case CrudReadEvent() when read != null:
return read(_that);case CrudUpdateEvent() when update != null:
return update(_that);case CrudDeleteEvent() when delete != null:
return delete(_that);case CrudListEvent() when list != null:
return list(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CrudCreateEvent<T> value)  create,required TResult Function( CrudReadEvent<T> value)  read,required TResult Function( CrudUpdateEvent<T> value)  update,required TResult Function( CrudDeleteEvent<T> value)  delete,required TResult Function( CrudListEvent<T> value)  list,}){
final _that = this;
switch (_that) {
case CrudCreateEvent():
return create(_that);case CrudReadEvent():
return read(_that);case CrudUpdateEvent():
return update(_that);case CrudDeleteEvent():
return delete(_that);case CrudListEvent():
return list(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CrudCreateEvent<T> value)?  create,TResult? Function( CrudReadEvent<T> value)?  read,TResult? Function( CrudUpdateEvent<T> value)?  update,TResult? Function( CrudDeleteEvent<T> value)?  delete,TResult? Function( CrudListEvent<T> value)?  list,}){
final _that = this;
switch (_that) {
case CrudCreateEvent() when create != null:
return create(_that);case CrudReadEvent() when read != null:
return read(_that);case CrudUpdateEvent() when update != null:
return update(_that);case CrudDeleteEvent() when delete != null:
return delete(_that);case CrudListEvent() when list != null:
return list(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( T data)?  create,TResult Function( String id)?  read,TResult Function( String id,  T data)?  update,TResult Function( String id)?  delete,TResult Function()?  list,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CrudCreateEvent() when create != null:
return create(_that.data);case CrudReadEvent() when read != null:
return read(_that.id);case CrudUpdateEvent() when update != null:
return update(_that.id,_that.data);case CrudDeleteEvent() when delete != null:
return delete(_that.id);case CrudListEvent() when list != null:
return list();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( T data)  create,required TResult Function( String id)  read,required TResult Function( String id,  T data)  update,required TResult Function( String id)  delete,required TResult Function()  list,}) {final _that = this;
switch (_that) {
case CrudCreateEvent():
return create(_that.data);case CrudReadEvent():
return read(_that.id);case CrudUpdateEvent():
return update(_that.id,_that.data);case CrudDeleteEvent():
return delete(_that.id);case CrudListEvent():
return list();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( T data)?  create,TResult? Function( String id)?  read,TResult? Function( String id,  T data)?  update,TResult? Function( String id)?  delete,TResult? Function()?  list,}) {final _that = this;
switch (_that) {
case CrudCreateEvent() when create != null:
return create(_that.data);case CrudReadEvent() when read != null:
return read(_that.id);case CrudUpdateEvent() when update != null:
return update(_that.id,_that.data);case CrudDeleteEvent() when delete != null:
return delete(_that.id);case CrudListEvent() when list != null:
return list();case _:
  return null;

}
}

}

/// @nodoc


class CrudCreateEvent<T> implements CrudEvent<T> {
  const CrudCreateEvent({required this.data});
  

 final  T data;

/// Create a copy of CrudEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrudCreateEventCopyWith<T, CrudCreateEvent<T>> get copyWith => _$CrudCreateEventCopyWithImpl<T, CrudCreateEvent<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrudCreateEvent<T>&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'CrudEvent<$T>.create(data: $data)';
}


}

/// @nodoc
abstract mixin class $CrudCreateEventCopyWith<T,$Res> implements $CrudEventCopyWith<T, $Res> {
  factory $CrudCreateEventCopyWith(CrudCreateEvent<T> value, $Res Function(CrudCreateEvent<T>) _then) = _$CrudCreateEventCopyWithImpl;
@useResult
$Res call({
 T data
});




}
/// @nodoc
class _$CrudCreateEventCopyWithImpl<T,$Res>
    implements $CrudCreateEventCopyWith<T, $Res> {
  _$CrudCreateEventCopyWithImpl(this._self, this._then);

  final CrudCreateEvent<T> _self;
  final $Res Function(CrudCreateEvent<T>) _then;

/// Create a copy of CrudEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(CrudCreateEvent<T>(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class CrudReadEvent<T> implements CrudEvent<T> {
  const CrudReadEvent({required this.id});
  

 final  String id;

/// Create a copy of CrudEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrudReadEventCopyWith<T, CrudReadEvent<T>> get copyWith => _$CrudReadEventCopyWithImpl<T, CrudReadEvent<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrudReadEvent<T>&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'CrudEvent<$T>.read(id: $id)';
}


}

/// @nodoc
abstract mixin class $CrudReadEventCopyWith<T,$Res> implements $CrudEventCopyWith<T, $Res> {
  factory $CrudReadEventCopyWith(CrudReadEvent<T> value, $Res Function(CrudReadEvent<T>) _then) = _$CrudReadEventCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$CrudReadEventCopyWithImpl<T,$Res>
    implements $CrudReadEventCopyWith<T, $Res> {
  _$CrudReadEventCopyWithImpl(this._self, this._then);

  final CrudReadEvent<T> _self;
  final $Res Function(CrudReadEvent<T>) _then;

/// Create a copy of CrudEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(CrudReadEvent<T>(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CrudUpdateEvent<T> implements CrudEvent<T> {
  const CrudUpdateEvent({required this.id, required this.data});
  

 final  String id;
 final  T data;

/// Create a copy of CrudEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrudUpdateEventCopyWith<T, CrudUpdateEvent<T>> get copyWith => _$CrudUpdateEventCopyWithImpl<T, CrudUpdateEvent<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrudUpdateEvent<T>&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'CrudEvent<$T>.update(id: $id, data: $data)';
}


}

/// @nodoc
abstract mixin class $CrudUpdateEventCopyWith<T,$Res> implements $CrudEventCopyWith<T, $Res> {
  factory $CrudUpdateEventCopyWith(CrudUpdateEvent<T> value, $Res Function(CrudUpdateEvent<T>) _then) = _$CrudUpdateEventCopyWithImpl;
@useResult
$Res call({
 String id, T data
});




}
/// @nodoc
class _$CrudUpdateEventCopyWithImpl<T,$Res>
    implements $CrudUpdateEventCopyWith<T, $Res> {
  _$CrudUpdateEventCopyWithImpl(this._self, this._then);

  final CrudUpdateEvent<T> _self;
  final $Res Function(CrudUpdateEvent<T>) _then;

/// Create a copy of CrudEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,Object? data = freezed,}) {
  return _then(CrudUpdateEvent<T>(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc


class CrudDeleteEvent<T> implements CrudEvent<T> {
  const CrudDeleteEvent({required this.id});
  

 final  String id;

/// Create a copy of CrudEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrudDeleteEventCopyWith<T, CrudDeleteEvent<T>> get copyWith => _$CrudDeleteEventCopyWithImpl<T, CrudDeleteEvent<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrudDeleteEvent<T>&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'CrudEvent<$T>.delete(id: $id)';
}


}

/// @nodoc
abstract mixin class $CrudDeleteEventCopyWith<T,$Res> implements $CrudEventCopyWith<T, $Res> {
  factory $CrudDeleteEventCopyWith(CrudDeleteEvent<T> value, $Res Function(CrudDeleteEvent<T>) _then) = _$CrudDeleteEventCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$CrudDeleteEventCopyWithImpl<T,$Res>
    implements $CrudDeleteEventCopyWith<T, $Res> {
  _$CrudDeleteEventCopyWithImpl(this._self, this._then);

  final CrudDeleteEvent<T> _self;
  final $Res Function(CrudDeleteEvent<T>) _then;

/// Create a copy of CrudEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(CrudDeleteEvent<T>(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class CrudListEvent<T> implements CrudEvent<T> {
  const CrudListEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrudListEvent<T>);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CrudEvent<$T>.list()';
}


}




/// @nodoc
mixin _$SearchEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchEvent()';
}


}

/// @nodoc
class $SearchEventCopyWith<$Res>  {
$SearchEventCopyWith(SearchEvent _, $Res Function(SearchEvent) __);
}


/// Adds pattern-matching-related methods to [SearchEvent].
extension SearchEventPatterns on SearchEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SearchQueryEvent value)?  search,TResult Function( SearchFilterEvent value)?  filter,TResult Function( SearchSortEvent value)?  sort,TResult Function( SearchClearEvent value)?  clear,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SearchQueryEvent() when search != null:
return search(_that);case SearchFilterEvent() when filter != null:
return filter(_that);case SearchSortEvent() when sort != null:
return sort(_that);case SearchClearEvent() when clear != null:
return clear(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SearchQueryEvent value)  search,required TResult Function( SearchFilterEvent value)  filter,required TResult Function( SearchSortEvent value)  sort,required TResult Function( SearchClearEvent value)  clear,}){
final _that = this;
switch (_that) {
case SearchQueryEvent():
return search(_that);case SearchFilterEvent():
return filter(_that);case SearchSortEvent():
return sort(_that);case SearchClearEvent():
return clear(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SearchQueryEvent value)?  search,TResult? Function( SearchFilterEvent value)?  filter,TResult? Function( SearchSortEvent value)?  sort,TResult? Function( SearchClearEvent value)?  clear,}){
final _that = this;
switch (_that) {
case SearchQueryEvent() when search != null:
return search(_that);case SearchFilterEvent() when filter != null:
return filter(_that);case SearchSortEvent() when sort != null:
return sort(_that);case SearchClearEvent() when clear != null:
return clear(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query)?  search,TResult Function( Map<String, dynamic> filters)?  filter,TResult Function( String sortBy,  bool ascending)?  sort,TResult Function()?  clear,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SearchQueryEvent() when search != null:
return search(_that.query);case SearchFilterEvent() when filter != null:
return filter(_that.filters);case SearchSortEvent() when sort != null:
return sort(_that.sortBy,_that.ascending);case SearchClearEvent() when clear != null:
return clear();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query)  search,required TResult Function( Map<String, dynamic> filters)  filter,required TResult Function( String sortBy,  bool ascending)  sort,required TResult Function()  clear,}) {final _that = this;
switch (_that) {
case SearchQueryEvent():
return search(_that.query);case SearchFilterEvent():
return filter(_that.filters);case SearchSortEvent():
return sort(_that.sortBy,_that.ascending);case SearchClearEvent():
return clear();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query)?  search,TResult? Function( Map<String, dynamic> filters)?  filter,TResult? Function( String sortBy,  bool ascending)?  sort,TResult? Function()?  clear,}) {final _that = this;
switch (_that) {
case SearchQueryEvent() when search != null:
return search(_that.query);case SearchFilterEvent() when filter != null:
return filter(_that.filters);case SearchSortEvent() when sort != null:
return sort(_that.sortBy,_that.ascending);case SearchClearEvent() when clear != null:
return clear();case _:
  return null;

}
}

}

/// @nodoc


class SearchQueryEvent implements SearchEvent {
  const SearchQueryEvent({required this.query});
  

 final  String query;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchQueryEventCopyWith<SearchQueryEvent> get copyWith => _$SearchQueryEventCopyWithImpl<SearchQueryEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchQueryEvent&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'SearchEvent.search(query: $query)';
}


}

/// @nodoc
abstract mixin class $SearchQueryEventCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $SearchQueryEventCopyWith(SearchQueryEvent value, $Res Function(SearchQueryEvent) _then) = _$SearchQueryEventCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$SearchQueryEventCopyWithImpl<$Res>
    implements $SearchQueryEventCopyWith<$Res> {
  _$SearchQueryEventCopyWithImpl(this._self, this._then);

  final SearchQueryEvent _self;
  final $Res Function(SearchQueryEvent) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(SearchQueryEvent(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SearchFilterEvent implements SearchEvent {
  const SearchFilterEvent({required final  Map<String, dynamic> filters}): _filters = filters;
  

 final  Map<String, dynamic> _filters;
 Map<String, dynamic> get filters {
  if (_filters is EqualUnmodifiableMapView) return _filters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_filters);
}


/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchFilterEventCopyWith<SearchFilterEvent> get copyWith => _$SearchFilterEventCopyWithImpl<SearchFilterEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchFilterEvent&&const DeepCollectionEquality().equals(other._filters, _filters));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_filters));

@override
String toString() {
  return 'SearchEvent.filter(filters: $filters)';
}


}

/// @nodoc
abstract mixin class $SearchFilterEventCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $SearchFilterEventCopyWith(SearchFilterEvent value, $Res Function(SearchFilterEvent) _then) = _$SearchFilterEventCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> filters
});




}
/// @nodoc
class _$SearchFilterEventCopyWithImpl<$Res>
    implements $SearchFilterEventCopyWith<$Res> {
  _$SearchFilterEventCopyWithImpl(this._self, this._then);

  final SearchFilterEvent _self;
  final $Res Function(SearchFilterEvent) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filters = null,}) {
  return _then(SearchFilterEvent(
filters: null == filters ? _self._filters : filters // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

/// @nodoc


class SearchSortEvent implements SearchEvent {
  const SearchSortEvent({required this.sortBy, this.ascending = true});
  

 final  String sortBy;
@JsonKey() final  bool ascending;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchSortEventCopyWith<SearchSortEvent> get copyWith => _$SearchSortEventCopyWithImpl<SearchSortEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchSortEvent&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.ascending, ascending) || other.ascending == ascending));
}


@override
int get hashCode => Object.hash(runtimeType,sortBy,ascending);

@override
String toString() {
  return 'SearchEvent.sort(sortBy: $sortBy, ascending: $ascending)';
}


}

/// @nodoc
abstract mixin class $SearchSortEventCopyWith<$Res> implements $SearchEventCopyWith<$Res> {
  factory $SearchSortEventCopyWith(SearchSortEvent value, $Res Function(SearchSortEvent) _then) = _$SearchSortEventCopyWithImpl;
@useResult
$Res call({
 String sortBy, bool ascending
});




}
/// @nodoc
class _$SearchSortEventCopyWithImpl<$Res>
    implements $SearchSortEventCopyWith<$Res> {
  _$SearchSortEventCopyWithImpl(this._self, this._then);

  final SearchSortEvent _self;
  final $Res Function(SearchSortEvent) _then;

/// Create a copy of SearchEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sortBy = null,Object? ascending = null,}) {
  return _then(SearchSortEvent(
sortBy: null == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String,ascending: null == ascending ? _self.ascending : ascending // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class SearchClearEvent implements SearchEvent {
  const SearchClearEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchClearEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SearchEvent.clear()';
}


}




/// @nodoc
mixin _$PaginationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaginationEvent()';
}


}

/// @nodoc
class $PaginationEventCopyWith<$Res>  {
$PaginationEventCopyWith(PaginationEvent _, $Res Function(PaginationEvent) __);
}


/// Adds pattern-matching-related methods to [PaginationEvent].
extension PaginationEventPatterns on PaginationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PaginationFetchPageEvent value)?  fetchPage,TResult Function( PaginationLoadMoreEvent value)?  loadMore,TResult Function( PaginationRefreshEvent value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PaginationFetchPageEvent() when fetchPage != null:
return fetchPage(_that);case PaginationLoadMoreEvent() when loadMore != null:
return loadMore(_that);case PaginationRefreshEvent() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PaginationFetchPageEvent value)  fetchPage,required TResult Function( PaginationLoadMoreEvent value)  loadMore,required TResult Function( PaginationRefreshEvent value)  refresh,}){
final _that = this;
switch (_that) {
case PaginationFetchPageEvent():
return fetchPage(_that);case PaginationLoadMoreEvent():
return loadMore(_that);case PaginationRefreshEvent():
return refresh(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PaginationFetchPageEvent value)?  fetchPage,TResult? Function( PaginationLoadMoreEvent value)?  loadMore,TResult? Function( PaginationRefreshEvent value)?  refresh,}){
final _that = this;
switch (_that) {
case PaginationFetchPageEvent() when fetchPage != null:
return fetchPage(_that);case PaginationLoadMoreEvent() when loadMore != null:
return loadMore(_that);case PaginationRefreshEvent() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  int pageSize)?  fetchPage,TResult Function()?  loadMore,TResult Function()?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PaginationFetchPageEvent() when fetchPage != null:
return fetchPage(_that.page,_that.pageSize);case PaginationLoadMoreEvent() when loadMore != null:
return loadMore();case PaginationRefreshEvent() when refresh != null:
return refresh();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  int pageSize)  fetchPage,required TResult Function()  loadMore,required TResult Function()  refresh,}) {final _that = this;
switch (_that) {
case PaginationFetchPageEvent():
return fetchPage(_that.page,_that.pageSize);case PaginationLoadMoreEvent():
return loadMore();case PaginationRefreshEvent():
return refresh();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  int pageSize)?  fetchPage,TResult? Function()?  loadMore,TResult? Function()?  refresh,}) {final _that = this;
switch (_that) {
case PaginationFetchPageEvent() when fetchPage != null:
return fetchPage(_that.page,_that.pageSize);case PaginationLoadMoreEvent() when loadMore != null:
return loadMore();case PaginationRefreshEvent() when refresh != null:
return refresh();case _:
  return null;

}
}

}

/// @nodoc


class PaginationFetchPageEvent implements PaginationEvent {
  const PaginationFetchPageEvent({required this.page, this.pageSize = 20});
  

 final  int page;
@JsonKey() final  int pageSize;

/// Create a copy of PaginationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginationFetchPageEventCopyWith<PaginationFetchPageEvent> get copyWith => _$PaginationFetchPageEventCopyWithImpl<PaginationFetchPageEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationFetchPageEvent&&(identical(other.page, page) || other.page == page)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize));
}


@override
int get hashCode => Object.hash(runtimeType,page,pageSize);

@override
String toString() {
  return 'PaginationEvent.fetchPage(page: $page, pageSize: $pageSize)';
}


}

/// @nodoc
abstract mixin class $PaginationFetchPageEventCopyWith<$Res> implements $PaginationEventCopyWith<$Res> {
  factory $PaginationFetchPageEventCopyWith(PaginationFetchPageEvent value, $Res Function(PaginationFetchPageEvent) _then) = _$PaginationFetchPageEventCopyWithImpl;
@useResult
$Res call({
 int page, int pageSize
});




}
/// @nodoc
class _$PaginationFetchPageEventCopyWithImpl<$Res>
    implements $PaginationFetchPageEventCopyWith<$Res> {
  _$PaginationFetchPageEventCopyWithImpl(this._self, this._then);

  final PaginationFetchPageEvent _self;
  final $Res Function(PaginationFetchPageEvent) _then;

/// Create a copy of PaginationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? pageSize = null,}) {
  return _then(PaginationFetchPageEvent(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class PaginationLoadMoreEvent implements PaginationEvent {
  const PaginationLoadMoreEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationLoadMoreEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaginationEvent.loadMore()';
}


}




/// @nodoc


class PaginationRefreshEvent implements PaginationEvent {
  const PaginationRefreshEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginationRefreshEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaginationEvent.refresh()';
}


}




/// @nodoc
mixin _$FormEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FormEvent()';
}


}

/// @nodoc
class $FormEventCopyWith<$Res>  {
$FormEventCopyWith(FormEvent _, $Res Function(FormEvent) __);
}


/// Adds pattern-matching-related methods to [FormEvent].
extension FormEventPatterns on FormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FormFieldChangedEvent value)?  fieldChanged,TResult Function( FormValidateEvent value)?  validate,TResult Function( FormSubmitEvent value)?  submit,TResult Function( FormResetEvent value)?  reset,TResult Function( FormClearEvent value)?  clear,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FormFieldChangedEvent() when fieldChanged != null:
return fieldChanged(_that);case FormValidateEvent() when validate != null:
return validate(_that);case FormSubmitEvent() when submit != null:
return submit(_that);case FormResetEvent() when reset != null:
return reset(_that);case FormClearEvent() when clear != null:
return clear(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FormFieldChangedEvent value)  fieldChanged,required TResult Function( FormValidateEvent value)  validate,required TResult Function( FormSubmitEvent value)  submit,required TResult Function( FormResetEvent value)  reset,required TResult Function( FormClearEvent value)  clear,}){
final _that = this;
switch (_that) {
case FormFieldChangedEvent():
return fieldChanged(_that);case FormValidateEvent():
return validate(_that);case FormSubmitEvent():
return submit(_that);case FormResetEvent():
return reset(_that);case FormClearEvent():
return clear(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FormFieldChangedEvent value)?  fieldChanged,TResult? Function( FormValidateEvent value)?  validate,TResult? Function( FormSubmitEvent value)?  submit,TResult? Function( FormResetEvent value)?  reset,TResult? Function( FormClearEvent value)?  clear,}){
final _that = this;
switch (_that) {
case FormFieldChangedEvent() when fieldChanged != null:
return fieldChanged(_that);case FormValidateEvent() when validate != null:
return validate(_that);case FormSubmitEvent() when submit != null:
return submit(_that);case FormResetEvent() when reset != null:
return reset(_that);case FormClearEvent() when clear != null:
return clear(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String fieldName,  dynamic value)?  fieldChanged,TResult Function()?  validate,TResult Function()?  submit,TResult Function()?  reset,TResult Function()?  clear,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FormFieldChangedEvent() when fieldChanged != null:
return fieldChanged(_that.fieldName,_that.value);case FormValidateEvent() when validate != null:
return validate();case FormSubmitEvent() when submit != null:
return submit();case FormResetEvent() when reset != null:
return reset();case FormClearEvent() when clear != null:
return clear();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String fieldName,  dynamic value)  fieldChanged,required TResult Function()  validate,required TResult Function()  submit,required TResult Function()  reset,required TResult Function()  clear,}) {final _that = this;
switch (_that) {
case FormFieldChangedEvent():
return fieldChanged(_that.fieldName,_that.value);case FormValidateEvent():
return validate();case FormSubmitEvent():
return submit();case FormResetEvent():
return reset();case FormClearEvent():
return clear();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String fieldName,  dynamic value)?  fieldChanged,TResult? Function()?  validate,TResult? Function()?  submit,TResult? Function()?  reset,TResult? Function()?  clear,}) {final _that = this;
switch (_that) {
case FormFieldChangedEvent() when fieldChanged != null:
return fieldChanged(_that.fieldName,_that.value);case FormValidateEvent() when validate != null:
return validate();case FormSubmitEvent() when submit != null:
return submit();case FormResetEvent() when reset != null:
return reset();case FormClearEvent() when clear != null:
return clear();case _:
  return null;

}
}

}

/// @nodoc


class FormFieldChangedEvent implements FormEvent {
  const FormFieldChangedEvent({required this.fieldName, required this.value});
  

 final  String fieldName;
 final  dynamic value;

/// Create a copy of FormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormFieldChangedEventCopyWith<FormFieldChangedEvent> get copyWith => _$FormFieldChangedEventCopyWithImpl<FormFieldChangedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormFieldChangedEvent&&(identical(other.fieldName, fieldName) || other.fieldName == fieldName)&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode => Object.hash(runtimeType,fieldName,const DeepCollectionEquality().hash(value));

@override
String toString() {
  return 'FormEvent.fieldChanged(fieldName: $fieldName, value: $value)';
}


}

/// @nodoc
abstract mixin class $FormFieldChangedEventCopyWith<$Res> implements $FormEventCopyWith<$Res> {
  factory $FormFieldChangedEventCopyWith(FormFieldChangedEvent value, $Res Function(FormFieldChangedEvent) _then) = _$FormFieldChangedEventCopyWithImpl;
@useResult
$Res call({
 String fieldName, dynamic value
});




}
/// @nodoc
class _$FormFieldChangedEventCopyWithImpl<$Res>
    implements $FormFieldChangedEventCopyWith<$Res> {
  _$FormFieldChangedEventCopyWithImpl(this._self, this._then);

  final FormFieldChangedEvent _self;
  final $Res Function(FormFieldChangedEvent) _then;

/// Create a copy of FormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fieldName = null,Object? value = freezed,}) {
  return _then(FormFieldChangedEvent(
fieldName: null == fieldName ? _self.fieldName : fieldName // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}

/// @nodoc


class FormValidateEvent implements FormEvent {
  const FormValidateEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormValidateEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FormEvent.validate()';
}


}




/// @nodoc


class FormSubmitEvent implements FormEvent {
  const FormSubmitEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormSubmitEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FormEvent.submit()';
}


}




/// @nodoc


class FormResetEvent implements FormEvent {
  const FormResetEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormResetEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FormEvent.reset()';
}


}




/// @nodoc


class FormClearEvent implements FormEvent {
  const FormClearEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormClearEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FormEvent.clear()';
}


}




// dart format on
