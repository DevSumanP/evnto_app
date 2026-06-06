import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tap_app/core/base/base_repository.dart';
import 'package:tap_app/core/utils/usecase.dart';
import 'package:tap_app/feature/auth/domain/entities/auth_session.dart';
import 'package:tap_app/feature/auth/domain/repositories/auth_repository.dart';

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.username,
    required this.email,
    required this.password,
  });

  final String username;
  final String email;
  final String password;

  @override
  List<Object?> get props => <Object?>[username, email, password];
}

@lazySingleton
class SignUpUseCase implements UseCase<AuthSession, SignUpParams> {
  SignUpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  EitherFailure<AuthSession> call(SignUpParams params) =>
      _repository.signupWithEmail(
        username: params.username,
        email: params.email,
        password: params.password,
      );
}
