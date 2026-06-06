// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EventDetailEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventDetailEvent()';
}


}

/// @nodoc
class $EventDetailEventCopyWith<$Res>  {
$EventDetailEventCopyWith(EventDetailEvent _, $Res Function(EventDetailEvent) __);
}


/// Adds pattern-matching-related methods to [EventDetailEvent].
extension EventDetailEventPatterns on EventDetailEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EventDetailStarted value)?  started,TResult Function( EventDetailRetried value)?  retried,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EventDetailStarted() when started != null:
return started(_that);case EventDetailRetried() when retried != null:
return retried(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EventDetailStarted value)  started,required TResult Function( EventDetailRetried value)  retried,}){
final _that = this;
switch (_that) {
case EventDetailStarted():
return started(_that);case EventDetailRetried():
return retried(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EventDetailStarted value)?  started,TResult? Function( EventDetailRetried value)?  retried,}){
final _that = this;
switch (_that) {
case EventDetailStarted() when started != null:
return started(_that);case EventDetailRetried() when retried != null:
return retried(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String eventId)?  started,TResult Function()?  retried,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EventDetailStarted() when started != null:
return started(_that.eventId);case EventDetailRetried() when retried != null:
return retried();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String eventId)  started,required TResult Function()  retried,}) {final _that = this;
switch (_that) {
case EventDetailStarted():
return started(_that.eventId);case EventDetailRetried():
return retried();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String eventId)?  started,TResult? Function()?  retried,}) {final _that = this;
switch (_that) {
case EventDetailStarted() when started != null:
return started(_that.eventId);case EventDetailRetried() when retried != null:
return retried();case _:
  return null;

}
}

}

/// @nodoc


class EventDetailStarted implements EventDetailEvent {
  const EventDetailStarted(this.eventId);
  

 final  String eventId;

/// Create a copy of EventDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDetailStartedCopyWith<EventDetailStarted> get copyWith => _$EventDetailStartedCopyWithImpl<EventDetailStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailStarted&&(identical(other.eventId, eventId) || other.eventId == eventId));
}


@override
int get hashCode => Object.hash(runtimeType,eventId);

@override
String toString() {
  return 'EventDetailEvent.started(eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $EventDetailStartedCopyWith<$Res> implements $EventDetailEventCopyWith<$Res> {
  factory $EventDetailStartedCopyWith(EventDetailStarted value, $Res Function(EventDetailStarted) _then) = _$EventDetailStartedCopyWithImpl;
@useResult
$Res call({
 String eventId
});




}
/// @nodoc
class _$EventDetailStartedCopyWithImpl<$Res>
    implements $EventDetailStartedCopyWith<$Res> {
  _$EventDetailStartedCopyWithImpl(this._self, this._then);

  final EventDetailStarted _self;
  final $Res Function(EventDetailStarted) _then;

/// Create a copy of EventDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? eventId = null,}) {
  return _then(EventDetailStarted(
null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class EventDetailRetried implements EventDetailEvent {
  const EventDetailRetried();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailRetried);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EventDetailEvent.retried()';
}


}




/// @nodoc
mixin _$EventDetailState {

 String get eventId; EventDetailStatus get status; EventDetail? get detail; String? get error;
/// Create a copy of EventDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDetailStateCopyWith<EventDetailState> get copyWith => _$EventDetailStateCopyWithImpl<EventDetailState>(this as EventDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetailState&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,status,detail,error);

@override
String toString() {
  return 'EventDetailState(eventId: $eventId, status: $status, detail: $detail, error: $error)';
}


}

/// @nodoc
abstract mixin class $EventDetailStateCopyWith<$Res>  {
  factory $EventDetailStateCopyWith(EventDetailState value, $Res Function(EventDetailState) _then) = _$EventDetailStateCopyWithImpl;
@useResult
$Res call({
 String eventId, EventDetailStatus status, EventDetail? detail, String? error
});




}
/// @nodoc
class _$EventDetailStateCopyWithImpl<$Res>
    implements $EventDetailStateCopyWith<$Res> {
  _$EventDetailStateCopyWithImpl(this._self, this._then);

  final EventDetailState _self;
  final $Res Function(EventDetailState) _then;

/// Create a copy of EventDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? status = null,Object? detail = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventDetailStatus,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as EventDetail?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EventDetailState].
extension EventDetailStatePatterns on EventDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDetailState value)  $default,){
final _that = this;
switch (_that) {
case _EventDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _EventDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String eventId,  EventDetailStatus status,  EventDetail? detail,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDetailState() when $default != null:
return $default(_that.eventId,_that.status,_that.detail,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String eventId,  EventDetailStatus status,  EventDetail? detail,  String? error)  $default,) {final _that = this;
switch (_that) {
case _EventDetailState():
return $default(_that.eventId,_that.status,_that.detail,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String eventId,  EventDetailStatus status,  EventDetail? detail,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _EventDetailState() when $default != null:
return $default(_that.eventId,_that.status,_that.detail,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _EventDetailState extends EventDetailState {
  const _EventDetailState({this.eventId = '', this.status = EventDetailStatus.idle, this.detail, this.error}): super._();
  

@override@JsonKey() final  String eventId;
@override@JsonKey() final  EventDetailStatus status;
@override final  EventDetail? detail;
@override final  String? error;

/// Create a copy of EventDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDetailStateCopyWith<_EventDetailState> get copyWith => __$EventDetailStateCopyWithImpl<_EventDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDetailState&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.status, status) || other.status == status)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,eventId,status,detail,error);

@override
String toString() {
  return 'EventDetailState(eventId: $eventId, status: $status, detail: $detail, error: $error)';
}


}

/// @nodoc
abstract mixin class _$EventDetailStateCopyWith<$Res> implements $EventDetailStateCopyWith<$Res> {
  factory _$EventDetailStateCopyWith(_EventDetailState value, $Res Function(_EventDetailState) _then) = __$EventDetailStateCopyWithImpl;
@override @useResult
$Res call({
 String eventId, EventDetailStatus status, EventDetail? detail, String? error
});




}
/// @nodoc
class __$EventDetailStateCopyWithImpl<$Res>
    implements _$EventDetailStateCopyWith<$Res> {
  __$EventDetailStateCopyWithImpl(this._self, this._then);

  final _EventDetailState _self;
  final $Res Function(_EventDetailState) _then;

/// Create a copy of EventDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? status = null,Object? detail = freezed,Object? error = freezed,}) {
  return _then(_EventDetailState(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EventDetailStatus,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as EventDetail?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
