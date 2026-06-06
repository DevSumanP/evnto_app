// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileStarted value)?  started,TResult Function( ProfileRefreshed value)?  refreshed,TResult Function( ProfileSaveRequested value)?  saveRequested,TResult Function( ProfilePasswordChangeRequested value)?  passwordChangeRequested,TResult Function( ProfileAvatarChangeRequested value)?  avatarChangeRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileStarted() when started != null:
return started(_that);case ProfileRefreshed() when refreshed != null:
return refreshed(_that);case ProfileSaveRequested() when saveRequested != null:
return saveRequested(_that);case ProfilePasswordChangeRequested() when passwordChangeRequested != null:
return passwordChangeRequested(_that);case ProfileAvatarChangeRequested() when avatarChangeRequested != null:
return avatarChangeRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileStarted value)  started,required TResult Function( ProfileRefreshed value)  refreshed,required TResult Function( ProfileSaveRequested value)  saveRequested,required TResult Function( ProfilePasswordChangeRequested value)  passwordChangeRequested,required TResult Function( ProfileAvatarChangeRequested value)  avatarChangeRequested,}){
final _that = this;
switch (_that) {
case ProfileStarted():
return started(_that);case ProfileRefreshed():
return refreshed(_that);case ProfileSaveRequested():
return saveRequested(_that);case ProfilePasswordChangeRequested():
return passwordChangeRequested(_that);case ProfileAvatarChangeRequested():
return avatarChangeRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileStarted value)?  started,TResult? Function( ProfileRefreshed value)?  refreshed,TResult? Function( ProfileSaveRequested value)?  saveRequested,TResult? Function( ProfilePasswordChangeRequested value)?  passwordChangeRequested,TResult? Function( ProfileAvatarChangeRequested value)?  avatarChangeRequested,}){
final _that = this;
switch (_that) {
case ProfileStarted() when started != null:
return started(_that);case ProfileRefreshed() when refreshed != null:
return refreshed(_that);case ProfileSaveRequested() when saveRequested != null:
return saveRequested(_that);case ProfilePasswordChangeRequested() when passwordChangeRequested != null:
return passwordChangeRequested(_that);case ProfileAvatarChangeRequested() when avatarChangeRequested != null:
return avatarChangeRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refreshed,TResult Function( UpdateProfileParams params)?  saveRequested,TResult Function( String newPassword)?  passwordChangeRequested,TResult Function( File file)?  avatarChangeRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileStarted() when started != null:
return started();case ProfileRefreshed() when refreshed != null:
return refreshed();case ProfileSaveRequested() when saveRequested != null:
return saveRequested(_that.params);case ProfilePasswordChangeRequested() when passwordChangeRequested != null:
return passwordChangeRequested(_that.newPassword);case ProfileAvatarChangeRequested() when avatarChangeRequested != null:
return avatarChangeRequested(_that.file);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refreshed,required TResult Function( UpdateProfileParams params)  saveRequested,required TResult Function( String newPassword)  passwordChangeRequested,required TResult Function( File file)  avatarChangeRequested,}) {final _that = this;
switch (_that) {
case ProfileStarted():
return started();case ProfileRefreshed():
return refreshed();case ProfileSaveRequested():
return saveRequested(_that.params);case ProfilePasswordChangeRequested():
return passwordChangeRequested(_that.newPassword);case ProfileAvatarChangeRequested():
return avatarChangeRequested(_that.file);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refreshed,TResult? Function( UpdateProfileParams params)?  saveRequested,TResult? Function( String newPassword)?  passwordChangeRequested,TResult? Function( File file)?  avatarChangeRequested,}) {final _that = this;
switch (_that) {
case ProfileStarted() when started != null:
return started();case ProfileRefreshed() when refreshed != null:
return refreshed();case ProfileSaveRequested() when saveRequested != null:
return saveRequested(_that.params);case ProfilePasswordChangeRequested() when passwordChangeRequested != null:
return passwordChangeRequested(_that.newPassword);case ProfileAvatarChangeRequested() when avatarChangeRequested != null:
return avatarChangeRequested(_that.file);case _:
  return null;

}
}

}

/// @nodoc


class ProfileStarted implements ProfileEvent {
  const ProfileStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.started()';
}


}




/// @nodoc


class ProfileRefreshed implements ProfileEvent {
  const ProfileRefreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileRefreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.refreshed()';
}


}




/// @nodoc


class ProfileSaveRequested implements ProfileEvent {
  const ProfileSaveRequested(this.params);
  

 final  UpdateProfileParams params;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSaveRequestedCopyWith<ProfileSaveRequested> get copyWith => _$ProfileSaveRequestedCopyWithImpl<ProfileSaveRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSaveRequested&&(identical(other.params, params) || other.params == params));
}


@override
int get hashCode => Object.hash(runtimeType,params);

@override
String toString() {
  return 'ProfileEvent.saveRequested(params: $params)';
}


}

/// @nodoc
abstract mixin class $ProfileSaveRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfileSaveRequestedCopyWith(ProfileSaveRequested value, $Res Function(ProfileSaveRequested) _then) = _$ProfileSaveRequestedCopyWithImpl;
@useResult
$Res call({
 UpdateProfileParams params
});




}
/// @nodoc
class _$ProfileSaveRequestedCopyWithImpl<$Res>
    implements $ProfileSaveRequestedCopyWith<$Res> {
  _$ProfileSaveRequestedCopyWithImpl(this._self, this._then);

  final ProfileSaveRequested _self;
  final $Res Function(ProfileSaveRequested) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? params = null,}) {
  return _then(ProfileSaveRequested(
null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as UpdateProfileParams,
  ));
}


}

/// @nodoc


class ProfilePasswordChangeRequested implements ProfileEvent {
  const ProfilePasswordChangeRequested(this.newPassword);
  

 final  String newPassword;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilePasswordChangeRequestedCopyWith<ProfilePasswordChangeRequested> get copyWith => _$ProfilePasswordChangeRequestedCopyWithImpl<ProfilePasswordChangeRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilePasswordChangeRequested&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword));
}


@override
int get hashCode => Object.hash(runtimeType,newPassword);

@override
String toString() {
  return 'ProfileEvent.passwordChangeRequested(newPassword: $newPassword)';
}


}

/// @nodoc
abstract mixin class $ProfilePasswordChangeRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfilePasswordChangeRequestedCopyWith(ProfilePasswordChangeRequested value, $Res Function(ProfilePasswordChangeRequested) _then) = _$ProfilePasswordChangeRequestedCopyWithImpl;
@useResult
$Res call({
 String newPassword
});




}
/// @nodoc
class _$ProfilePasswordChangeRequestedCopyWithImpl<$Res>
    implements $ProfilePasswordChangeRequestedCopyWith<$Res> {
  _$ProfilePasswordChangeRequestedCopyWithImpl(this._self, this._then);

  final ProfilePasswordChangeRequested _self;
  final $Res Function(ProfilePasswordChangeRequested) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? newPassword = null,}) {
  return _then(ProfilePasswordChangeRequested(
null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProfileAvatarChangeRequested implements ProfileEvent {
  const ProfileAvatarChangeRequested(this.file);
  

 final  File file;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileAvatarChangeRequestedCopyWith<ProfileAvatarChangeRequested> get copyWith => _$ProfileAvatarChangeRequestedCopyWithImpl<ProfileAvatarChangeRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileAvatarChangeRequested&&(identical(other.file, file) || other.file == file));
}


@override
int get hashCode => Object.hash(runtimeType,file);

@override
String toString() {
  return 'ProfileEvent.avatarChangeRequested(file: $file)';
}


}

/// @nodoc
abstract mixin class $ProfileAvatarChangeRequestedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfileAvatarChangeRequestedCopyWith(ProfileAvatarChangeRequested value, $Res Function(ProfileAvatarChangeRequested) _then) = _$ProfileAvatarChangeRequestedCopyWithImpl;
@useResult
$Res call({
 File file
});




}
/// @nodoc
class _$ProfileAvatarChangeRequestedCopyWithImpl<$Res>
    implements $ProfileAvatarChangeRequestedCopyWith<$Res> {
  _$ProfileAvatarChangeRequestedCopyWithImpl(this._self, this._then);

  final ProfileAvatarChangeRequested _self;
  final $Res Function(ProfileAvatarChangeRequested) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? file = null,}) {
  return _then(ProfileAvatarChangeRequested(
null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc
mixin _$ProfileState {

 ProfileStatus get status; UserProfile? get profile; String? get error; ProfileSaveStatus get saveStatus; String? get saveError; bool get isUploadingAvatar;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.status, status) || other.status == status)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.error, error) || other.error == error)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.saveError, saveError) || other.saveError == saveError)&&(identical(other.isUploadingAvatar, isUploadingAvatar) || other.isUploadingAvatar == isUploadingAvatar));
}


@override
int get hashCode => Object.hash(runtimeType,status,profile,error,saveStatus,saveError,isUploadingAvatar);

@override
String toString() {
  return 'ProfileState(status: $status, profile: $profile, error: $error, saveStatus: $saveStatus, saveError: $saveError, isUploadingAvatar: $isUploadingAvatar)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 ProfileStatus status, UserProfile? profile, String? error, ProfileSaveStatus saveStatus, String? saveError, bool isUploadingAvatar
});




}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? profile = freezed,Object? error = freezed,Object? saveStatus = null,Object? saveError = freezed,Object? isUploadingAvatar = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileStatus,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as ProfileSaveStatus,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,isUploadingAvatar: null == isUploadingAvatar ? _self.isUploadingAvatar : isUploadingAvatar // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProfileStatus status,  UserProfile? profile,  String? error,  ProfileSaveStatus saveStatus,  String? saveError,  bool isUploadingAvatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.status,_that.profile,_that.error,_that.saveStatus,_that.saveError,_that.isUploadingAvatar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProfileStatus status,  UserProfile? profile,  String? error,  ProfileSaveStatus saveStatus,  String? saveError,  bool isUploadingAvatar)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.status,_that.profile,_that.error,_that.saveStatus,_that.saveError,_that.isUploadingAvatar);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProfileStatus status,  UserProfile? profile,  String? error,  ProfileSaveStatus saveStatus,  String? saveError,  bool isUploadingAvatar)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.status,_that.profile,_that.error,_that.saveStatus,_that.saveError,_that.isUploadingAvatar);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState extends ProfileState {
  const _ProfileState({this.status = ProfileStatus.idle, this.profile, this.error, this.saveStatus = ProfileSaveStatus.idle, this.saveError, this.isUploadingAvatar = false}): super._();
  

@override@JsonKey() final  ProfileStatus status;
@override final  UserProfile? profile;
@override final  String? error;
@override@JsonKey() final  ProfileSaveStatus saveStatus;
@override final  String? saveError;
@override@JsonKey() final  bool isUploadingAvatar;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.status, status) || other.status == status)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.error, error) || other.error == error)&&(identical(other.saveStatus, saveStatus) || other.saveStatus == saveStatus)&&(identical(other.saveError, saveError) || other.saveError == saveError)&&(identical(other.isUploadingAvatar, isUploadingAvatar) || other.isUploadingAvatar == isUploadingAvatar));
}


@override
int get hashCode => Object.hash(runtimeType,status,profile,error,saveStatus,saveError,isUploadingAvatar);

@override
String toString() {
  return 'ProfileState(status: $status, profile: $profile, error: $error, saveStatus: $saveStatus, saveError: $saveError, isUploadingAvatar: $isUploadingAvatar)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 ProfileStatus status, UserProfile? profile, String? error, ProfileSaveStatus saveStatus, String? saveError, bool isUploadingAvatar
});




}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? profile = freezed,Object? error = freezed,Object? saveStatus = null,Object? saveError = freezed,Object? isUploadingAvatar = null,}) {
  return _then(_ProfileState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileStatus,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as UserProfile?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,saveStatus: null == saveStatus ? _self.saveStatus : saveStatus // ignore: cast_nullable_to_non_nullable
as ProfileSaveStatus,saveError: freezed == saveError ? _self.saveError : saveError // ignore: cast_nullable_to_non_nullable
as String?,isUploadingAvatar: null == isUploadingAvatar ? _self.isUploadingAvatar : isUploadingAvatar // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
