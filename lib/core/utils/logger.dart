// ==============================================================================
// lib/core/utils/logger.dart
// Color-coded application logger with rich console output.
//
// All log output is silenced in release and profile builds. In debug builds,
// every line is sent to `dart:developer.log` (so DevTools and `flutter logs`
// pick it up) and also printed with ANSI colors to terminals that support them.
// ==============================================================================

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io' show Platform, stdout;

import 'package:flutter/foundation.dart';

/// ANSI color and style codes for terminal output.
class AnsiColors {
  static const String reset = '\x1B[0m';
  static const String black = '\x1B[30m';
  static const String red = '\x1B[31m';
  static const String green = '\x1B[32m';
  static const String yellow = '\x1B[33m';
  static const String blue = '\x1B[34m';
  static const String magenta = '\x1B[35m';
  static const String cyan = '\x1B[36m';
  static const String white = '\x1B[37m';

  // Bright colors
  static const String brightRed = '\x1B[91m';
  static const String brightGreen = '\x1B[92m';
  static const String brightYellow = '\x1B[93m';
  static const String brightBlue = '\x1B[94m';
  static const String brightMagenta = '\x1B[95m';
  static const String brightCyan = '\x1B[96m';
  static const String brightWhite = '\x1B[97m';

  // Background colors
  static const String bgRed = '\x1B[41m';
  static const String bgGreen = '\x1B[42m';
  static const String bgYellow = '\x1B[43m';
  static const String bgBlue = '\x1B[44m';

  // Text styles
  static const String bold = '\x1B[1m';
  static const String dim = '\x1B[2m';
  static const String italic = '\x1B[3m';
  static const String underline = '\x1B[4m';
}

/// Log levels with color, emoji, label, and DevTools severity number.
enum LogLevel {
  debug(AnsiColors.cyan, '🐛', 'DEBUG', 500),
  info(AnsiColors.brightBlue, '💡', 'INFO', 800),
  warning(AnsiColors.brightYellow, '⚠️', 'WARN', 900),
  error(AnsiColors.brightRed, '❌', 'ERROR', 1000),
  success(AnsiColors.brightGreen, '✅', 'SUCCESS', 800),
  network(AnsiColors.magenta, '🌐', 'NETWORK', 700),
  database(AnsiColors.brightCyan, '💾', 'DATABASE', 700),
  lifecycle(AnsiColors.green, '🔄', 'LIFECYCLE', 600);

  const LogLevel(this.color, this.icon, this.label, this.devLogLevel);

  final String color;
  final String icon;
  final String label;

  /// Severity number used by `dart:developer.log`. Matches the values used
  /// by the Flutter framework so DevTools filters work as expected.
  final int devLogLevel;
}

/// Application logger.
///
/// Active in debug builds only. In release and profile builds every method
/// is a cheap no-op, except for [group] / [groupAsync] which still run their
/// body (only the decoration is skipped).
class AppLogger {
  AppLogger._internal();

  static final AppLogger _instance = AppLogger._internal();
  static AppLogger get instance => _instance;

  bool _initialized = false;

  /// Categories seen so far. Useful for debug overlays.
  final Set<String> _categories = <String>{};

  /// True only in debug builds.
  bool get _enabled => kDebugMode;

  /// True if the terminal can render ANSI color codes. macOS and Linux
  /// terminals always can. On Windows we ask `stdout`.
  bool get _supportsColor {
    if (!_enabled || kIsWeb) return false;
    if (Platform.isMacOS || Platform.isLinux) return true;
    return stdout.supportsAnsiEscapes;
  }

  /// Initialize the logger. Safe to call more than once.
  void initialize() {
    if (_initialized) return;
    _initialized = true;
    _logStartupBanner();
  }

  /// Show a boxed startup banner.
  void _logStartupBanner() {
    if (!_enabled) return;
    final String timestamp = DateTime.now().toString().substring(0, 19);
    final String banner = '''
${_color(AnsiColors.brightCyan)}╔════════════════════════════════════════════════════════════════════════════╗
║                           🚀 APPLICATION STARTED 🚀                        ║
║                    $timestamp                    ║
╚════════════════════════════════════════════════════════════════════════════╝${_reset()}''';
    _print(banner);
  }

  // ---------------------------------------------------------------------------
  // One method per log level.
  // ---------------------------------------------------------------------------

  void debug(final String message, {final String? category}) =>
      _log(LogLevel.debug, message, category: category);

  void info(final String message, {final String? category}) =>
      _log(LogLevel.info, message, category: category);

  void warning(
    final String message, {
    final String? category,
    final Object? error,
  }) =>
      _log(LogLevel.warning, message, category: category, error: error);

  void error(
    final String message, [
    final Object? error,
    final StackTrace? stackTrace,
    final String? category,
  ]) =>
      _log(
        LogLevel.error,
        message,
        category: category,
        error: error,
        stackTrace: stackTrace,
      );

  void success(final String message, {final String? category}) =>
      _log(LogLevel.success, message, category: category);

  void network(final String message, {final String? category}) =>
      _log(LogLevel.network, message, category: category);

  void database(final String message, {final String? category}) =>
      _log(LogLevel.database, message, category: category);

  void lifecycle(final String message, {final String? category}) =>
      _log(LogLevel.lifecycle, message, category: category);

  // ---------------------------------------------------------------------------
  // Decorations.
  // ---------------------------------------------------------------------------

  /// Boxed section header. Use to mark major bootstrap phases.
  void section(
    final String title, {
    final String color = AnsiColors.brightCyan,
  }) {
    if (!_enabled) return;
    final String line = '═' * (title.length + 4);
    _print('');
    _print('${_color(color)}╔$line╗${_reset()}');
    _print('${_color(color)}║  $title  ║${_reset()}');
    _print('${_color(color)}╚$line╝${_reset()}');
  }

  /// Horizontal divider line.
  void divider({
    final String char = '─',
    final int length = 70,
    final String color = AnsiColors.dim,
  }) {
    if (!_enabled) return;
    _print('${_color(color)}${char * length}${_reset()}');
  }

  /// Print a key and its value, indented.
  void keyValue(
    final String key,
    final Object? value, {
    final String color = AnsiColors.cyan,
  }) {
    if (!_enabled) return;
    _print('${_color(color)}  ├─ $key: ${_reset()}$value');
  }

  /// Print a bulleted list under [title].
  void list(
    final String title,
    final List<String> items, {
    final String color = AnsiColors.cyan,
  }) {
    if (!_enabled) return;
    _print('${_color(color)}  ├─ $title:${_reset()}');
    for (int i = 0; i < items.length; i++) {
      final bool isLast = i == items.length - 1;
      final String prefix = isLast ? '  └─' : '  ├─';
      _print('${_color(color)}$prefix ${items[i]}${_reset()}');
    }
  }

  /// Print a tree of branches under [root].
  void tree(
    final String root,
    final Map<String, Object?> branches, {
    final String color = AnsiColors.cyan,
  }) {
    if (!_enabled) return;
    _print('${_color(color)}$root${_reset()}');

    final List<String> keys = branches.keys.toList();
    for (int i = 0; i < keys.length; i++) {
      final bool isLast = i == keys.length - 1;
      final String key = keys[i];
      final Object? value = branches[key];
      final String prefix = isLast ? '└─' : '├─';
      _print('${_color(color)}$prefix $key: ${_reset()}$value');
    }
  }

  /// Total visual width of a group header / footer rule. Picked to match
  /// the dio logger box so every block in the console reads at the same width.
  static const int _groupWidth = 76;

  /// Build a header like `┌─ title ─────────────────╮` padded to [_groupWidth].
  String _buildGroupHeader(final String title) {
    // 4 reserved chars for the `┌─ ` prefix and trailing `╮`.
    final int padCount =
        _groupWidth - title.length - 4 < 0 ? 0 : _groupWidth - title.length - 4;
    return '┌─ $title ${'─' * padCount}╮';
  }

  /// Build a footer like `╰─────────────────────────╯` at [_groupWidth].
  String _buildGroupFooter() {
    final int dashes = _groupWidth - 2 < 0 ? 0 : _groupWidth - 2;
    return '╰${'─' * dashes}╯';
  }

  /// Run [body] inside a boxed header / footer block.
  /// [body] always runs. Only the decoration is skipped in release builds.
  void group(
    final String title,
    final void Function() body, {
    final String color = AnsiColors.brightBlue,
  }) {
    if (_enabled) _print('${_color(color)}${_buildGroupHeader(title)}${_reset()}');
    body();
    if (_enabled) {
      _print('${_color(color)}${_buildGroupFooter()}${_reset()}');
      _print('');
    }
  }

  /// Async version of [group]. [body] always runs.
  Future<void> groupAsync(
    final String title,
    final Future<void> Function() body, {
    final String color = AnsiColors.brightBlue,
  }) async {
    if (_enabled) _print('${_color(color)}${_buildGroupHeader(title)}${_reset()}');
    await body();
    if (_enabled) {
      _print('${_color(color)}${_buildGroupFooter()}${_reset()}');
      _print('');
    }
  }

  /// Print an ASCII table built from [headers] and [rows].
  void table(final List<String> headers, final List<List<String>> rows) {
    if (!_enabled) return;

    // Column widths: max of header width and any row cell width.
    final List<int> widths = List<int>.filled(headers.length, 0);
    for (int i = 0; i < headers.length; i++) {
      widths[i] = headers[i].length;
    }
    for (final List<String> row in rows) {
      for (int i = 0; i < row.length && i < widths.length; i++) {
        if (row[i].length > widths[i]) widths[i] = row[i].length;
      }
    }

    String buildRow(final List<String> cells) {
      final List<String> parts = <String>[];
      for (int i = 0; i < cells.length && i < widths.length; i++) {
        parts.add(cells[i].padRight(widths[i]));
      }
      return '│ ${parts.join(' │ ')} │';
    }

    String buildSeparator({
      final String left = '├',
      final String mid = '┼',
      final String right = '┤',
    }) {
      final Iterable<String> parts = widths.map((final int w) => '─' * w);
      return '$left─${parts.join('─$mid─')}─$right';
    }

    _print('┌─${widths.map((final int w) => '─' * w).join('─┬─')}─┐');
    _print(buildRow(headers));
    _print(buildSeparator());
    for (final List<String> row in rows) {
      _print(buildRow(row));
    }
    _print('└─${widths.map((final int w) => '─' * w).join('─┴─')}─┘');
  }

  /// All categories seen since startup.
  Set<String> get categories => Set<String>.unmodifiable(_categories);

  // ---------------------------------------------------------------------------
  // Internals.
  // ---------------------------------------------------------------------------

  void _log(
    final LogLevel level,
    final String message, {
    final String? category,
    final Object? error,
    final StackTrace? stackTrace,
  }) {
    if (category != null) _categories.add(category);
    if (!_enabled) return;

    final String categoryStr = category != null ? '[$category] ' : '';
    final String fullMessage = '$categoryStr$message';

    // Single source of truth for log output: dart:developer.log. DevTools,
    // IDEs and `flutter logs` all read from there. The colored stdout line
    // below is only an extra convenience for terminal users.
    developer.log(
      fullMessage,
      name: level.label,
      level: level.devLogLevel,
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );

    _printColored(level, fullMessage, error, stackTrace);
  }

  void _printColored(
    final LogLevel level,
    final String message,
    final Object? error,
    final StackTrace? stackTrace,
  ) {
    // No timestamp here on purpose. dart:developer.log above carries the
    // exact `DateTime.now()` for DevTools and `flutter logs`, so the
    // console line stays compact.
    _print(
      '${_color(level.color)}${level.icon} [${level.label}] $message${_reset()}',
    );

    if (error != null) {
      _print('${_color(AnsiColors.red)}   └─ Error: $error${_reset()}');
    }

    if (stackTrace != null && level == LogLevel.error) {
      final List<String> lines = stackTrace.toString().split('\n');
      final int take = lines.length < 5 ? lines.length : 5;
      for (int i = 0; i < take; i++) {
        _print('${_color(AnsiColors.dim)}   ${lines[i]}${_reset()}');
      }
    }
  }

  void _print(final String message) {
    if (!_enabled) return;
    print(message);
  }

  String _color(final String code) => _supportsColor ? code : '';
  String _reset() => _supportsColor ? AnsiColors.reset : '';
}
