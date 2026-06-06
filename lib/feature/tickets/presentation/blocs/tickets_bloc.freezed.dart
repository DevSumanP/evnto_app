// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tickets_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TicketsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TicketsEvent()';
}


}

/// @nodoc
class $TicketsEventCopyWith<$Res>  {
$TicketsEventCopyWith(TicketsEvent _, $Res Function(TicketsEvent) __);
}


/// Adds pattern-matching-related methods to [TicketsEvent].
extension TicketsEventPatterns on TicketsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TicketsStarted value)?  started,TResult Function( TicketsRefreshed value)?  refreshed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TicketsStarted() when started != null:
return started(_that);case TicketsRefreshed() when refreshed != null:
return refreshed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TicketsStarted value)  started,required TResult Function( TicketsRefreshed value)  refreshed,}){
final _that = this;
switch (_that) {
case TicketsStarted():
return started(_that);case TicketsRefreshed():
return refreshed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TicketsStarted value)?  started,TResult? Function( TicketsRefreshed value)?  refreshed,}){
final _that = this;
switch (_that) {
case TicketsStarted() when started != null:
return started(_that);case TicketsRefreshed() when refreshed != null:
return refreshed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TicketsStarted() when started != null:
return started();case TicketsRefreshed() when refreshed != null:
return refreshed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,}) {final _that = this;
switch (_that) {
case TicketsStarted():
return started();case TicketsRefreshed():
return refreshed();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,}) {final _that = this;
switch (_that) {
case TicketsStarted() when started != null:
return started();case TicketsRefreshed() when refreshed != null:
return refreshed();case _:
  return null;

}
}

}

/// @nodoc


class TicketsStarted implements TicketsEvent {
  const TicketsStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketsStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TicketsEvent.started()';
}


}




/// @nodoc


class TicketsRefreshed implements TicketsEvent {
  const TicketsRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketsRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TicketsEvent.refreshed()';
}


}




/// @nodoc
mixin _$TicketsState {

 TicketsStatus get status; List<TicketEntity> get tickets; String? get error;
/// Create a copy of TicketsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketsStateCopyWith<TicketsState> get copyWith => _$TicketsStateCopyWithImpl<TicketsState>(this as TicketsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.tickets, tickets)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(tickets),error);

@override
String toString() {
  return 'TicketsState(status: $status, tickets: $tickets, error: $error)';
}


}

/// @nodoc
abstract mixin class $TicketsStateCopyWith<$Res>  {
  factory $TicketsStateCopyWith(TicketsState value, $Res Function(TicketsState) _then) = _$TicketsStateCopyWithImpl;
@useResult
$Res call({
 TicketsStatus status, List<TicketEntity> tickets, String? error
});




}
/// @nodoc
class _$TicketsStateCopyWithImpl<$Res>
    implements $TicketsStateCopyWith<$Res> {
  _$TicketsStateCopyWithImpl(this._self, this._then);

  final TicketsState _self;
  final $Res Function(TicketsState) _then;

/// Create a copy of TicketsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? tickets = null,Object? error = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketsStatus,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<TicketEntity>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketsState].
extension TicketsStatePatterns on TicketsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketsState value)  $default,){
final _that = this;
switch (_that) {
case _TicketsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketsState value)?  $default,){
final _that = this;
switch (_that) {
case _TicketsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TicketsStatus status,  List<TicketEntity> tickets,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketsState() when $default != null:
return $default(_that.status,_that.tickets,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TicketsStatus status,  List<TicketEntity> tickets,  String? error)  $default,) {final _that = this;
switch (_that) {
case _TicketsState():
return $default(_that.status,_that.tickets,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TicketsStatus status,  List<TicketEntity> tickets,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _TicketsState() when $default != null:
return $default(_that.status,_that.tickets,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _TicketsState extends TicketsState {
  const _TicketsState({this.status = TicketsStatus.idle, final  List<TicketEntity> tickets = const <TicketEntity>[], this.error}): _tickets = tickets,super._();
  

@override@JsonKey() final  TicketsStatus status;
 final  List<TicketEntity> _tickets;
@override@JsonKey() List<TicketEntity> get tickets {
  if (_tickets is EqualUnmodifiableListView) return _tickets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tickets);
}

@override final  String? error;

/// Create a copy of TicketsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketsStateCopyWith<_TicketsState> get copyWith => __$TicketsStateCopyWithImpl<_TicketsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._tickets, _tickets)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_tickets),error);

@override
String toString() {
  return 'TicketsState(status: $status, tickets: $tickets, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TicketsStateCopyWith<$Res> implements $TicketsStateCopyWith<$Res> {
  factory _$TicketsStateCopyWith(_TicketsState value, $Res Function(_TicketsState) _then) = __$TicketsStateCopyWithImpl;
@override @useResult
$Res call({
 TicketsStatus status, List<TicketEntity> tickets, String? error
});




}
/// @nodoc
class __$TicketsStateCopyWithImpl<$Res>
    implements _$TicketsStateCopyWith<$Res> {
  __$TicketsStateCopyWithImpl(this._self, this._then);

  final _TicketsState _self;
  final $Res Function(_TicketsState) _then;

/// Create a copy of TicketsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? tickets = null,Object? error = freezed,}) {
  return _then(_TicketsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketsStatus,tickets: null == tickets ? _self._tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<TicketEntity>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
