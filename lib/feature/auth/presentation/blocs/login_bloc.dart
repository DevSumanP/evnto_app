// ==============================================================================
// lib/feature/auth/presentation/blocs/login_bloc.dart
// State for the login screen.
//
// Validation strategy: silent until the first submit attempt, then live.
// This avoids yelling at the user before they have finished typing, while
// still giving immediate feedback once they have tried to submit.
// ==============================================================================

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/base/base_event.dart';
import '../../../../core/base/base_state.dart';
import '../../domain/usecases/login_use_case.dart';
import '../../domain/validators/email_validator.dart';
import '../../domain/validators/password_validator.dart';

part 'login_bloc.freezed.dart';

// ─── Events ──────────────────────────────────────────────────────────────────

@freezed
class LoginEvent with _$LoginEvent implements BaseBlocEvent {
  const factory LoginEvent.emailChanged(String email) = LoginEmailChanged;
  const factory LoginEvent.passwordChanged(String password) =
      LoginPasswordChanged;
  const factory LoginEvent.passwordVisibilityToggled() =
      LoginPasswordVisibilityToggled;
  const factory LoginEvent.submitted() = LoginSubmitted;
  const factory LoginEvent.errorDismissed() = LoginErrorDismissed;
}

// ─── Status ──────────────────────────────────────────────────────────────────

enum LoginStatus { idle, submitting, success, failure }

// ─── State ───────────────────────────────────────────────────────────────────

@freezed
abstract class LoginState with _$LoginState implements BaseBlocState {
  const factory LoginState({
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool obscurePassword,
    @Default(false) bool showFieldErrors,
    EmailError? emailError,
    PasswordError? passwordError,
    @Default(LoginStatus.idle) LoginStatus status,
    String? failureMessage,
  }) = _LoginState;

  const LoginState._();

  bool get isSubmitting => status == LoginStatus.submitting;
  bool get isSuccess => status == LoginStatus.success;
}

// ─── Bloc ────────────────────────────────────────────────────────────────────

@injectable
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(this._loginUseCase) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginPasswordVisibilityToggled>(_onVisibilityToggled);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginErrorDismissed>(_onErrorDismissed);
  }

  final LoginUseCase _loginUseCase;

  void _onEmailChanged(
    final LoginEmailChanged event,
    final Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        // Only re-run validation live once the user has hit submit, so we
        // do not flash an "invalid email" error on the first keystroke.
        emailError: state.showFieldErrors
            ? EmailValidator.validate(event.email)
            : null,
        // Any field edit clears the previous server-side failure banner.
        failureMessage: null,
        status: state.status == LoginStatus.failure
            ? LoginStatus.idle
            : state.status,
      ),
    );
  }

  void _onPasswordChanged(
    final LoginPasswordChanged event,
    final Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        passwordError: state.showFieldErrors
            ? PasswordValidator.validate(event.password)
            : null,
        failureMessage: null,
        status: state.status == LoginStatus.failure
            ? LoginStatus.idle
            : state.status,
      ),
    );
  }

  void _onVisibilityToggled(
    final LoginPasswordVisibilityToggled event,
    final Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onErrorDismissed(
    final LoginErrorDismissed event,
    final Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(failureMessage: null, status: LoginStatus.idle));
  }

  Future<void> _onSubmitted(
    final LoginSubmitted event,
    final Emitter<LoginState> emit,
  ) async {
    if (state.isSubmitting) return;

    // Always validate on submit. Toggle showFieldErrors so subsequent edits
    // get live feedback too.
    final EmailError? emailError = EmailValidator.validate(state.email);
    final PasswordError? passwordError = PasswordValidator.validate(
      state.password,
    );

    if (emailError != null || passwordError != null) {
      emit(
        state.copyWith(
          showFieldErrors: true,
          emailError: emailError,
          passwordError: passwordError,
          status: LoginStatus.idle,
          failureMessage: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: LoginStatus.submitting,
        failureMessage: null,
        showFieldErrors: true,
        emailError: null,
        passwordError: null,
      ),
    );

    final result = await _loginUseCase(
      LoginParams(email: state.email.trim(), password: state.password),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: LoginStatus.failure,
          failureMessage: getErrorMessage(failure),
        ),
      ),
      (_) => emit(state.copyWith(status: LoginStatus.success)),
    );
  }
}
