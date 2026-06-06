// ─── Events ──────────────────────────────────────────────────────────────────

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:tap_app/core/base/base_bloc.dart';
import 'package:tap_app/core/base/base_event.dart';
import 'package:tap_app/core/base/base_state.dart';
import 'package:tap_app/feature/auth/domain/usecases/signup_use_case.dart';
import 'package:tap_app/feature/auth/domain/validators/email_validator.dart';
import 'package:tap_app/feature/auth/domain/validators/password_validator.dart';

part 'signup_bloc.freezed.dart';

@freezed
class SignupEvent with _$SignupEvent implements BaseBlocEvent {
  const factory SignupEvent.usernameChanged(String username) =
      SignupUsernameChanged;
  const factory SignupEvent.emailChanged(String email) = SignupEmailChanged;
  const factory SignupEvent.passwordChanged(String password) =
      SignupPasswordChanged;
  const factory SignupEvent.passwordVisibilityToggled() =
      SignupPasswordVisibilityToggled;
  const factory SignupEvent.submitted() = SignupSubmitted;
  const factory SignupEvent.errorDismissed() = SignupErrorDismissed;
}

// ─── Status ──────────────────────────────────────────────────────────────────

enum SignupStatus { idle, submitting, success, failure }

// ─── State ───────────────────────────────────────────────────────────────────

@freezed
abstract class SignupState with _$SignupState implements BaseBlocState {
  const factory SignupState({
    @Default('') String username,
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool obscurePassword,
    @Default(false) bool showFieldErrors,
    EmailError? emailError,
    PasswordError? passwordError,
    @Default(SignupStatus.idle) SignupStatus status,
    String? failureMessage,
  }) = _SignupState;

  const SignupState._();

  bool get isSubmitting => status == SignupStatus.submitting;
  bool get isSuccess => status == SignupStatus.success;
}

// ─── Bloc ────────────────────────────────────────────────────────────────────

@injectable
class SignupBloc extends BaseBloc<SignupEvent, SignupState> {
  SignupBloc(this._signupUseCase) : super(const SignupState()) {
    on<SignupUsernameChanged>(_onUsernameChanged);
    on<SignupEmailChanged>(_onEmailChanged);
    on<SignupPasswordChanged>(_onPasswordChanged);
    on<SignupPasswordVisibilityToggled>(_onVisibilityToggled);
    on<SignupSubmitted>(_onSubmitted);
    on<SignupErrorDismissed>(_onErrorDismissed);
  }

  final SignUpUseCase _signupUseCase;

  void _onUsernameChanged(
    final SignupUsernameChanged event,
    final Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        username: event.username,
        failureMessage: null,
        status: state.status == SignupStatus.failure
            ? SignupStatus.idle
            : state.status,
      ),
    );
  }

  void _onEmailChanged(
    final SignupEmailChanged event,
    final Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        email: event.email,
        emailError: state.showFieldErrors
            ? EmailValidator.validate(event.email)
            : null,
        failureMessage: null,
        status: state.status == SignupStatus.failure
            ? SignupStatus.idle
            : state.status,
      ),
    );
  }

  void _onPasswordChanged(
    final SignupPasswordChanged event,
    final Emitter<SignupState> emit,
  ) {
    emit(
      state.copyWith(
        password: event.password,
        passwordError: state.showFieldErrors
            ? PasswordValidator.validate(event.password)
            : null,
        failureMessage: null,
        status: state.status == SignupStatus.failure
            ? SignupStatus.idle
            : state.status,
      ),
    );
  }

  void _onVisibilityToggled(
    final SignupPasswordVisibilityToggled event,
    final Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void _onErrorDismissed(
    final SignupErrorDismissed event,
    final Emitter<SignupState> emit,
  ) {
    emit(state.copyWith(failureMessage: null, status: SignupStatus.idle));
  }

  Future<void> _onSubmitted(
    final SignupSubmitted event,
    final Emitter<SignupState> emit,
  ) async {
    if (state.isSubmitting) return;

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
          status: SignupStatus.idle,
          failureMessage: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: SignupStatus.submitting,
        failureMessage: null,
        showFieldErrors: true,
        emailError: null,
        passwordError: null,
      ),
    );

    final result = await _signupUseCase(
      SignUpParams(
        username: state.username.trim(),
        email: state.email.trim(),
        password: state.password,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SignupStatus.failure,
          failureMessage: getErrorMessage(failure),
        ),
      ),
      (_) => emit(state.copyWith(status: SignupStatus.success)),
    );
  }
}
