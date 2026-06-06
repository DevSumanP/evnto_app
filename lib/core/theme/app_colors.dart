// ==============================================================================
// lib/core/theme/app_colors.dart
// Centralized color palette for light and dark themes
// Following Material Design 3 color system
// ==============================================================================

import 'package:flutter/material.dart';

/// Application color palette
/// Organized by color categories and semantic meanings
abstract final class AppColors {
  AppColors._();

  // ==========================================================================
  // Primary Colors (Navy Blue)
  // ==========================================================================
  static const Color primary = Color(0xFFFF8551);

  static const Color primarymain = Color(0xff2563EB);
  static const Color primary50 = Color(0xFFE9EDF3);
  static const Color primary100 = Color(0xFFBBC7D8);
  static const Color primary200 = Color(0xFF9AACC6);
  static const Color primary300 = Color(0xFF6C86AB);
  static const Color primary400 = Color(0xFF4F6F9B);
  static const Color primary500 = Color(0xFF234B82); // Base
  static const Color primary600 = Color(0xFF204476);
  static const Color primary700 = Color(0xFF19355C);
  static const Color primary800 = Color(0xFF132948);
  static const Color primary900 = Color(0xFF0F2037);

  // ==========================================================================
  // Secondary Colors (Red)
  // ==========================================================================

  static const Color secondary50 = Color(0xFFF9E8EA);
  static const Color secondary100 = Color(0xFFEDB8BD);
  static const Color secondary200 = Color(0xFFE4969D);
  static const Color secondary300 = Color(0xFFD76670);
  static const Color secondary400 = Color(0xFFD04954);
  static const Color secondary500 = Color(0xFFC41B29); // Base
  static const Color secondary600 = Color(0xFFB21925);
  static const Color secondary700 = Color(0xFF8B131D);
  static const Color secondary800 = Color(0xFF6C0F17);
  static const Color secondary900 = Color(0xFF520B11);

  // ==========================================================================
  // Text Colors
  // ==========================================================================

  static const Color text10 = Color(0xFFF8F8F8);
  static const Color text20 = Color(0xFFE8E9EB);
  static const Color text30 = Color(0xFFDDDEE1);
  static const Color text40 = Color(0xFFCDCFD3);
  static const Color text50 = Color(0xFFE7E8EA);
  static const Color text100 = Color(0xFFB5B7BD);
  static const Color text200 = Color(0xFF91949D);
  static const Color text300 = Color(0xFF5E6470);
  static const Color text400 = Color(0xFF3F4555);
  static const Color text500 = Color(0xFF0F172A); // Base / primary text
  static const Color text600 = Color(0xFF0E1526);
  static const Color text700 = Color(0xFF0B101E);
  static const Color text800 = Color(0xFF080D17);
  static const Color text900 = Color(0xFF060A12);

  // ==========================================================================
  // Neutral / Base
  // ==========================================================================

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ==========================================================================
  // Greyscale
  // ==========================================================================

  static const Color greyscale900 = Color(0xFF000000);
  static const Color greyscale800 = Color(0xFF1A1A1A);
  static const Color greyscale700 = Color(0xFF333333);
  static const Color greyscale600 = Color(0xFF4D4D4D);
  static const Color greyscale500 = Color(0xFF666666);
  static const Color greyscale400 = Color(0xFF808080);
  static const Color greyscale300 = Color(0xFF999999);
  static const Color greyscale200 = Color(0xFFB3B3B3);
  static const Color greyscale100 = Color(0xFFCCCCCC);
  static const Color greyscale50 = Color(0xFFE6E6E6);
  static const Color greyscale25 = Color(0xFFF2F2F2);
  static const Color greyscale5 = Color(0xFFFAFAFA);
  static const Color greyscale0 = Color(0xFFFFFFFF);

  // ==========================================================================
  // Light Theme Semantic Colors
  // ==========================================================================

  static const Color primaryLight = primary500;
  static const Color primaryVariantLight = primary700;
  static const Color onPrimaryLight = white;

  static const Color secondaryLight = secondary500;
  static const Color secondaryVariantLight = secondary700;
  static const Color onSecondaryLight = white;

  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = text500;
  static const Color onSurfaceLight = text500;

  static const Color errorLight = Color(0xFFEF4444);
  static const Color onErrorLight = white;

  static const Color successLight = Color(0xFF10B981);
  static const Color onSuccessLight = white;

  static const Color warningLight = Color(0xFFF59E0B);
  static const Color onWarningLight = black;

  static const Color infoLight = Color(0xFF3B82F6);
  static const Color onInfoLight = white;

  // ==========================================================================
  // Dark Theme Semantic Colors
  // ==========================================================================

  static const Color primaryDark = primary300;
  static const Color primaryVariantDark = primary500;
  static const Color onPrimaryDark = black;

  static const Color secondaryDark = secondary300;
  static const Color secondaryVariantDark = secondary500;
  static const Color onSecondaryDark = black;

  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color onBackgroundDark = white;
  static const Color onSurfaceDark = white;

  static const Color errorDark = Color(0xFFCF6679);
  static const Color onErrorDark = black;

  static const Color successDark = Color(0xFF66BB6A);
  static const Color onSuccessDark = black;

  static const Color warningDark = Color(0xFFFFB74D);
  static const Color onWarningDark = black;

  static const Color infoDark = Color(0xFF64B5F6);
  static const Color onInfoDark = black;

  // ==========================================================================
  // Grey Scale (Material-style aliases)
  // ==========================================================================

  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey900 = Color(0xFF212121);

  // ==========================================================================
  // Semantic Text Colors (Light / Dark)
  // ==========================================================================

  static const Color textPrimaryLight = text500;
  static const Color textSecondaryLight = text300;
  static const Color textDisabledLight = text100;
  static const Color textHintLight = text200;

  static const Color textPrimaryDark = text10;
  static const Color textSecondaryDark = text100;
  static const Color textDisabledDark = text300;
  static const Color textHintDark = text200;

  // ==========================================================================
  // Divider, Shadow & Overlay
  // ==========================================================================

  static const Color dividerLight = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF2C2C2C);

  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x4D000000);

  static const Color overlayLight = Color(0x0A000000);
  static const Color overlayDark = Color(0x14FFFFFF);

  // ==========================================================================
  // Status Colors
  // ==========================================================================

  static const Color online = Color(0xFF4CAF50);
  static const Color offline = Color(0xFF9E9E9E);
  static const Color away = Color(0xFFFF9800);
  static const Color busy = Color(0xFFF44336);

  // ==========================================================================
  // Gradient Colors
  // ==========================================================================

  static const List<Color> primaryGradientLight = [primary400, primary700];
  static const List<Color> primaryGradientDark = [primary200, primary500];

  static const List<Color> successGradient = [
    Color(0xFF4CAF50),
    Color(0xFF66BB6A),
  ];

  static const List<Color> warningGradient = [
    Color(0xFFFF9800),
    Color(0xFFFFB74D),
  ];

  static const List<Color> errorGradient = [
    Color(0xFFF44336),
    Color(0xFFE57373),
  ];

  // ==========================================================================
  // Chart / Graph Colors
  // ==========================================================================

  static const List<Color> chartColors = [
    primary500,
    secondary500,
    Color(0xFFFF9800),
    Color(0xFF4CAF50),
    Color(0xFF2196F3),
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
    Color(0xFFFF5722),
  ];

  // ==========================================================================
  // Social Media Brand Colors
  // ==========================================================================

  static const Color facebook = Color(0xFF1877F2);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color google = Color(0xFFDB4437);
  static const Color apple = Color(0xFF000000);
  static const Color github = Color(0xFF181717);
  static const Color linkedin = Color(0xFF0A66C2);
  static const Color instagram = Color(0xFFE4405F);

  static Color? get divider => null;

  // ==========================================================================
  // Utility Methods
  // ==========================================================================

  /// Get color with opacity
  static Color withOpacity(final Color color, final double opacity) =>
      color.withValues(alpha: opacity);

  /// Lighten a color by percentage (0.0 – 1.0)
  static Color lighten(final Color color, [final double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  /// Darken a color by percentage (0.0 – 1.0)
  static Color darken(final Color color, [final double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final lightness = (hsl.lightness - amount).clamp(0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }
}
