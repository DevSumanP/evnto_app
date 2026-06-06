// ==============================================================================
// lib/core/errors/error_handler.dart
// Global error handler. Turns exceptions into typed Failure values, logs them,
// and forwards them to the remote reporting service.
// ==============================================================================

import 'dart:async' as async;
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../shared/widgets/common/app_error_widget.dart';
import '../config/app_config.dart';
import '../services/error_reporting_service.dart';
import '../utils/logger.dart';
import 'exceptions.dart';
import 'failures.dart';

/// Global error handler singleton.
///
/// One place to map exceptions to Failure values, log them, and report them.
/// All async paths in the app should call [handleException] so the mapping
/// stays consistent.
class ErrorHandler {
  ErrorHandler._();

  static final ErrorHandler instance = ErrorHandler._();

  ErrorReportingService? _errorReportingService;
  final AppLogger _logger = AppLogger.instance;

  /// Initialize the global error handler.
  ///
  /// This method owns [FlutterError.onError] and
  /// [PlatformDispatcher.instance.onError]. The `runZonedGuarded` block in
  /// `bootstrap()` is still the last safety net for anything those two miss.
  void initialize({final ErrorReportingService? errorReportingService}) {
    _errorReportingService = errorReportingService;
    _setupGlobalErrorHandling();
  }

  /// Set up the global handlers for uncaught Flutter and platform errors.
  void _setupGlobalErrorHandling() {
    FlutterError.onError = (final FlutterErrorDetails details) {
      _logError(details.exception, details.stack);
      _reportError(details.exception, details.stack);

      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      }
    };

    ErrorWidget.builder = (final FlutterErrorDetails details) => AppErrorWidget(
      details: details,
      isDevelopment: AppConfig.instance.flavor.isDevelopment,
    );

    PlatformDispatcher.instance.onError =
        (final Object error, final StackTrace stack) {
          _logError(error, stack);
          _reportError(error, stack);
          return true;
        };
  }

  /// Turn any thrown object into a typed [Failure].
  ///
  /// All repositories, BLoCs, and the global zone guard call this method.
  /// Every branch logs once. Errors are reported to the remote service only
  /// when [shouldReport] returns true.
  Failure handleException(
    final Object exception, [
    final StackTrace? stackTrace,
  ]) {
    _logError(exception, stackTrace);

    if (exception is AppException) {
      final Failure failure = _handleAppException(exception);
      if (shouldReport(exception)) {
        _reportError(exception, stackTrace ?? exception.stackTrace);
      }
      return failure;
    }

    if (exception is DioException) {
      return _handleDioException(exception, stackTrace);
    }

    if (exception is SocketException) {
      return const NoInternetFailure();
    }

    if (exception is async.TimeoutException) {
      return TimeoutFailure(message: exception.message ?? 'Request timed out');
    }

    if (exception is FormatException) {
      return ParsingFailure(
        message: exception.message,
        details: exception.source,
      );
    }

    // Default: unexpected error. Always reported.
    _reportError(exception, stackTrace);
    return UnexpectedFailure(message: exception.toString());
  }

  /// Handle app-specific exceptions
  Failure _handleAppException(final AppException exception) {
    // Network exceptions
    if (exception is NoInternetException) {
      return NoInternetFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    if (exception is AppTimeoutException) {
      return TimeoutFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    // Subclass checks must come before the parent `ServerException` check —
    // otherwise the latter swallows everything (Bad/Unauthorized/Forbidden/
    // NotFound all extend ServerException) and the specific branches become
    // dead code.
    if (exception is BadRequestException) {
      return BadRequestFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    if (exception is UnauthorizedException) {
      return UnauthorizedFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    if (exception is ForbiddenException) {
      return ForbiddenFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    if (exception is NotFoundException) {
      return NotFoundFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    if (exception is ServerException) {
      return ServerFailure(
        message: exception.message,
        code: exception.code,
        statusCode: exception.statusCode,
        details: exception.details,
      );
    }

    // Auth exceptions
    if (exception is InvalidCredentialsException) {
      return InvalidCredentialsFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    if (exception is InvalidTokenException) {
      return InvalidTokenFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    if (exception is EmailAlreadyExistsException) {
      return EmailAlreadyExistsFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    // Validation exceptions
    if (exception is ValidationException) {
      return ValidationFailure(
        message: exception.message,
        code: exception.code,
        fieldErrors: exception.fieldErrors,
        details: exception.details,
      );
    }

    // Storage exceptions
    if (exception is CacheException) {
      return CacheFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    if (exception is DatabaseException) {
      return DatabaseFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    // Parsing exceptions
    if (exception is JsonParsingException ||
        exception is SerializationException) {
      return ParsingFailure(
        message: exception.message,
        details: exception.details,
      );
    }

    // Business logic exceptions
    if (exception is BusinessRuleException) {
      return BusinessRuleFailure(
        message: exception.message,
        code: exception.code,
        details: exception.details,
      );
    }

    // Default for unknown app exceptions
    return UnexpectedFailure(
      message: exception.message,
      code: exception.code,
      details: exception.details,
    );
  }

  /// Map a Dio HTTP error to a typed [Failure].
  Failure _handleDioException(
    final DioException exception, [
    final StackTrace? stackTrace,
  ]) {
    // Unwrap nested app exceptions (for example, NoInternetException raised
    // by the connectivity interceptor) so they are not double-wrapped.
    final Object? inner = exception.error;
    if (inner is AppException) {
      return _handleAppException(inner);
    }

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutFailure(message: 'Connection timeout');

      case DioExceptionType.badResponse:
        return _handleBadResponse(exception);

      case DioExceptionType.cancel:
        return const UnexpectedFailure(
          message: 'Request cancelled',
          code: 'REQUEST_CANCELLED',
        );

      case DioExceptionType.connectionError:
        if (inner is SocketException) {
          return const NoInternetFailure();
        }
        return const ServerFailure(
          message: 'Connection error',
          code: 'CONNECTION_ERROR',
        );

      case DioExceptionType.badCertificate:
        // A bad certificate is a hard security signal. Always report it and
        // surface it as a server failure so it is never silently retried.
        _reportError(exception, stackTrace);
        return const ServerFailure(
          message: 'Security error: invalid server certificate',
          code: 'BAD_CERTIFICATE',
        );

      case DioExceptionType.unknown:
        if (inner is SocketException) {
          return const NoInternetFailure();
        }
        return UnexpectedFailure(
          message: exception.message ?? 'Unknown error occurred',
        );
    }
  }

  /// Map an HTTP error response (4xx/5xx) to a [Failure].
  Failure _handleBadResponse(final DioException exception) {
    final int? statusCode = exception.response?.statusCode;
    final Object? data = exception.response?.data;

    String message = 'Server error occurred';
    if (data is Map<String, dynamic>) {
      final Object? extracted =
          data['message'] ??
          data['error_description'] ??
          data['msg'] ??
          data['error'] ??
          data['detail'];
      if (extracted is String && extracted.isNotEmpty) {
        message = extracted;
      } else if (extracted != null) {
        message = extracted.toString();
      }
    } else if (data is String && data.isNotEmpty) {
      message = data;
    }

    switch (statusCode) {
      case 400:
        return BadRequestFailure(message: message, details: data);
      case 401:
        return UnauthorizedFailure(message: message, details: data);
      case 403:
        return ForbiddenFailure(message: message, details: data);
      case 404:
        return NotFoundFailure(message: message, details: data);
      case 409:
        return ServerFailure(
          message: message,
          code: 'CONFLICT',
          statusCode: 409,
          details: data,
        );
      case 422:
        Map<String, List<String>>? fieldErrors;
        if (data is Map<String, dynamic> && data['errors'] != null) {
          fieldErrors = _extractFieldErrors(data['errors']);
        }
        return ValidationFailure(
          message: message,
          fieldErrors: fieldErrors,
          details: data,
        );
      case 429:
        return const ServerFailure(
          message: 'Too many requests',
          code: 'TOO_MANY_REQUESTS',
          statusCode: 429,
        );
      case 500:
      case 502:
      case 503:
      case 504:
        return ServerFailure(
          message: message,
          statusCode: statusCode,
          details: data,
        );
      default:
        return ServerFailure(
          message: message,
          statusCode: statusCode,
          details: data,
        );
    }
  }

  /// Extract field-level validation errors from a 422 response body.
  Map<String, List<String>> _extractFieldErrors(final Object? errors) {
    final Map<String, List<String>> fieldErrors = <String, List<String>>{};

    if (errors is Map<String, dynamic>) {
      errors.forEach((final String key, final Object? value) {
        if (value is List) {
          fieldErrors[key] = value
              .map((final Object? e) => e?.toString() ?? '')
              .where((final String s) => s.isNotEmpty)
              .toList(growable: false);
        } else if (value is String) {
          fieldErrors[key] = <String>[value];
        }
      });
    }

    return fieldErrors;
  }

  /// Log an error through [AppLogger].
  ///
  /// `AppLogger` is a no-op in release and profile builds, so this is cheap
  /// to call from every error path.
  void _logError(final Object error, [final StackTrace? stackTrace]) {
    _logger.error('Unhandled error', error, stackTrace, 'ErrorHandler');
  }

  /// Send an error to the remote reporting service. Skipped in debug builds.
  void _reportError(final Object error, [final StackTrace? stackTrace]) {
    if (kDebugMode) return;
    _errorReportingService?.reportError(
      error,
      stackTrace ?? StackTrace.current,
    );
  }

  /// Return a user-friendly message for [failure].
  ///
  /// Specific subtypes are checked before more general ones. For example,
  /// [UnauthorizedFailure] is checked before [ServerFailure].
  String getUserMessage(final Failure failure) {
    if (failure is NoInternetFailure) {
      return 'No internet connection. Please check your network and try again.';
    }

    if (failure is TimeoutFailure) {
      return 'Request timed out. Please check your connection and try again.';
    }

    if (failure is UnauthorizedFailure) {
      return 'Your session has expired. Please login again.';
    }
    if (failure is ForbiddenFailure) {
      return 'You do not have permission to perform this action.';
    }
    if (failure is InvalidCredentialsFailure) {
      return 'Invalid email or password. Please try again.';
    }
    if (failure is EmailAlreadyExistsFailure) {
      return 'This email is already registered. Please use a different email.';
    }
    if (failure is NotFoundFailure) {
      return 'The requested item was not found.';
    }
    if (failure is BadRequestFailure) {
      return 'Invalid request. Please check your input.';
    }

    if (failure is ServerFailure) {
      final int? code = failure.statusCode;
      if (code != null && code >= 500) {
        return 'Server is currently unavailable. Please try again later.';
      }
      return failure.message;
    }

    if (failure is ValidationFailure) {
      final Map<String, List<String>>? errors = failure.fieldErrors;
      if (errors != null && errors.isNotEmpty) {
        final List<String> firstField = errors.values.firstWhere(
          (final List<String> v) => v.isNotEmpty,
          orElse: () => const <String>[],
        );
        if (firstField.isNotEmpty) {
          return firstField.first;
        }
      }
      return failure.message;
    }

    if (failure is CacheFailure || failure is DatabaseFailure) {
      return 'Local storage error. Please try clearing app data.';
    }

    if (failure is ParsingFailure) {
      return 'Unable to process data. Please try again.';
    }

    if (failure is BusinessRuleFailure) {
      return failure.message;
    }

    return failure.message;
  }

  /// True if the failure might succeed on retry.
  ///
  /// Used by the UI to decide whether to show a Retry button.
  bool isRecoverable(final Failure failure) {
    // Auth failures come first. They look network-related but actually need
    // a login, not a blind retry.
    if (failure is UnauthorizedFailure || failure is InvalidTokenFailure) {
      return false;
    }

    if (failure is NetworkFailure) {
      if (failure is ServerFailure) {
        final int? code = failure.statusCode;
        return code != null && code >= 500;
      }
      return true;
    }

    if (failure is ValidationFailure) {
      return true;
    }

    return false;
  }

  /// True if the failure means the user should be signed out.
  bool shouldLogout(final Failure failure) =>
      failure is UnauthorizedFailure || failure is InvalidTokenFailure;

  /// True if the error is worth sending to the remote reporting service.
  ///
  /// Expected, user-facing errors (offline, timeout, validation) return
  /// false to keep the noise low. Everything else returns true.
  bool shouldReport(final Object error) {
    if (error is NoInternetException ||
        error is AppTimeoutException ||
        error is async.TimeoutException ||
        error is ValidationException) {
      return false;
    }
    return true;
  }

  /// Run [function] inside a try/catch. Returns the result on success.
  ///
  /// On error: logs and reports through [handleException]. Then either
  /// returns [fallback] (if given) or rethrows so the caller can decide.
  Future<T> runGuarded<T>(
    final Future<T> Function() function, {
    final T? fallback,
  }) async {
    try {
      return await function();
    } on Object catch (e, s) {
      handleException(e, s);
      if (fallback != null) return fallback;
      rethrow;
    }
  }

  /// Run [function] and return an Either. Right on success, Left on error
  /// (with the exception already mapped to a Failure).
  Future<Either<Failure, T>> runGuardedEither<T>(
    final Future<T> Function() function,
  ) async {
    try {
      final T result = await function();
      return Right<Failure, T>(result);
    } on Object catch (e, s) {
      return Left<Failure, T>(handleException(e, s));
    }
  }
}
