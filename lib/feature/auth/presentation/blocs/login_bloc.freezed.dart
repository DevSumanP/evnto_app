// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent()';
}


}

/// @nodoc
class $LoginEventCopyWith<$Res>  {
$LoginEventCopyWith(LoginEvent _, $Res Function(LoginEvent) __);
}


/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoginEmailChanged value)?  emailChanged,TResult Function( LoginPasswordChanged value)?  passwordChanged,TResult Function( LoginPasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult Function( LoginSubmitted value)?  submitted,TResult Function( LoginErrorDismissed value)?  errorDismissed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoginEmailChanged() when emailChanged != null:
return emailChanged(_that);case LoginPasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case LoginPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case LoginSubmitted() when submitted != null:
return submitted(_that);case LoginErrorDismissed() when errorDismissed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoginEmailChanged value)  emailChanged,required TResult Function( LoginPasswordChanged value)  passwordChanged,required TResult Function( LoginPasswordVisibilityToggled value)  passwordVisibilityToggled,required TResult Function( LoginSubmitted value)  submitted,required TResult Function( LoginErrorDismissed value)  errorDismissed,}){
final _that = this;
switch (_that) {
case LoginEmailChanged():
return emailChanged(_that);case LoginPasswordChanged():
return passwordChanged(_that);case LoginPasswordVisibilityToggled():
return passwordVisibilityToggled(_that);case LoginSubmitted():
return submitted(_that);case LoginErrorDismissed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoginEmailChanged value)?  emailChanged,TResult? Function( LoginPasswordChanged value)?  passwordChanged,TResult? Function( LoginPasswordVisibilityToggled value)?  passwordVisibilityToggled,TResult? Function( LoginSubmitted value)?  submitted,TResult? Function( LoginErrorDismissed value)?  errorDismissed,}){
final _that = this;
switch (_that) {
case LoginEmailChanged() when emailChanged != null:
return emailChanged(_that);case LoginPasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case LoginPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled(_that);case LoginSubmitted() when submitted != null:
return submitted(_that);case LoginErrorDismissed() when errorDismissed != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email)?  emailChanged,TResult Function( String password)?  passwordChanged,TResult Function()?  passwordVisibilityToggled,TResult Function()?  submitted,TResult Function()?  errorDismissed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoginEmailChanged() when emailChanged != null:
return emailChanged(_that.email);case LoginPasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case LoginPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case LoginSubmitted() when submitted != null:
return submitted();case LoginErrorDismissed() when errorDismissed != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email)  emailChanged,required TResult Function( String password)  passwordChanged,required TResult Function()  passwordVisibilityToggled,required TResult Function()  submitted,required TResult Function()  errorDismissed,}) {final _that = this;
switch (_that) {
case LoginEmailChanged():
return emailChanged(_that.email);case LoginPasswordChanged():
return passwordChanged(_that.password);case LoginPasswordVisibilityToggled():
return passwordVisibilityToggled();case LoginSubmitted():
return submitted();case LoginErrorDismissed():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email)?  emailChanged,TResult? Function( String password)?  passwordChanged,TResult? Function()?  passwordVisibilityToggled,TResult? Function()?  submitted,TResult? Function()?  errorDismissed,}) {final _that = this;
switch (_that) {
case LoginEmailChanged() when emailChanged != null:
return emailChanged(_that.email);case LoginPasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case LoginPasswordVisibilityToggled() when passwordVisibilityToggled != null:
return passwordVisibilityToggled();case LoginSubmitted() when submitted != null:
return submitted();case LoginErrorDismissed() when errorDismissed != null:
return errorDismissed();case _:
  return null;

}
}

}

/// @nodoc


class LoginEmailChanged implements LoginEvent {
  const LoginEmailChanged(this.email);
  

 final  String email;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginEmailChangedCopyWith<LoginEmailChanged> get copyWith => _$LoginEmailChangedCopyWithImpl<LoginEmailChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEmailChanged&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'LoginEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class $LoginEmailChangedCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $LoginEmailChangedCopyWith(LoginEmailChanged value, $Res Function(LoginEmailChanged) _then) = _$LoginEmailChangedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$LoginEmailChangedCopyWithImpl<$Res>
    implements $LoginEmailChangedCopyWith<$Res> {
  _$LoginEmailChangedCopyWithImpl(this._self, this._then);

  final LoginEmailChanged _self;
  final $Res Function(LoginEmailChanged) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(LoginEmailChanged(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoginPasswordChanged implements LoginEvent {
  const LoginPasswordChanged(this.password);
  

 final  String password;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginPasswordChangedCopyWith<LoginPasswordChanged> get copyWith => _$LoginPasswordChangedCopyWithImpl<LoginPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginPasswordChanged&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'LoginEvent.passwordChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginPasswordChangedCopyWith<$Res> implements $LoginEventCopyWith<$Res> {
  factory $LoginPasswordChangedCopyWith(LoginPasswordChanged value, $Res Function(LoginPasswordChanged) _then) = _$LoginPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class _$LoginPasswordChangedCopyWithImpl<$Res>
    implements $LoginPasswordChangedCopyWith<$Res> {
  _$LoginPasswordChangedCopyWithImpl(this._self, this._then);

  final LoginPasswordChanged _self;
  final $Res Function(LoginPasswordChanged) _then;

/// Create a copy of LoginEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(LoginPasswordChanged(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoginPasswordVisibilityToggled implements LoginEvent {
  const LoginPasswordVisibilityToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginPasswordVisibilityToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.passwordVisibilityToggled()';
}


}




/// @nodoc


class LoginSubmitted implements LoginEvent {
  const LoginSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.submitted()';
}


}




/// @nodoc


class LoginErrorDismissed implements LoginEvent {
  const LoginErrorDismissed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginErrorDismissed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.errorDismissed()';
}


}




/// @nodoc
mixin _$LoginState {

 String get email; String get password; bool get obscurePassword; bool get showFieldErrors; EmailError? get emailError; PasswordError? get passwordError; LoginStatus get status; String? get failureMessage;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.showFieldErrors, showFieldErrors) || other.showFieldErrors == showFieldErrors)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,obscurePassword,showFieldErrors,emailError,passwordError,status,failureMessage);

@override
String toString() {
  return 'LoginState(email: $email, password: $password, obscurePassword: $obscurePassword, showFieldErrors: $showFieldErrors, emailError: $emailError, passwordError: $passwordError, status: $status, failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 String email, String password, bool obscurePassword, bool showFieldErrors, EmailError? emailError, PasswordError? passwordError, LoginStatus status, String? failureMessage
});




}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,Object? obscurePassword = null,Object? showFieldErrors = null,Object? emailError = freezed,Object? passwordError = freezed,Object? status = null,Object? failureMessage = freezed,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,showFieldErrors: null == showFieldErrors ? _self.showFieldErrors : showFieldErrors // ignore: cast_nullable_to_non_nullable
as bool,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as EmailError?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as PasswordError?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoginStatus,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginState value)  $default,){
final _that = this;
switch (_that) {
case _LoginState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password,  bool obscurePassword,  bool showFieldErrors,  EmailError? emailError,  PasswordError? passwordError,  LoginStatus status,  String? failureMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.email,_that.password,_that.obscurePassword,_that.showFieldErrors,_that.emailError,_that.passwordError,_that.status,_that.failureMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password,  bool obscurePassword,  bool showFieldErrors,  EmailError? emailError,  PasswordError? passwordError,  LoginStatus status,  String? failureMessage)  $default,) {final _that = this;
switch (_that) {
case _LoginState():
return $default(_that.email,_that.password,_that.obscurePassword,_that.showFieldErrors,_that.emailError,_that.passwordError,_that.status,_that.failureMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password,  bool obscurePassword,  bool showFieldErrors,  EmailError? emailError,  PasswordError? passwordError,  LoginStatus status,  String? failureMessage)?  $default,) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.email,_that.password,_that.obscurePassword,_that.showFieldErrors,_that.emailError,_that.passwordError,_that.status,_that.failureMessage);case _:
  return null;

}
}

}

/// @nodoc


class _LoginState extends LoginState {
  const _LoginState({this.email = '', this.password = '', this.obscurePassword = true, this.showFieldErrors = false, this.emailError, this.passwordError, this.status = LoginStatus.idle, this.failureMessage}): super._();
  

@override@JsonKey() final  String email;
@override@JsonKey() final  String password;
@override@JsonKey() final  bool obscurePassword;
@override@JsonKey() final  bool showFieldErrors;
@override final  EmailError? emailError;
@override final  PasswordError? passwordError;
@override@JsonKey() final  LoginStatus status;
@override final  String? failureMessage;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStateCopyWith<_LoginState> get copyWith => __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginState&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.showFieldErrors, showFieldErrors) || other.showFieldErrors == showFieldErrors)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.status, status) || other.status == status)&&(identical(other.failureMessage, failureMessage) || other.failureMessage == failureMessage));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,obscurePassword,showFieldErrors,emailError,passwordError,status,failureMessage);

@override
String toString() {
  return 'LoginState(email: $email, password: $password, obscurePassword: $obscurePassword, showFieldErrors: $showFieldErrors, emailError: $emailError, passwordError: $passwordError, status: $status, failureMessage: $failureMessage)';
}


}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(_LoginState value, $Res Function(_LoginState) _then) = __$LoginStateCopyWithImpl;
@override @useResult
$Res call({
 String email, String password, bool obscurePassword, bool showFieldErrors, EmailError? emailError, PasswordError? passwordError, LoginStatus status, String? failureMessage
});




}
/// @nodoc
class __$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? obscurePassword = null,Object? showFieldErrors = null,Object? emailError = freezed,Object? passwordError = freezed,Object? status = null,Object? failureMessage = freezed,}) {
  return _then(_LoginState(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,showFieldErrors: null == showFieldErrors ? _self.showFieldErrors : showFieldErrors // ignore: cast_nullable_to_non_nullable
as bool,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as EmailError?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as PasswordError?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LoginStatus,failureMessage: freezed == failureMessage ? _self.failureMessage : failureMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
