// ==============================================================================
// lib/core/network/interceptors/logging_interceptor.dart
// Pretty HTTP logger with secret redaction.
//
// Output is gated by kDebugMode and by AppConfig.enableLogging (registered
// in DioClient), so release builds stay silent even if someone forgets the
// env flag.
//
// All sensitive headers and request / response body fields are masked
// before printing, including nested JSON. Long bodies are truncated.
// ==============================================================================

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Logs HTTP requests, responses, and errors with sensitive fields hidden.
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({this.maxBodyChars = 4096});

  /// Truncate any single body to this many characters before printing.
  /// Bigger payloads are noisy and may include binary data that we should
  /// not stringify in full.
  final int maxBodyChars;

  /// Header and field names whose value is always replaced before logging.
  static const List<String> _sensitiveKeys = <String>[
    'authorization',
    'cookie',
    'set-cookie',
    'token',
    'access_token',
    'refresh_token',
    'id_token',
    'password',
    'passwd',
    'secret',
    'api_key',
    'api-key',
    'x-api-key',
    'client_secret',
    'otp',
    'pin',
  ];

  static const String _topBar =
      '┌──────────────────────────────────────────────────────';
  static const String _midBar =
      '├──────────────────────────────────────────────────────';
  static const String _bottomBar =
      '└──────────────────────────────────────────────────────';

  @override
  void onRequest(
    final RequestOptions options,
    final RequestInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint(_topBar);
      debugPrint('│ 🌐 REQUEST: ${options.method} ${options.uri}');
      debugPrint(_midBar);

      debugPrint('│ Headers:');
      options.headers.forEach((final String key, final Object? value) {
        debugPrint('│   $key: ${_maskHeader(key, value)}');
      });

      if (options.queryParameters.isNotEmpty) {
        debugPrint('│ Query Parameters:');
        options.queryParameters.forEach(
          (final String key, final Object? value) {
            debugPrint('│   $key: $value');
          },
        );
      }

      if (options.data != null) {
        debugPrint('│ Body:');
        debugPrint(_indentBody(_redactBody(options.data)));
      }

      debugPrint(_bottomBar);
    }

    handler.next(options);
  }

  @override
  void onResponse(
    final Response<dynamic> response,
    final ResponseInterceptorHandler handler,
  ) {
    if (kDebugMode) {
      debugPrint(_topBar);
      debugPrint(
        '│ ✅ RESPONSE: ${response.statusCode} '
        '${response.requestOptions.uri}',
      );
      debugPrint(_midBar);

      debugPrint('│ Headers:');
      response.headers.map.forEach(
        (final String key, final List<String> value) {
          debugPrint('│   $key: ${_maskHeader(key, value.join(', '))}');
        },
      );

      debugPrint('│ Body:');
      debugPrint(_indentBody(_redactBody(response.data)));

      debugPrint(_bottomBar);
    }

    handler.next(response);
  }

  @override
  void onError(final DioException err, final ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(_topBar);
      debugPrint(
        '│ ❌ ERROR: ${err.requestOptions.method} ${err.requestOptions.uri}',
      );
      debugPrint(_midBar);

      debugPrint('│ Type: ${err.type}');
      debugPrint('│ Message: ${err.message}');

      final Response<dynamic>? response = err.response;
      if (response != null) {
        debugPrint('│ Status Code: ${response.statusCode}');
        debugPrint('│ Response:');
        debugPrint(_indentBody(_redactBody(response.data)));
      }

      debugPrint('│ Stack Trace:');
      debugPrint('│   ${err.stackTrace}');
      debugPrint(_bottomBar);
    }

    handler.next(err);
  }

  // ---------------------------------------------------------------------------
  // Redaction helpers
  // ---------------------------------------------------------------------------

  /// True if [key] should have its value masked.
  bool _isSensitive(final String key) {
    final String lower = key.toLowerCase();
    return _sensitiveKeys.any(lower.contains);
  }

  /// Masked value for a header. Stringifies non-string values first so we
  /// do not accidentally leak via `toString()` of a custom type.
  String _maskHeader(final String key, final Object? value) {
    if (_isSensitive(key)) return '***REDACTED***';
    return value.toString();
  }

  /// Redacts sensitive fields in [data] and returns the result as text.
  /// Maps are walked recursively. FormData reports field names and file
  /// keys only (never file bytes).
  String _redactBody(final Object? data) {
    if (data == null) return 'null';
    Object? redacted = data;
    if (data is Map) {
      redacted = _deepRedact(data);
    } else if (data is List) {
      redacted = data.map(_deepRedact).toList(growable: false);
    } else if (data is FormData) {
      final Map<String, Object?> fields = <String, Object?>{};
      for (final MapEntry<String, String> e in data.fields) {
        fields[e.key] = _isSensitive(e.key) ? '***REDACTED***' : e.value;
      }
      redacted = <String, Object?>{
        'fields': fields,
        'files': data.files
            .map((final MapEntry<String, MultipartFile> f) => f.key)
            .toList(),
      };
    }

    String text;
    try {
      text = redacted is String
          ? redacted
          : const JsonEncoder.withIndent('  ').convert(redacted);
    } on Object {
      text = redacted.toString();
    }
    if (text.length > maxBodyChars) {
      return '${text.substring(0, maxBodyChars)}'
          '…(truncated ${text.length - maxBodyChars} chars)';
    }
    return text;
  }

  /// Walks [value] and replaces sensitive map keys with `***REDACTED***`.
  Object? _deepRedact(final Object? value) {
    if (value is Map) {
      final Map<Object?, Object?> out = <Object?, Object?>{};
      value.forEach((final Object? k, final Object? v) {
        if (k is String && _isSensitive(k)) {
          out[k] = '***REDACTED***';
        } else {
          out[k] = _deepRedact(v);
        }
      });
      return out;
    }
    if (value is List) {
      return value.map(_deepRedact).toList(growable: false);
    }
    return value;
  }

  /// Indent every line of [body] with `│   ` so multi-line JSON lines up
  /// inside the box.
  String _indentBody(final String body) {
    final List<String> lines = body.split('\n');
    final StringBuffer buf = StringBuffer();
    for (int i = 0; i < lines.length; i++) {
      buf.write('│   ${lines[i]}');
      if (i != lines.length - 1) buf.writeln();
    }
    return buf.toString();
  }
}
