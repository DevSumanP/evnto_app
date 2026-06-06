// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent()';
}


}

/// @nodoc
class $SettingsEventCopyWith<$Res>  {
$SettingsEventCopyWith(SettingsEvent _, $Res Function(SettingsEvent) __);
}


/// Adds pattern-matching-related methods to [SettingsEvent].
extension SettingsEventPatterns on SettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SettingsStarted value)?  started,TResult Function( SettingsNotificationsToggled value)?  notificationsToggled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SettingsStarted() when started != null:
return started(_that);case SettingsNotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SettingsStarted value)  started,required TResult Function( SettingsNotificationsToggled value)  notificationsToggled,}){
final _that = this;
switch (_that) {
case SettingsStarted():
return started(_that);case SettingsNotificationsToggled():
return notificationsToggled(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SettingsStarted value)?  started,TResult? Function( SettingsNotificationsToggled value)?  notificationsToggled,}){
final _that = this;
switch (_that) {
case SettingsStarted() when started != null:
return started(_that);case SettingsNotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( bool enabled)?  notificationsToggled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SettingsStarted() when started != null:
return started();case SettingsNotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( bool enabled)  notificationsToggled,}) {final _that = this;
switch (_that) {
case SettingsStarted():
return started();case SettingsNotificationsToggled():
return notificationsToggled(_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( bool enabled)?  notificationsToggled,}) {final _that = this;
switch (_that) {
case SettingsStarted() when started != null:
return started();case SettingsNotificationsToggled() when notificationsToggled != null:
return notificationsToggled(_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class SettingsStarted implements SettingsEvent {
  const SettingsStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SettingsEvent.started()';
}


}




/// @nodoc


class SettingsNotificationsToggled implements SettingsEvent {
  const SettingsNotificationsToggled(this.enabled);
  

 final  bool enabled;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsNotificationsToggledCopyWith<SettingsNotificationsToggled> get copyWith => _$SettingsNotificationsToggledCopyWithImpl<SettingsNotificationsToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsNotificationsToggled&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'SettingsEvent.notificationsToggled(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $SettingsNotificationsToggledCopyWith<$Res> implements $SettingsEventCopyWith<$Res> {
  factory $SettingsNotificationsToggledCopyWith(SettingsNotificationsToggled value, $Res Function(SettingsNotificationsToggled) _then) = _$SettingsNotificationsToggledCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class _$SettingsNotificationsToggledCopyWithImpl<$Res>
    implements $SettingsNotificationsToggledCopyWith<$Res> {
  _$SettingsNotificationsToggledCopyWithImpl(this._self, this._then);

  final SettingsNotificationsToggled _self;
  final $Res Function(SettingsNotificationsToggled) _then;

/// Create a copy of SettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(SettingsNotificationsToggled(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SettingsState {

 bool get notificationEnabled; NotifToggleStatus get notifStatus; String? get notifError;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.notifStatus, notifStatus) || other.notifStatus == notifStatus)&&(identical(other.notifError, notifError) || other.notifError == notifError));
}


@override
int get hashCode => Object.hash(runtimeType,notificationEnabled,notifStatus,notifError);

@override
String toString() {
  return 'SettingsState(notificationEnabled: $notificationEnabled, notifStatus: $notifStatus, notifError: $notifError)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 bool notificationEnabled, NotifToggleStatus notifStatus, String? notifError
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notificationEnabled = null,Object? notifStatus = null,Object? notifError = freezed,}) {
  return _then(_self.copyWith(
notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,notifStatus: null == notifStatus ? _self.notifStatus : notifStatus // ignore: cast_nullable_to_non_nullable
as NotifToggleStatus,notifError: freezed == notifError ? _self.notifError : notifError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool notificationEnabled,  NotifToggleStatus notifStatus,  String? notifError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.notificationEnabled,_that.notifStatus,_that.notifError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool notificationEnabled,  NotifToggleStatus notifStatus,  String? notifError)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.notificationEnabled,_that.notifStatus,_that.notifError);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool notificationEnabled,  NotifToggleStatus notifStatus,  String? notifError)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.notificationEnabled,_that.notifStatus,_that.notifError);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState extends SettingsState {
  const _SettingsState({this.notificationEnabled = true, this.notifStatus = NotifToggleStatus.idle, this.notifError}): super._();
  

@override@JsonKey() final  bool notificationEnabled;
@override@JsonKey() final  NotifToggleStatus notifStatus;
@override final  String? notifError;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.notificationEnabled, notificationEnabled) || other.notificationEnabled == notificationEnabled)&&(identical(other.notifStatus, notifStatus) || other.notifStatus == notifStatus)&&(identical(other.notifError, notifError) || other.notifError == notifError));
}


@override
int get hashCode => Object.hash(runtimeType,notificationEnabled,notifStatus,notifError);

@override
String toString() {
  return 'SettingsState(notificationEnabled: $notificationEnabled, notifStatus: $notifStatus, notifError: $notifError)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool notificationEnabled, NotifToggleStatus notifStatus, String? notifError
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notificationEnabled = null,Object? notifStatus = null,Object? notifError = freezed,}) {
  return _then(_SettingsState(
notificationEnabled: null == notificationEnabled ? _self.notificationEnabled : notificationEnabled // ignore: cast_nullable_to_non_nullable
as bool,notifStatus: null == notifStatus ? _self.notifStatus : notifStatus // ignore: cast_nullable_to_non_nullable
as NotifToggleStatus,notifError: freezed == notifError ? _self.notifError : notifError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
