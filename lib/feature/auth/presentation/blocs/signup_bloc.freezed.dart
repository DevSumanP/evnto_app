// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignupEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignupEvent()';
}


}

/// @nodoc
class $SignupEventCopyWith<$Res>  {
$SignupEventCopyWith(SignupEvent _, $Res Function(SignupEvent) __);
}


/// Adds pattern-matching-related methods to [SignupEvent].
extension SignupEventPatterns on SignupEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignupUsernameChanged value)?  usernameChanged,TResult Function( SignupEmailChanged value)?  emailChanged,TResult Function( SignupPasswordChanged value)?  passwordChanged,TResult Function( SignupPasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult Function( SignupSubmitted value)?  submitted,TResult Function( SignupErrorDismissed value)?  errorDismissed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignupUsernameChanged() when usernameChanged != null:
return usernameChanged(_that);case SignupEmailChanged() when emailChanged != null:
return emailChanged(_that);case SignupPasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case SignupPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case SignupSubmitted() when submitted != null:
return submitted(_that);case SignupErrorDismissed() when errorDismissed != null:
return errorDismissed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignupUsernameChanged value)  usernameChanged,required TResult Function( SignupEmailChanged value)  emailChanged,required TResult Function( SignupPasswordChanged value)  passwordChanged,required TResult Function( SignupPasswordVisibilityToggled value)  passwordVisibilityToggled,required TResult Function( SignupSubmitted value)  submitted,required TResult Function( SignupErrorDismissed value)  errorDismissed,}){
final _that = this;
switch (_that) {
case SignupUsernameChanged():
return usernameChanged(_that);case SignupEmailChanged():
return emailChanged(_that);case SignupPasswordChanged():
return passwordChanged(_that);case SignupPasswordVisibilityToggled():
return passwordVisibilityToggled(_that);case SignupSubmitted():
return submitted(_that);case SignupErrorDismissed():
return errorDismissed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignupUsernameChanged value)?  usernameChanged,TResult? Function( SignupEmailChanged value)?  emailChanged,TResult? Function( SignupPasswordChanged value)?  passwordChanged,TResult? Function( SignupPasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult? Function( SignupSubmitted value)?  submitted,TResult? Function( SignupErrorDismissed value)?  errorDismissed,}){
final _that = this;
switch (_that) {
case SignupUsernameChanged() when usernameChanged != null:
return usernameChanged(_that);case SignupEmailChanged() when emailChanged != null:
return emailChanged(_that);case SignupPasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case SignupPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case SignupSubmitted() when submitted != null:
return submitted(_that);case SignupErrorDismissed() when errorDismissed != null:
return errorDismissed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String username)?  usernameChanged,TResult Function( String email)?  emailChanged,TResult Function( String password)?  passwordChanged,TResult Function()?  passwordVisibilityToggled,TResult Function()?  submitted,TResult Function()?  errorDismissed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignupUsernameChanged() when usernameChanged != null:
return usernameChanged(_that.username);case SignupEmailChanged() when emailChanged != null:
return emailChanged(_that.email);case SignupPasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case SignupPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case SignupSubmitted() when submitted != null:
return submitted();case SignupErrorDismissed() when errorDismissed != null:
return errorDismissed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String username)  usernameChanged,required TResult Function( String email)  emailChanged,required TResult Function( String password)  passwordChanged,required TResult Function()  passwordVisibilityToggled,required TResult Function()  submitted,required TResult Function()  errorDismissed,}) {final _that = this;
switch (_that) {
case SignupUsernameChanged():
return usernameChanged(_that.username);case SignupEmailChanged():
return emailChanged(_that.email);case SignupPasswordChanged():
return passwordChanged(_that.password);case SignupPasswordVisibilityToggled():
return passwordVisibilityToggled();case SignupSubmitted():
return submitted();case SignupErrorDismissed():
return errorDismissed();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String username)?  usernameChanged,TResult? Function( String email)?  emailChanged,TResult? Function( String password)?  passwordChanged,TResult? Function()?  passwordVisibilityToggled,TResult? Function()?  submitted,TResult? Function()?  errorDismissed,}) {final _that = this;
switch (_that) {
case SignupUsernameChanged() when usernameChanged != null:
return usernameChanged(_that.username);case SignupEmailChanged() when emailChanged != null:
return emailChanged(_that.email);case SignupPasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case SignupPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case SignupSubmitted() when submitted != null:
return submitted();case SignupErrorDismissed() when errorDismissed != null:
return errorDismissed();case _:
  return null;

}
}

}

/// @nodoc


class SignupUsernameChanged implements SignupEvent {
  const SignupUsernameChanged(this.username);
  

 final  String username;

/// Create a copy of SignupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupUsernameChangedCopyWith<SignupUsernameChanged> get copyWith => _$SignupUsernameChangedCopyWithImpl<SignupUsernameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupUsernameChanged&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString() {
  return 'SignupEvent.usernameChanged(username: $username)';
}


}

/// @nodoc
abstract mixin class $SignupUsernameChangedCopyWith<$Res> implements $SignupEventCopyWith<$Res> {
  factory $SignupUsernameChangedCopyWith(SignupUsernameChanged value, $Res Function(SignupUsernameChanged) _then) = _$SignupUsernameChangedCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class _$SignupUsernameChangedCopyWithImpl<$Res>
    implements $SignupUsernameChangedCopyWith<$Res> {
  _$SignupUsernameChangedCopyWithImpl(this._self, this._then);

  final SignupUsernameChanged _self;
  final $Res Function(SignupUsernameChanged) _then;

/// Create a copy of SignupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(SignupUsernameChanged(
null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignupEmailChanged implements SignupEvent {
  const SignupEmailChanged(this.email);
  

 final  String email;

/// Create a copy of SignupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupEmailChangedCopyWith<SignupEmailChanged> get copyWith => _$SignupEmailChangedCopyWithImpl<SignupEmailChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupEmailChanged&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'SignupEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class $SignupEmailChangedCopyWith<$Res> implements $SignupEventCopyWith<$Res> {
  factory $SignupEmailChangedCopyWith(SignupEmailChanged value, $Res Function(SignupEmailChanged) _then) = _$SignupEmailChangedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$SignupEmailChangedCopyWithImpl<$Res>
    implements $SignupEmailChangedCopyWith<$Res> {
  _$SignupEmailChangedCopyWithImpl(this._self, this._then);

  final SignupEmailChanged _self;
  final $Res Function(SignupEmailChanged) _then;

/// Create a copy of SignupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(SignupEmailChanged(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignupPasswordChanged implements SignupEvent {
  const SignupPasswordChanged(this.password);
  

 final  String password;

/// Create a copy of SignupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupPasswordChangedCopyWith<SignupPasswordChanged> get copyWith => _$SignupPasswordChangedCopyWithImpl<SignupPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupPasswordChanged&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'SignupEvent.passwordChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class $SignupPasswordChangedCopyWith<$Res> implements $SignupEventCopyWith<$Res> {
  factory $SignupPasswordChangedCopyWith(SignupPasswordChanged value, $Res Function(SignupPasswordChanged) _then) = _$SignupPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class _$SignupPasswordChangedCopyWithImpl<$Res>
    implements $SignupPasswordChangedCopyWith<$Res> {
  _$SignupPasswordChangedCopyWithImpl(this._self, this._then);

  final SignupPasswordChanged _self;
  final $Res Function(SignupPasswordChanged) _then;

/// Create a copy of SignupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(SignupPasswordChanged(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SignupPasswordVisibilityToggled implements SignupEvent {
  const SignupPasswordVisibilityToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupPasswordVisibilityToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignupEvent.passwordVisibilityToggled()';
}


}




/// @nodoc


class SignupSubmitted implements SignupEvent {
  const SignupSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignupEvent.submitted()';
}


}




/// @nodoc


class SignupErrorDismissed implements SignupEvent {
  const SignupErrorDismissed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupErrorDismissed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SignupEvent.errorDismissed()';
}


}




/// @nodoc
mixin _$SignupState {

 String get username; String get email; String get password; bool get obscurePassword; bool get showFieldErrors; EmailError? get emailError; PasswordError? get passwordError; SignupStatus get status; String? get failureMessage;
/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupStateCopyWith<SignupState> get copyWith => _$SignupStateCopyWithImpl<SignupState>(this as SignupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupState&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.showFieldErrors, showFieldErrors) || other.showFieldErrors == showFieldErrors)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,username,email,password,obscurePassword,showFieldErrors,emailError,passwordError,status,failureMessage);

@override
String toString() {
  return 'SignupState(username: $username, email: $email, password: $password, obscurePassword: $obscurePassword, showFieldErrors: $showFieldErrors, emailError: $emailError, passwordError: $passwordError, status: $status, failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class $SignupStateCopyWith<$Res>  {
  factory $SignupStateCopyWith(SignupState value, $Res Function(SignupState) _then) = _$SignupStateCopyWithImpl;
@useResult
$Res call({
 String username, String email, String password, bool obscurePassword, bool showFieldErrors, EmailError? emailError, PasswordError? passwordError, SignupStatus status, String? failureMessage
});




}
/// @nodoc
class _$SignupStateCopyWithImpl<$Res>
    implements $SignupStateCopyWith<$Res> {
  _$SignupStateCopyWithImpl(this._self, this._then);

  final SignupState _self;
  final $Res Function(SignupState) _then;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? email = null,Object? password = null,Object? obscurePassword = null,Object? showFieldErrors = null,Object? emailError = freezed,Object? passwordError = freezed,Object? status = null,Object? failureMessage = freezed,}) {
  return _then(_self.copyWith(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,showFieldErrors: null == showFieldErrors ? _self.showFieldErrors : showFieldErrors // ignore: cast_nullable_to_non_nullable
as bool,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as EmailError?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as PasswordError?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SignupStatus,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupState].
extension SignupStatePatterns on SignupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupState value)  $default,){
final _that = this;
switch (_that) {
case _SignupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupState value)?  $default,){
final _that = this;
switch (_that) {
case _SignupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username,  String email,  String password,  bool obscurePassword,  bool showFieldErrors,  EmailError? emailError,  PasswordError? passwordError,  SignupStatus status,  String? failureMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupState() when $default != null:
return $default(_that.username,_that.email,_that.password,_that.obscurePassword,_that.showFieldErrors,_that.emailError,_that.passwordError,_that.status,_that.failureMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username,  String email,  String password,  bool obscurePassword,  bool showFieldErrors,  EmailError? emailError,  PasswordError? passwordError,  SignupStatus status,  String? failureMessage)  $default,) {final _that = this;
switch (_that) {
case _SignupState():
return $default(_that.username,_that.email,_that.password,_that.obscurePassword,_that.showFieldErrors,_that.emailError,_that.passwordError,_that.status,_that.failureMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username,  String email,  String password,  bool obscurePassword,  bool showFieldErrors,  EmailError? emailError,  PasswordError? passwordError,  SignupStatus status,  String? failureMessage)?  $default,) {final _that = this;
switch (_that) {
case _SignupState() when $default != null:
return $default(_that.username,_that.email,_that.password,_that.obscurePassword,_that.showFieldErrors,_that.emailError,_that.passwordError,_that.status,_that.failureMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SignupState extends SignupState {
  const _SignupState({this.username = '', this.email = '', this.password = '', this.obscurePassword = true, this.showFieldErrors = false, this.emailError, this.passwordError, this.status = SignupStatus.idle, this.failureMessage}): super._();
  

@override@JsonKey() final  String username;
@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  bool obscurePassword;
@override@JsonKey() final  bool showFieldErrors;
@override final  EmailError? emailError;
@override final  PasswordError? passwordError;
@override@JsonKey() final  SignupStatus status;
@override final  String? failureMessage;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupStateCopyWith<_SignupState> get copyWith => __$SignupStateCopyWithImpl<_SignupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupState&&(identical(other.username, username) || other.username == username)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.showFieldErrors, showFieldErrors) || other.showFieldErrors == showFieldErrors)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,username,email,password,obscurePassword,showFieldErrors,emailError,passwordError,status,failureMessage);

@override
String toString() {
  return 'SignupState(username: $username, email: $email, password: $password, obscurePassword: $obscurePassword, showFieldErrors: $showFieldErrors, emailError: $emailError, passwordError: $passwordError, status: $status, failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class _$SignupStateCopyWith<$Res> implements $SignupStateCopyWith<$Res> {
  factory _$SignupStateCopyWith(_SignupState value, $Res Function(_SignupState) _then) = __$SignupStateCopyWithImpl;
@override @useResult
$Res call({
 String username, String email, String password, bool obscurePassword, bool showFieldErrors, EmailError? emailError, PasswordError? passwordError, SignupStatus status, String? failureMessage
});




}
/// @nodoc
class __$SignupStateCopyWithImpl<$Res>
    implements _$SignupStateCopyWith<$Res> {
  __$SignupStateCopyWithImpl(this._self, this._then);

  final _SignupState _self;
  final $Res Function(_SignupState) _then;

/// Create a copy of SignupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? email = null,Object? password = null,Object? obscurePassword = null,Object? showFieldErrors = null,Object? emailError = freezed,Object? passwordError = freezed,Object? status = null,Object? failureMessage = freezed,}) {
  return _then(_SignupState(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,showFieldErrors: null == showFieldErrors ? _self.showFieldErrors : showFieldErrors // ignore: cast_nullable_to_non_nullable
as bool,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as EmailError?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as PasswordError?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SignupStatus,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
