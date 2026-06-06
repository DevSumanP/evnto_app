// ==============================================================================
// lib/core/errors/failures.dart
// Failure types used in the domain and application layers.
//
// A Failure is what comes back to a BLoC or UI when something goes wrong.
// Failures are immutable and equatable, so they are safe to compare in
// tests and BLoC state transitions.
// ==============================================================================

import 'package:equatable/equatable.dart';

/// Base type for all failures.
///
/// `details` is typed as `Object?` (not `dynamic`) so the type checker
/// catches misuse early.
abstract class Failure extends Equatable {
  const Failure({required this.message, this.code, this.details});

  final String message;
  final String? code;
  final Object? details;

  @override
  List<Object?> get props => <Object?>[message, code, details];

  @override
  String toString() => '$runtimeType(message: $message, code: $code)';
}

// ==============================================================================
// Initialization failures
// ==============================================================================

/// Returned when app bootstrap cannot finish.
class InitializationFailure extends Failure {
  const InitializationFailure({
    required super.message,
    super.code,
    super.details,
    this.originalError,
  });

  final Failure? originalError;

  @override
  List<Object?> get props => <Object?>[...super.props, originalError];
}

// ==============================================================================
// Network failures
// ==============================================================================

/// Base type for network-related failures.
abstract class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code, super.details});
}

/// No internet connection.
class NoInternetFailure extends NetworkFailure {
  const NoInternetFailure({
    super.message = 'No internet connection',
    super.code = 'NO_INTERNET',
    super.details,
  });
}

/// Request timed out.
class TimeoutFailure extends NetworkFailure {
  const TimeoutFailure({
    super.message = 'Request timed out',
    super.code = 'TIMEOUT',
    super.details,
  });
}

/// Server returned an error.
class ServerFailure extends NetworkFailure {
  const ServerFailure({
    super.message = 'Server error occurred',
    super.code = 'SERVER_ERROR',
    super.details,
    this.statusCode,
  });

  final int? statusCode;

  @override
  List<Object?> get props => <Object?>[...super.props, statusCode];
}

/// Bad request (400).
class BadRequestFailure extends ServerFailure {
  const BadRequestFailure({
    super.message = 'Invalid request',
    super.code = 'BAD_REQUEST',
    super.details,
  }) : super(statusCode: 400);
}

/// Unauthorized (401).
class UnauthorizedFailure extends ServerFailure {
  const UnauthorizedFailure({
    super.message = 'Authentication required',
    super.code = 'UNAUTHORIZED',
    super.details,
  }) : super(statusCode: 401);
}

/// Forbidden (403).
class ForbiddenFailure extends ServerFailure {
  const ForbiddenFailure({
    super.message = 'Access forbidden',
    super.code = 'FORBIDDEN',
    super.details,
  }) : super(statusCode: 403);
}

/// Not found (404).
class NotFoundFailure extends ServerFailure {
  const NotFoundFailure({
    super.message = 'Resource not found',
    super.code = 'NOT_FOUND',
    super.details,
  }) : super(statusCode: 404);
}

// ==============================================================================
// Authentication failures
// ==============================================================================

/// Base type for authentication failures.
abstract class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code, super.details});
}

/// Login credentials are invalid.
class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure({
    super.message = 'Invalid credentials',
    super.code = 'INVALID_CREDENTIALS',
    super.details,
  });
}

/// Token is invalid or expired.
class InvalidTokenFailure extends AuthFailure {
  const InvalidTokenFailure({
    super.message = 'Session expired',
    super.code = 'INVALID_TOKEN',
    super.details,
  });
}

/// Email already exists.
class EmailAlreadyExistsFailure extends AuthFailure {
  const EmailAlreadyExistsFailure({
    super.message = 'Email already registered',
    super.code = 'EMAIL_EXISTS',
    super.details,
  });
}

// ==============================================================================
// Validation failures
// ==============================================================================

/// Validation failure with optional per-field errors.
class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Validation failed',
    super.code = 'VALIDATION_ERROR',
    super.details,
    this.fieldErrors,
  });

  final Map<String, List<String>>? fieldErrors;

  /// True if [field] has at least one error.
  bool hasFieldError(final String field) =>
      (fieldErrors?[field]?.isNotEmpty) ?? false;

  /// Errors for [field], or an empty list if none.
  List<String> errorsFor(final String field) =>
      List<String>.unmodifiable(fieldErrors?[field] ?? const <String>[]);

  @override
  List<Object?> get props => <Object?>[...super.props, fieldErrors];
}

// ==============================================================================
// Storage failures
// ==============================================================================

/// Base type for storage failures.
abstract class StorageFailure extends Failure {
  const StorageFailure({required super.message, super.code, super.details});
}

/// Cache operation failed.
class CacheFailure extends StorageFailure {
  const CacheFailure({
    super.message = 'Cache operation failed',
    super.code = 'CACHE_ERROR',
    super.details,
  });
}

/// Database operation failed.
class DatabaseFailure extends StorageFailure {
  const DatabaseFailure({
    super.message = 'Database operation failed',
    super.code = 'DATABASE_ERROR',
    super.details,
  });
}

// ==============================================================================
// Parsing failures
// ==============================================================================

/// Returned when parsing fails.
class ParsingFailure extends Failure {
  const ParsingFailure({
    super.message = 'Failed to parse data',
    super.code = 'PARSING_ERROR',
    super.details,
  });
}

// ==============================================================================
// Business logic failures
// ==============================================================================

/// Returned when a business rule is violated.
class BusinessRuleFailure extends Failure {
  const BusinessRuleFailure({
    required super.message,
    super.code = 'BUSINESS_RULE_VIOLATION',
    super.details,
  });
}

// ==============================================================================
// Generic failures
// ==============================================================================

/// Generic failure for unexpected errors.
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    super.message = 'An unexpected error occurred',
    super.code = 'UNEXPECTED_ERROR',
    super.details,
  });
}

/// Returned when an in-flight operation was cancelled (for example, by a
/// `CancelToken` or by leaving the screen). Not really an error.
class CancelledFailure extends Failure {
  const CancelledFailure({
    super.message = 'Operation cancelled',
    super.code = 'CANCELLED',
    super.details,
  });
}
