// ==============================================================================
// lib/core/errors/exceptions.dart
// Custom exception types.
//
// Exceptions are thrown by data sources. They get caught at the repository
// layer and turned into Failure values.
// ==============================================================================

/// Base type for all custom exceptions.
///
/// Do not use this type directly. Always throw a specific subtype so that
/// [ErrorHandler] can map it to the right [Failure].
abstract class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.details,
    this.stackTrace,
  });

  final String message;
  final String? code;
  final Object? details;
  final StackTrace? stackTrace;

  @override
  String toString() =>
      '$runtimeType(message: $message, code: $code, details: $details)';
}

// ==============================================================================
// Network and API exceptions
// ==============================================================================

/// Base type for all network-related exceptions.
abstract class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.details,
    super.stackTrace,
  });
}

/// Thrown when the device has no internet connection.
class NoInternetException extends NetworkException {
  const NoInternetException({
    super.message = 'No internet connection. Please check your network.',
    super.code = 'NO_INTERNET',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when a request times out.
///
/// Name has the `App` prefix to avoid a clash with `dart:async.TimeoutException`,
/// which would silently shadow this class when both are imported.
class AppTimeoutException extends NetworkException {
  const AppTimeoutException({
    super.message = 'Request timed out. Please try again.',
    super.code = 'TIMEOUT',
    super.details,
    super.stackTrace,
    this.timeoutDuration = const Duration(seconds: 30),
  });

  final Duration timeoutDuration;

  @override
  String toString() =>
      'AppTimeoutException(message: $message, duration: ${timeoutDuration.inSeconds}s)';
}

/// Thrown when the server returns an error response.
class ServerException extends NetworkException {
  const ServerException({
    super.message = 'Server error occurred. Please try again later.',
    super.code = 'SERVER_ERROR',
    super.details,
    super.stackTrace,
    this.statusCode,
    this.response,
  });

  final int? statusCode;
  final Map<String, dynamic>? response;

  /// True if the failure matches a specific HTTP status code.
  bool isStatusCode(final int code) => statusCode == code;

  /// True if this is a 5xx server-side error.
  bool get isServerError =>
      statusCode != null && statusCode! >= 500 && statusCode! < 600;

  /// True if this is a 4xx client-side error.
  bool get isClientError =>
      statusCode != null && statusCode! >= 400 && statusCode! < 500;

  @override
  String toString() =>
      '$runtimeType(statusCode: $statusCode, message: $message)';
}

/// Thrown when a request fails with bad request (400).
class BadRequestException extends ServerException {
  const BadRequestException({
    super.message = 'Invalid request. Please check your input.',
    super.code = 'BAD_REQUEST',
    super.details,
    super.stackTrace,
    super.response,
  }) : super(statusCode: 400);
}

/// Thrown when authentication fails (401).
class UnauthorizedException extends ServerException {
  const UnauthorizedException({
    super.message = 'Authentication failed. Please login again.',
    super.code = 'UNAUTHORIZED',
    super.details,
    super.stackTrace,
    super.response,
  }) : super(statusCode: 401);
}

/// Thrown when the user does not have permission (403).
class ForbiddenException extends ServerException {
  const ForbiddenException({
    super.message = 'You do not have permission to perform this action.',
    super.code = 'FORBIDDEN',
    super.details,
    super.stackTrace,
    super.response,
  }) : super(statusCode: 403);
}

/// Thrown when the resource is not found (404).
class NotFoundException extends ServerException {
  const NotFoundException({
    super.message = 'The requested resource was not found.',
    super.code = 'NOT_FOUND',
    super.details,
    super.stackTrace,
    super.response,
  }) : super(statusCode: 404);
}

/// Thrown when the request conflicts with the server state (409).
class ConflictException extends ServerException {
  const ConflictException({
    super.message = 'Request conflicts with current state.',
    super.code = 'CONFLICT',
    super.details,
    super.stackTrace,
    super.response,
  }) : super(statusCode: 409);
}

/// Thrown when the request payload is too large (413).
class PayloadTooLargeException extends ServerException {
  const PayloadTooLargeException({
    super.message = 'Request payload is too large.',
    super.code = 'PAYLOAD_TOO_LARGE',
    super.details,
    super.stackTrace,
    super.response,
  }) : super(statusCode: 413);
}

/// Thrown when too many requests have been made (429).
class TooManyRequestsException extends ServerException {
  const TooManyRequestsException({
    super.message = 'Too many requests. Please try again later.',
    super.code = 'TOO_MANY_REQUESTS',
    super.details,
    super.stackTrace,
    super.response,
    this.retryAfter,
  }) : super(statusCode: 429);

  final int? retryAfter;
}

/// Thrown when an internal server error occurs (500).
class InternalServerException extends ServerException {
  const InternalServerException({
    super.message = 'Internal server error. Please try again later.',
    super.code = 'INTERNAL_SERVER_ERROR',
    super.details,
    super.stackTrace,
    super.response,
  }) : super(statusCode: 500);
}

/// Thrown when the service is unavailable (503).
class ServiceUnavailableException extends ServerException {
  const ServiceUnavailableException({
    super.message =
        'Service is temporarily unavailable. Please try again later.',
    super.code = 'SERVICE_UNAVAILABLE',
    super.details,
    super.stackTrace,
    super.response,
  }) : super(statusCode: 503);
}

// ==============================================================================
// Authentication and authorization exceptions
// ==============================================================================

/// Base type for auth-related exceptions.
abstract class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.details,
    super.stackTrace,
  });
}

/// Thrown when the token is invalid or expired.
class InvalidTokenException extends AuthException {
  const InvalidTokenException({
    super.message = 'Session expired. Please login again.',
    super.code = 'INVALID_TOKEN',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when refresh token request fails.
class RefreshTokenException extends AuthException {
  const RefreshTokenException({
    super.message = 'Unable to refresh session. Please login again.',
    super.code = 'REFRESH_TOKEN_FAILED',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when login credentials are invalid.
class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException({
    super.message = 'Invalid email or password.',
    super.code = 'INVALID_CREDENTIALS',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when the email is already registered.
class EmailAlreadyExistsException extends AuthException {
  const EmailAlreadyExistsException({
    super.message = 'This email is already registered.',
    super.code = 'EMAIL_EXISTS',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when the username is already taken.
class UsernameAlreadyExistsException extends AuthException {
  const UsernameAlreadyExistsException({
    super.message = 'This username is already taken.',
    super.code = 'USERNAME_EXISTS',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when email verification is required.
class EmailNotVerifiedException extends AuthException {
  const EmailNotVerifiedException({
    super.message = 'Please verify your email address.',
    super.code = 'EMAIL_NOT_VERIFIED',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when the account is locked.
class AccountLockedException extends AuthException {
  const AccountLockedException({
    super.message = 'Account is temporarily locked. Please try again later.',
    super.code = 'ACCOUNT_LOCKED',
    super.details,
    super.stackTrace,
    this.unlockTime,
  });

  final DateTime? unlockTime;
}

// ==============================================================================
// Validation exceptions
// ==============================================================================

/// Base type for validation-related exceptions.
abstract class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.code = 'VALIDATION_ERROR',
    super.details,
    super.stackTrace,
    this.fieldErrors,
  });

  final Map<String, List<String>>? fieldErrors;

  /// True if [field] has at least one error.
  bool hasFieldError(final String field) =>
      fieldErrors?.containsKey(field) ?? false;

  /// Errors for [field], or null.
  List<String>? getFieldErrors(final String field) => fieldErrors?[field];
}

/// Thrown when input validation fails.
class InputValidationException extends ValidationException {
  const InputValidationException({
    super.message = 'Please check your input and try again.',
    super.code = 'INPUT_VALIDATION_ERROR',
    super.details,
    super.stackTrace,
    super.fieldErrors,
  });
}

/// Thrown when a required field is missing.
class RequiredFieldException extends ValidationException {
  const RequiredFieldException({
    required this.fieldName,
    super.message = 'This field is required.',
    super.code = 'REQUIRED_FIELD',
    super.details,
    super.stackTrace,
    super.fieldErrors,
  });

  final String fieldName;
}

/// Thrown when a field format is invalid.
class InvalidFormatException extends ValidationException {
  const InvalidFormatException({
    required this.fieldName,
    required this.expectedFormat,
    super.message = 'Invalid format.',
    super.code = 'INVALID_FORMAT',
    super.details,
    super.stackTrace,
    super.fieldErrors,
  });

  final String fieldName;
  final String expectedFormat;
}

// ==============================================================================
// Storage and cache exceptions
// ==============================================================================

/// Base type for storage-related exceptions.
abstract class StorageException extends AppException {
  const StorageException({
    required super.message,
    super.code,
    super.details,
    super.stackTrace,
  });
}

/// Thrown when storage initialization fails.
class StorageInitializationException extends StorageException {
  const StorageInitializationException({
    super.message = 'Failed to initialize storage.',
    super.code = 'STORAGE_INITIALIZATION_ERROR',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when a storage write fails.
class StorageWriteException extends StorageException {
  const StorageWriteException({
    super.message = 'Failed to write to storage.',
    super.code = 'STORAGE_WRITE_ERROR',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when a storage read fails.
class StorageReadException extends StorageException {
  const StorageReadException({
    super.message = 'Failed to read from storage.',
    super.code = 'STORAGE_READ_ERROR',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when a storage delete fails.
class StorageDeleteException extends StorageException {
  const StorageDeleteException({
    super.message = 'Failed to delete from storage.',
    super.code = 'STORAGE_DELETE_ERROR',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when a cache read or write fails.
class CacheException extends StorageException {
  const CacheException({
    super.message = 'Cache operation failed.',
    super.code = 'CACHE_ERROR',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when a local database operation fails.
class DatabaseException extends StorageException {
  const DatabaseException({
    super.message = 'Database operation failed.',
    super.code = 'DATABASE_ERROR',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when a file operation fails.
class FileException extends StorageException {
  const FileException({
    super.message = 'File operation failed.',
    super.code = 'FILE_ERROR',
    super.details,
    super.stackTrace,
    this.filePath,
  });

  final String? filePath;
}

/// Thrown when the storage quota is exceeded.
class StorageQuotaExceededException extends StorageException {
  const StorageQuotaExceededException({
    super.message = 'Storage quota exceeded.',
    super.code = 'STORAGE_QUOTA_EXCEEDED',
    super.details,
    super.stackTrace,
    this.maxSize,
    this.currentSize,
  });

  final int? maxSize;
  final int? currentSize;
}

// ==============================================================================
// Parsing and serialization exceptions
// ==============================================================================

/// Thrown when JSON parsing fails.
class JsonParsingException extends AppException {
  const JsonParsingException({
    super.message = 'Failed to parse response data.',
    super.code = 'JSON_PARSING_ERROR',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when data serialization fails.
class SerializationException extends AppException {
  const SerializationException({
    super.message = 'Failed to serialize data.',
    super.code = 'SERIALIZATION_ERROR',
    super.details,
    super.stackTrace,
  });
}

// ==============================================================================
// Business logic exceptions
// ==============================================================================

/// Thrown when a business rule is violated.
class BusinessRuleException extends AppException {
  const BusinessRuleException({
    required super.message,
    super.code = 'BUSINESS_RULE_VIOLATION',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when the operation is not allowed in the current state.
class InvalidOperationException extends AppException {
  const InvalidOperationException({
    super.message = 'This operation is not permitted.',
    super.code = 'INVALID_OPERATION',
    super.details,
    super.stackTrace,
  });
}

/// Thrown when the resource already exists.
class DuplicateResourceException extends AppException {
  const DuplicateResourceException({
    super.message = 'Resource already exists.',
    super.code = 'DUPLICATE_RESOURCE',
    super.details,
    super.stackTrace,
  });
}

// ==============================================================================
// Platform exceptions
// ==============================================================================

/// Thrown when a platform-specific operation fails.
///
/// Name has the `App` prefix to avoid a clash with Flutter's
/// `PlatformException` from `package:flutter/services.dart`, which is
/// re-exported by `flutter/material.dart`.
class AppPlatformException extends AppException {
  const AppPlatformException({
    super.message = 'Platform operation failed.',
    super.code = 'PLATFORM_ERROR',
    super.details,
    super.stackTrace,
    this.platform,
  });

  final String? platform;
}

/// Thrown when permission is denied.
class PermissionDeniedException extends AppPlatformException {
  const PermissionDeniedException({
    required this.permissionType,
    super.message = 'Permission denied.',
    super.code = 'PERMISSION_DENIED',
    super.details,
    super.stackTrace,
    super.platform,
  });

  final String permissionType;
}

/// Thrown when a feature is not available on the current platform.
class FeatureNotAvailableException extends AppPlatformException {
  const FeatureNotAvailableException({
    required this.feature,
    super.message = 'Feature not available on this platform.',
    super.code = 'FEATURE_NOT_AVAILABLE',
    super.details,
    super.stackTrace,
    super.platform,
  });

  final String feature;
}
