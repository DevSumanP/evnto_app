// ==============================================================================
// lib/core/services/error_reporting_service.dart
// Sends uncaught errors to remote analytics / crash reporting.
//
// Sits behind the AnalyticsService interface so it does not matter whether
// the real sink is PostHog, Sentry, Firebase Crashlytics, or all three.
// Any error thrown by the sink is swallowed: crash reporting itself must
// never crash the app.
// ==============================================================================

import 'package:flutter/foundation.dart';

import '../di/core_injection.dart';
import '../utils/logger.dart';
import 'analytics/analytics_service.dart';

/// Bridge between the global error handler and remote reporting.
class ErrorReportingService {
  ErrorReportingService._();

  static final ErrorReportingService instance = ErrorReportingService._();

  final AppLogger _logger = AppLogger.instance;

  /// Truncate captured strings to this length before sending. Stack traces
  /// from deeply async code can be huge, and most analytics backends reject
  /// very large fields.
  static const int _maxFieldChars = 4000;

  /// Patterns that look like secrets. We err on the side of false positives
  /// rather than risk leaking a token.
  static final RegExp _secretPattern = RegExp(
    r'(?:bearer\s+[A-Za-z0-9._\-]+)|'
    r'(?:eyJ[A-Za-z0-9._\-]+)|' // JWT-like
    r'(?:[A-Fa-f0-9]{32,})', // long hex secrets / API keys
    caseSensitive: false,
  );

  /// Send [error] to the remote reporting service. Safe to call from any
  /// context. Failures are logged locally and never rethrown.
  void reportError(final Object? error, final StackTrace stackTrace) {
    try {
      if (!_resolverReady()) return;
      final AnalyticsService analytics = inject<AnalyticsService>();
      analytics.logEvent(
        'application_exception',
        properties: <String, dynamic>{
          'error_type': error?.runtimeType.toString() ?? 'Unknown',
          'error_message': _sanitize(error?.toString() ?? 'null'),
          'stack_trace': _sanitize(stackTrace.toString()),
          'is_fatal': true,
        },
      );
    } on Object catch (e, s) {
      _logger.warning(
        'Error reporting itself failed: $e',
        category: 'ErrorReporting',
        error: s,
      );
    }
  }

  /// Report a non-fatal warning. Useful for recoverable failures that are
  /// still worth tracking in aggregate.
  void reportWarning(
    final String message, {
    final Map<String, dynamic>? properties,
  }) {
    try {
      if (!_resolverReady()) return;
      final AnalyticsService analytics = inject<AnalyticsService>();
      final Map<String, dynamic> safe = <String, dynamic>{
        'message': _sanitize(message),
        if (properties != null)
          ...properties.map<String, Object?>(
            (final String k, final Object? v) =>
                MapEntry<String, Object?>(k, _sanitize(v?.toString() ?? '')),
          ),
        'is_fatal': false,
      };
      analytics.logEvent('application_warning', properties: safe);
    } on Object catch (e, s) {
      _logger.warning(
        'Warning reporting failed: $e',
        category: 'ErrorReporting',
        error: s,
      );
    }
  }

  /// True if the DI container can resolve the analytics service.
  /// Important for very-early-crash paths where bootstrap has not finished.
  bool _resolverReady() {
    try {
      return isRegistered<AnalyticsService>();
    } on Object {
      return false;
    }
  }

  /// Remove obvious secrets and clip very large strings before sending.
  String _sanitize(final String raw) {
    final String redacted = raw.replaceAll(_secretPattern, '***REDACTED***');
    if (redacted.length <= _maxFieldChars) return redacted;
    return '${redacted.substring(0, _maxFieldChars)}…(truncated)';
  }

  /// For tests: lets tests check the sanitization rules.
  @visibleForTesting
  String sanitizeForTest(final String raw) => _sanitize(raw);
}
