// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_detail_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TicketDetailEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketDetailEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TicketDetailEvent()';
}


}

/// @nodoc
class $TicketDetailEventCopyWith<$Res>  {
$TicketDetailEventCopyWith(TicketDetailEvent _, $Res Function(TicketDetailEvent) __);
}


/// Adds pattern-matching-related methods to [TicketDetailEvent].
extension TicketDetailEventPatterns on TicketDetailEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TicketDetailStarted value)?  started,TResult Function( TicketDetailRefreshed value)?  refreshed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TicketDetailStarted() when started != null:
return started(_that);case TicketDetailRefreshed() when refreshed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TicketDetailStarted value)  started,required TResult Function( TicketDetailRefreshed value)  refreshed,}){
final _that = this;
switch (_that) {
case TicketDetailStarted():
return started(_that);case TicketDetailRefreshed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TicketDetailStarted value)?  started,TResult? Function( TicketDetailRefreshed value)?  refreshed,}){
final _that = this;
switch (_that) {
case TicketDetailStarted() when started != null:
return started(_that);case TicketDetailRefreshed() when refreshed != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticketId)?  started,TResult Function()?  refreshed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TicketDetailStarted() when started != null:
return started(_that.ticketId);case TicketDetailRefreshed() when refreshed != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticketId)  started,required TResult Function()  refreshed,}) {final _that = this;
switch (_that) {
case TicketDetailStarted():
return started(_that.ticketId);case TicketDetailRefreshed():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticketId)?  started,TResult? Function()?  refreshed,}) {final _that = this;
switch (_that) {
case TicketDetailStarted() when started != null:
return started(_that.ticketId);case TicketDetailRefreshed() when refreshed != null:
return refreshed();case _:
  return null;

}
}

}

/// @nodoc


class TicketDetailStarted implements TicketDetailEvent {
  const TicketDetailStarted(this.ticketId);
  

 final  String ticketId;

/// Create a copy of TicketDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketDetailStartedCopyWith<TicketDetailStarted> get copyWith => _$TicketDetailStartedCopyWithImpl<TicketDetailStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketDetailStarted&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId));
}


@override
int get hashCode => Object.hash(runtimeType,ticketId);

@override
String toString() {
  return 'TicketDetailEvent.started(ticketId: $ticketId)';
}


}

/// @nodoc
abstract mixin class $TicketDetailStartedCopyWith<$Res> implements $TicketDetailEventCopyWith<$Res> {
  factory $TicketDetailStartedCopyWith(TicketDetailStarted value, $Res Function(TicketDetailStarted) _then) = _$TicketDetailStartedCopyWithImpl;
@useResult
$Res call({
 String ticketId
});




}
/// @nodoc
class _$TicketDetailStartedCopyWithImpl<$Res>
    implements $TicketDetailStartedCopyWith<$Res> {
  _$TicketDetailStartedCopyWithImpl(this._self, this._then);

  final TicketDetailStarted _self;
  final $Res Function(TicketDetailStarted) _then;

/// Create a copy of TicketDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticketId = null,}) {
  return _then(TicketDetailStarted(
null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class TicketDetailRefreshed implements TicketDetailEvent {
  const TicketDetailRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketDetailRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TicketDetailEvent.refreshed()';
}


}




/// @nodoc
mixin _$TicketDetailState {

 String get ticketId; TicketDetailStatus get status; TicketQREntity? get qr; String? get error;
/// Create a copy of TicketDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketDetailStateCopyWith<TicketDetailState> get copyWith => _$TicketDetailStateCopyWithImpl<TicketDetailState>(this as TicketDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketDetailState&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.status, status) || other.status == status)&&(identical(other.qr, qr) || other.qr == qr)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,ticketId,status,qr,error);

@override
String toString() {
  return 'TicketDetailState(ticketId: $ticketId, status: $status, qr: $qr, error: $error)';
}


}

/// @nodoc
abstract mixin class $TicketDetailStateCopyWith<$Res>  {
  factory $TicketDetailStateCopyWith(TicketDetailState value, $Res Function(TicketDetailState) _then) = _$TicketDetailStateCopyWithImpl;
@useResult
$Res call({
 String ticketId, TicketDetailStatus status, TicketQREntity? qr, String? error
});




}
/// @nodoc
class _$TicketDetailStateCopyWithImpl<$Res>
    implements $TicketDetailStateCopyWith<$Res> {
  _$TicketDetailStateCopyWithImpl(this._self, this._then);

  final TicketDetailState _self;
  final $Res Function(TicketDetailState) _then;

/// Create a copy of TicketDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ticketId = null,Object? status = null,Object? qr = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
ticketId: null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketDetailStatus,qr: freezed == qr ? _self.qr : qr // ignore: cast_nullable_to_non_nullable
as TicketQREntity?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketDetailState].
extension TicketDetailStatePatterns on TicketDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketDetailState value)  $default,){
final _that = this;
switch (_that) {
case _TicketDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _TicketDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String ticketId,  TicketDetailStatus status,  TicketQREntity? qr,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketDetailState() when $default != null:
return $default(_that.ticketId,_that.status,_that.qr,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String ticketId,  TicketDetailStatus status,  TicketQREntity? qr,  String? error)  $default,) {final _that = this;
switch (_that) {
case _TicketDetailState():
return $default(_that.ticketId,_that.status,_that.qr,_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String ticketId,  TicketDetailStatus status,  TicketQREntity? qr,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _TicketDetailState() when $default != null:
return $default(_that.ticketId,_that.status,_that.qr,_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _TicketDetailState extends TicketDetailState {
  const _TicketDetailState({this.ticketId = '', this.status = TicketDetailStatus.idle, this.qr, this.error}): super._();
  

@override@JsonKey() final  String ticketId;
@override@JsonKey() final  TicketDetailStatus status;
@override final  TicketQREntity? qr;
@override final  String? error;

/// Create a copy of TicketDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketDetailStateCopyWith<_TicketDetailState> get copyWith => __$TicketDetailStateCopyWithImpl<_TicketDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketDetailState&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId)&&(identical(other.status, status) || other.status == status)&&(identical(other.qr, qr) || other.qr == qr)&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,ticketId,status,qr,error);

@override
String toString() {
  return 'TicketDetailState(ticketId: $ticketId, status: $status, qr: $qr, error: $error)';
}


}

/// @nodoc
abstract mixin class _$TicketDetailStateCopyWith<$Res> implements $TicketDetailStateCopyWith<$Res> {
  factory _$TicketDetailStateCopyWith(_TicketDetailState value, $Res Function(_TicketDetailState) _then) = __$TicketDetailStateCopyWithImpl;
@override @useResult
$Res call({
 String ticketId, TicketDetailStatus status, TicketQREntity? qr, String? error
});




}
/// @nodoc
class __$TicketDetailStateCopyWithImpl<$Res>
    implements _$TicketDetailStateCopyWith<$Res> {
  __$TicketDetailStateCopyWithImpl(this._self, this._then);

  final _TicketDetailState _self;
  final $Res Function(_TicketDetailState) _then;

/// Create a copy of TicketDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ticketId = null,Object? status = null,Object? qr = freezed,Object? error = freezed,}) {
  return _then(_TicketDetailState(
ticketId: null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketDetailStatus,qr: freezed == qr ? _self.qr : qr // ignore: cast_nullable_to_non_nullable
as TicketQREntity?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
