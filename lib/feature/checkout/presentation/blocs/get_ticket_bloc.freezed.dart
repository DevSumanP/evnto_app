// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_ticket_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GetTicketEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTicketEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetTicketEvent()';
}


}

/// @nodoc
class $GetTicketEventCopyWith<$Res>  {
$GetTicketEventCopyWith(GetTicketEvent _, $Res Function(GetTicketEvent) __);
}


/// Adds pattern-matching-related methods to [GetTicketEvent].
extension GetTicketEventPatterns on GetTicketEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GetTicketStarted value)?  started,TResult Function( GetTicketIncremented value)?  incremented,TResult Function( GetTicketDecremented value)?  decremented,TResult Function( GetTicketCleared value)?  cleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GetTicketStarted() when started != null:
return started(_that);case GetTicketIncremented() when incremented != null:
return incremented(_that);case GetTicketDecremented() when decremented != null:
return decremented(_that);case GetTicketCleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GetTicketStarted value)  started,required TResult Function( GetTicketIncremented value)  incremented,required TResult Function( GetTicketDecremented value)  decremented,required TResult Function( GetTicketCleared value)  cleared,}){
final _that = this;
switch (_that) {
case GetTicketStarted():
return started(_that);case GetTicketIncremented():
return incremented(_that);case GetTicketDecremented():
return decremented(_that);case GetTicketCleared():
return cleared(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GetTicketStarted value)?  started,TResult? Function( GetTicketIncremented value)?  incremented,TResult? Function( GetTicketDecremented value)?  decremented,TResult? Function( GetTicketCleared value)?  cleared,}){
final _that = this;
switch (_that) {
case GetTicketStarted() when started != null:
return started(_that);case GetTicketIncremented() when incremented != null:
return incremented(_that);case GetTicketDecremented() when decremented != null:
return decremented(_that);case GetTicketCleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String eventId,  List<TicketTier> tiers)?  started,TResult Function( String tierId)?  incremented,TResult Function( String tierId)?  decremented,TResult Function()?  cleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GetTicketStarted() when started != null:
return started(_that.eventId,_that.tiers);case GetTicketIncremented() when incremented != null:
return incremented(_that.tierId);case GetTicketDecremented() when decremented != null:
return decremented(_that.tierId);case GetTicketCleared() when cleared != null:
return cleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String eventId,  List<TicketTier> tiers)  started,required TResult Function( String tierId)  incremented,required TResult Function( String tierId)  decremented,required TResult Function()  cleared,}) {final _that = this;
switch (_that) {
case GetTicketStarted():
return started(_that.eventId,_that.tiers);case GetTicketIncremented():
return incremented(_that.tierId);case GetTicketDecremented():
return decremented(_that.tierId);case GetTicketCleared():
return cleared();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String eventId,  List<TicketTier> tiers)?  started,TResult? Function( String tierId)?  incremented,TResult? Function( String tierId)?  decremented,TResult? Function()?  cleared,}) {final _that = this;
switch (_that) {
case GetTicketStarted() when started != null:
return started(_that.eventId,_that.tiers);case GetTicketIncremented() when incremented != null:
return incremented(_that.tierId);case GetTicketDecremented() when decremented != null:
return decremented(_that.tierId);case GetTicketCleared() when cleared != null:
return cleared();case _:
  return null;

}
}

}

/// @nodoc


class GetTicketStarted implements GetTicketEvent {
  const GetTicketStarted({required this.eventId, required final  List<TicketTier> tiers}): _tiers = tiers;
  

 final  String eventId;
 final  List<TicketTier> _tiers;
 List<TicketTier> get tiers {
  if (_tiers is EqualUnmodifiableListView) return _tiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tiers);
}


/// Create a copy of GetTicketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetTicketStartedCopyWith<GetTicketStarted> get copyWith => _$GetTicketStartedCopyWithImpl<GetTicketStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTicketStarted&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other._tiers, _tiers));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,const DeepCollectionEquality().hash(_tiers));

@override
String toString() {
  return 'GetTicketEvent.started(eventId: $eventId, tiers: $tiers)';
}


}

/// @nodoc
abstract mixin class $GetTicketStartedCopyWith<$Res> implements $GetTicketEventCopyWith<$Res> {
  factory $GetTicketStartedCopyWith(GetTicketStarted value, $Res Function(GetTicketStarted) _then) = _$GetTicketStartedCopyWithImpl;
@useResult
$Res call({
 String eventId, List<TicketTier> tiers
});




}
/// @nodoc
class _$GetTicketStartedCopyWithImpl<$Res>
    implements $GetTicketStartedCopyWith<$Res> {
  _$GetTicketStartedCopyWithImpl(this._self, this._then);

  final GetTicketStarted _self;
  final $Res Function(GetTicketStarted) _then;

/// Create a copy of GetTicketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? tiers = null,}) {
  return _then(GetTicketStarted(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,tiers: null == tiers ? _self._tiers : tiers // ignore: cast_nullable_to_non_nullable
as List<TicketTier>,
  ));
}


}

/// @nodoc


class GetTicketIncremented implements GetTicketEvent {
  const GetTicketIncremented(this.tierId);
  

 final  String tierId;

/// Create a copy of GetTicketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetTicketIncrementedCopyWith<GetTicketIncremented> get copyWith => _$GetTicketIncrementedCopyWithImpl<GetTicketIncremented>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTicketIncremented&&(identical(other.tierId, tierId) || other.tierId == tierId));
}


@override
int get hashCode => Object.hash(runtimeType,tierId);

@override
String toString() {
  return 'GetTicketEvent.incremented(tierId: $tierId)';
}


}

/// @nodoc
abstract mixin class $GetTicketIncrementedCopyWith<$Res> implements $GetTicketEventCopyWith<$Res> {
  factory $GetTicketIncrementedCopyWith(GetTicketIncremented value, $Res Function(GetTicketIncremented) _then) = _$GetTicketIncrementedCopyWithImpl;
@useResult
$Res call({
 String tierId
});




}
/// @nodoc
class _$GetTicketIncrementedCopyWithImpl<$Res>
    implements $GetTicketIncrementedCopyWith<$Res> {
  _$GetTicketIncrementedCopyWithImpl(this._self, this._then);

  final GetTicketIncremented _self;
  final $Res Function(GetTicketIncremented) _then;

/// Create a copy of GetTicketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tierId = null,}) {
  return _then(GetTicketIncremented(
null == tierId ? _self.tierId : tierId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class GetTicketDecremented implements GetTicketEvent {
  const GetTicketDecremented(this.tierId);
  

 final  String tierId;

/// Create a copy of GetTicketEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetTicketDecrementedCopyWith<GetTicketDecremented> get copyWith => _$GetTicketDecrementedCopyWithImpl<GetTicketDecremented>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTicketDecremented&&(identical(other.tierId, tierId) || other.tierId == tierId));
}


@override
int get hashCode => Object.hash(runtimeType,tierId);

@override
String toString() {
  return 'GetTicketEvent.decremented(tierId: $tierId)';
}


}

/// @nodoc
abstract mixin class $GetTicketDecrementedCopyWith<$Res> implements $GetTicketEventCopyWith<$Res> {
  factory $GetTicketDecrementedCopyWith(GetTicketDecremented value, $Res Function(GetTicketDecremented) _then) = _$GetTicketDecrementedCopyWithImpl;
@useResult
$Res call({
 String tierId
});




}
/// @nodoc
class _$GetTicketDecrementedCopyWithImpl<$Res>
    implements $GetTicketDecrementedCopyWith<$Res> {
  _$GetTicketDecrementedCopyWithImpl(this._self, this._then);

  final GetTicketDecremented _self;
  final $Res Function(GetTicketDecremented) _then;

/// Create a copy of GetTicketEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? tierId = null,}) {
  return _then(GetTicketDecremented(
null == tierId ? _self.tierId : tierId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class GetTicketCleared implements GetTicketEvent {
  const GetTicketCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTicketCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GetTicketEvent.cleared()';
}


}




/// @nodoc
mixin _$GetTicketState {

 String get eventId; List<TicketTier> get tiers; Map<String, int> get quantities; CurrentUser? get buyer;
/// Create a copy of GetTicketState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetTicketStateCopyWith<GetTicketState> get copyWith => _$GetTicketStateCopyWithImpl<GetTicketState>(this as GetTicketState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTicketState&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other.tiers, tiers)&&const DeepCollectionEquality().equals(other.quantities, quantities)&&(identical(other.buyer, buyer) || other.buyer == buyer));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,const DeepCollectionEquality().hash(tiers),const DeepCollectionEquality().hash(quantities),buyer);

@override
String toString() {
  return 'GetTicketState(eventId: $eventId, tiers: $tiers, quantities: $quantities, buyer: $buyer)';
}


}

/// @nodoc
abstract mixin class $GetTicketStateCopyWith<$Res>  {
  factory $GetTicketStateCopyWith(GetTicketState value, $Res Function(GetTicketState) _then) = _$GetTicketStateCopyWithImpl;
@useResult
$Res call({
 String eventId, List<TicketTier> tiers, Map<String, int> quantities, CurrentUser? buyer
});




}
/// @nodoc
class _$GetTicketStateCopyWithImpl<$Res>
    implements $GetTicketStateCopyWith<$Res> {
  _$GetTicketStateCopyWithImpl(this._self, this._then);

  final GetTicketState _self;
  final $Res Function(GetTicketState) _then;

/// Create a copy of GetTicketState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? tiers = null,Object? quantities = null,Object? buyer = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,tiers: null == tiers ? _self.tiers : tiers // ignore: cast_nullable_to_non_nullable
as List<TicketTier>,quantities: null == quantities ? _self.quantities : quantities // ignore: cast_nullable_to_non_nullable
as Map<String, int>,buyer: freezed == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as CurrentUser?,
  ));
}

}


/// Adds pattern-matching-related methods to [GetTicketState].
extension GetTicketStatePatterns on GetTicketState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetTicketState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetTicketState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetTicketState value)  $default,){
final _that = this;
switch (_that) {
case _GetTicketState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetTicketState value)?  $default,){
final _that = this;
switch (_that) {
case _GetTicketState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  List<TicketTier> tiers,  Map<String, int> quantities,  CurrentUser? buyer)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetTicketState() when $default != null:
return $default(_that.eventId,_that.tiers,_that.quantities,_that.buyer);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  List<TicketTier> tiers,  Map<String, int> quantities,  CurrentUser? buyer)  $default,) {final _that = this;
switch (_that) {
case _GetTicketState():
return $default(_that.eventId,_that.tiers,_that.quantities,_that.buyer);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  List<TicketTier> tiers,  Map<String, int> quantities,  CurrentUser? buyer)?  $default,) {final _that = this;
switch (_that) {
case _GetTicketState() when $default != null:
return $default(_that.eventId,_that.tiers,_that.quantities,_that.buyer);case _:
  return null;

}
}

}

/// @nodoc


class _GetTicketState extends GetTicketState {
  const _GetTicketState({this.eventId = '', final  List<TicketTier> tiers = const <TicketTier>[], final  Map<String, int> quantities = const <String, int>{}, this.buyer}): _tiers = tiers,_quantities = quantities,super._();
  

@override@JsonKey() final  String eventId;
 final  List<TicketTier> _tiers;
@override@JsonKey() List<TicketTier> get tiers {
  if (_tiers is EqualUnmodifiableListView) return _tiers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tiers);
}

 final  Map<String, int> _quantities;
@override@JsonKey() Map<String, int> get quantities {
  if (_quantities is EqualUnmodifiableMapView) return _quantities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_quantities);
}

@override final  CurrentUser? buyer;

/// Create a copy of GetTicketState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetTicketStateCopyWith<_GetTicketState> get copyWith => __$GetTicketStateCopyWithImpl<_GetTicketState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetTicketState&&(identical(other.eventId, eventId) || other.eventId == eventId)&&const DeepCollectionEquality().equals(other._tiers, _tiers)&&const DeepCollectionEquality().equals(other._quantities, _quantities)&&(identical(other.buyer, buyer) || other.buyer == buyer));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,const DeepCollectionEquality().hash(_tiers),const DeepCollectionEquality().hash(_quantities),buyer);

@override
String toString() {
  return 'GetTicketState(eventId: $eventId, tiers: $tiers, quantities: $quantities, buyer: $buyer)';
}


}

/// @nodoc
abstract mixin class _$GetTicketStateCopyWith<$Res> implements $GetTicketStateCopyWith<$Res> {
  factory _$GetTicketStateCopyWith(_GetTicketState value, $Res Function(_GetTicketState) _then) = __$GetTicketStateCopyWithImpl;
@override @useResult
$Res call({
 String eventId, List<TicketTier> tiers, Map<String, int> quantities, CurrentUser? buyer
});




}
/// @nodoc
class __$GetTicketStateCopyWithImpl<$Res>
    implements _$GetTicketStateCopyWith<$Res> {
  __$GetTicketStateCopyWithImpl(this._self, this._then);

  final _GetTicketState _self;
  final $Res Function(_GetTicketState) _then;

/// Create a copy of GetTicketState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? tiers = null,Object? quantities = null,Object? buyer = freezed,}) {
  return _then(_GetTicketState(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,tiers: null == tiers ? _self._tiers : tiers // ignore: cast_nullable_to_non_nullable
as List<TicketTier>,quantities: null == quantities ? _self._quantities : quantities // ignore: cast_nullable_to_non_nullable
as Map<String, int>,buyer: freezed == buyer ? _self.buyer : buyer // ignore: cast_nullable_to_non_nullable
as CurrentUser?,
  ));
}


}

// dart format on
