// ==============================================================================
// lib/core/utils/context_extension.dart
// Shortcuts on BuildContext.
// ==============================================================================

import 'package:flutter/material.dart';

/// Common shortcuts on [BuildContext].
///
/// Each getter looks up at most one inherited widget, so callers only pay
/// for what they use.
extension ContextExtensions on BuildContext {
  // MediaQuery
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => mediaQuery.size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  EdgeInsets get screenPadding => mediaQuery.padding;
  EdgeInsets get viewInsets => mediaQuery.viewInsets;
  bool get isKeyboardVisible => viewInsets.bottom > 0;

  // Theme
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  bool get isDarkMode => theme.brightness == Brightness.dark;

  // Navigation and focus
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
  NavigatorState get navigator => Navigator.of(this);
  FocusScopeNode get focusScope => FocusScope.of(this);

  /// Hide the keyboard.
  void unfocus() => focusScope.unfocus();

  // Responsive breakpoints
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 900;
  bool get isDesktop => screenWidth >= 900;

  /// Pick a value for the current breakpoint. Falls back to [mobile] when
  /// no value is given for the active breakpoint.
  T responsive<T>({
    required final T mobile,
    final T? tablet,
    final T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  // Snackbar helpers

  /// Show a normal snackbar. Hides any previous snackbar first so quick taps
  /// do not queue up multiple messages.
  void showSnackBar(
    final String message, {
    final Duration duration = const Duration(seconds: 3),
    final SnackBarAction? action,
  }) {
    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), duration: duration, action: action),
      );
  }

  void showErrorSnackBar(final String message) {
    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: colorScheme.error,
          duration: const Duration(seconds: 4),
        ),
      );
  }

  void showSuccessSnackBar(final String message) {
    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green.shade700,
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
