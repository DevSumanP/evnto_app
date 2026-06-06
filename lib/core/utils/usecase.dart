// ==============================================================================
// lib/core/utils/usecase.dart
// Base type for use cases (interactor pattern from clean architecture).
// ==============================================================================

import '../base/base_repository.dart';

/// Base type for a use case.
///
///   - [T] is the success return type.
///   - [P] is the input parameter type. Use [NoParams] when the use case
///     takes no input.
abstract class UseCase<T, P> {
  const UseCase();

  /// Run the use case. Returns Right(value) on success, Left(failure) on error.
  EitherFailure<T> call(final P params);
}

/// Empty parameter type for use cases that take no input.
class NoParams {
  const NoParams();
}
