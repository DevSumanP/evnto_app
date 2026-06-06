// ==============================================================================
// lib/feature/auth/domain/usecases/login_use_case.dart
// Single-responsibility use case that delegates to AuthRepository. Keeps the
// BLoC free of repository details and gives us one place to add cross-cutting
// concerns later (analytics, rate-limit, etc.).
// ==============================================================================

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/usecase.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => <Object?>[email, password];
}

@lazySingleton
class LoginUseCase implements UseCase<AuthSession, LoginParams> {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, AuthSession>> call(final LoginParams params) =>
      _repository.loginWithEmail(
        email: params.email,
        password: params.password,
      );
}
