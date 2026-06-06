// ==============================================================================
// lib/core/theme/app_text_styles.dart
// Typography system aligned with Figma design tokens
// Font: Manrope (primary) · NotoSansDevanagari (Nepali)
// ==============================================================================

import 'package:flutter/material.dart';
import '../constants/app_constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Application text styles
/// e.g. AppTextStyles.bodySmallBold, AppTextStyles.h2Medium
abstract final class AppTextStyles {
  AppTextStyles._();

  // ==========================================================================
  // Font Families
  // ==========================================================================

  static String? primaryFont = GoogleFonts.manrope().fontFamily;
  static const String secondaryFont = 'NotoSansDevanagari';

  // ==========================================================================
  // Caption  ·  12px  ·  lineHeight 1.30
  // ==========================================================================

  static TextStyle captionBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    height: 1.30,
    letterSpacing: 0,
  );

  static TextStyle captionMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.30,
    letterSpacing: 0,
  );

  static TextStyle captionRegular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.30,
    letterSpacing: 0,
  );

  // ==========================================================================
  // Body Small  ·  14px  ·  lineHeight 1.30
  // ==========================================================================

  static TextStyle bodySmallBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.30,
    letterSpacing: 0,
  );

  static TextStyle bodySmallMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.30,
    letterSpacing: 0,
  );

  static TextStyle bodySmallRegular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.30,
    letterSpacing: 0,
  );

  // ==========================================================================
  // Body  ·  16px  ·  lineHeight 1.30 / 1.50
  // ==========================================================================

  static TextStyle bodyBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.30,
    letterSpacing: 0,
  );

  static TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.30,
    letterSpacing: 0,
  );

  static TextStyle bodyRegular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.50,
    letterSpacing: 0,
  );

  // ==========================================================================
  // Body Large  ·  18px  ·  lineHeight 1.50
  // ==========================================================================

  static TextStyle bodyLargeBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.50,
    letterSpacing: 0,
  );

  static TextStyle bodyLargeMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    height: 1.50,
    letterSpacing: 0,
  );

  static TextStyle bodyLargeRegular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.50,
    letterSpacing: 0,
  );

  // ==========================================================================
  // Body XL  ·  20px  ·  lineHeight 1.50
  // ==========================================================================

  static TextStyle bodyXlBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.50,
    letterSpacing: 0,
  );

  static TextStyle bodyXlMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.50,
    letterSpacing: 0,
  );

  static TextStyle bodyXlRegular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.50,
    letterSpacing: 0,
  );

  // ==========================================================================
  // H4  ·  24px  ·  lineHeight 1.50
  // ==========================================================================

  static TextStyle h4Bold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.50,
    letterSpacing: 0,
  );

  static TextStyle h4Medium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.50,
    letterSpacing: 0,
  );

  static TextStyle h4Regular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w400,
    height: 1.50,
    letterSpacing: 0,
  );

  // ==========================================================================
  // H3  ·  30px  ·  lineHeight 1.50
  // ==========================================================================

  static TextStyle h3Bold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 30,
    fontWeight: FontWeight.w700,
    height: 1.50,
    letterSpacing: 0,
  );

  static TextStyle h3Medium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 30,
    fontWeight: FontWeight.w500,
    height: 1.50,
    letterSpacing: 0,
  );

  static TextStyle h3Regular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 30,
    fontWeight: FontWeight.w400,
    height: 1.50,
    letterSpacing: 0,
  );

  // ==========================================================================
  // H2  ·  36px  ·  lineHeight 1.50
  // ==========================================================================

  static TextStyle h2Bold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.50,
    letterSpacing: 0,
  );

  static TextStyle h2Medium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 36,
    fontWeight: FontWeight.w500,
    height: 1.50,
    letterSpacing: 0,
  );

  static TextStyle h2Regular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    height: 1.50,
    letterSpacing: 0,
  );

  // ==========================================================================
  // H1  ·  48px  ·  lineHeight 1.16
  // ==========================================================================

  static TextStyle h1Bold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.16,
    letterSpacing: 0,
  );

  static TextStyle h1Medium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 48,
    fontWeight: FontWeight.w500,
    height: 1.16,
    letterSpacing: 0,
  );

  static TextStyle h1Regular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 48,
    fontWeight: FontWeight.w400,
    height: 1.16,
    letterSpacing: 0,
  );

  // ==========================================================================
  // Display Small  ·  60px  ·  lineHeight 1.13
  // ==========================================================================

  static TextStyle displaySmallBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 60,
    fontWeight: FontWeight.w700,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle displaySmallMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 60,
    fontWeight: FontWeight.w500,
    height: 1.13,
    letterSpacing: 0,
  );

  static TextStyle displaySmallRegular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 60,
    fontWeight: FontWeight.w400,
    height: 1.13,
    letterSpacing: 0,
  );

  // ==========================================================================
  // Display Medium  ·  72px  ·  lineHeight 1.10
  // ==========================================================================

  static TextStyle displayMediumBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 72,
    fontWeight: FontWeight.w700,
    height: 1.10,
    letterSpacing: 0,
  );

  static TextStyle displayMediumMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 72,
    fontWeight: FontWeight.w500,
    height: 1.10,
    letterSpacing: 0,
  );

  static TextStyle displayMediumRegular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 72,
    fontWeight: FontWeight.w400,
    height: 1.10,
    letterSpacing: 0,
  );

  // ==========================================================================
  // Display Large  ·  96px  ·  lineHeight 1.08
  // ==========================================================================

  static TextStyle displayLargeBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 96,
    fontWeight: FontWeight.w700,
    height: 1.08,
    letterSpacing: 0,
  );

  static TextStyle displayLargeMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 96,
    fontWeight: FontWeight.w500,
    height: 1.08,
    letterSpacing: 0,
  );

  static TextStyle displayLargeRegular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 96,
    fontWeight: FontWeight.w400,
    height: 1.08,
    letterSpacing: 0,
  );

  // ==========================================================================
  // Display XL  ·  128px  ·  lineHeight 1.06
  // ==========================================================================

  static TextStyle displayXlBold = TextStyle(
    fontFamily: primaryFont,
    fontSize: 128,
    fontWeight: FontWeight.w700,
    height: 1.06,
    letterSpacing: 0,
  );

  static TextStyle displayXlMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 128,
    fontWeight: FontWeight.w500,
    height: 1.06,
    letterSpacing: 0,
  );

  static TextStyle displayXlRegular = TextStyle(
    fontFamily: primaryFont,
    fontSize: 128,
    fontWeight: FontWeight.w400,
    height: 1.06,
    letterSpacing: 0,
  );

  // ==========================================================================
  // Convenience Aliases  (kept for backward-compat / common use cases)
  // ==========================================================================

  /// Equivalent to bodySmallRegular
  static TextStyle get bodySmall => bodySmallRegular;

  /// Equivalent to bodyRegular
  static TextStyle get body => bodyRegular;

  /// Equivalent to bodyLargeRegular
  static TextStyle get bodyLarge => bodyLargeRegular;

  // ==========================================================================
  // Button Styles
  // ==========================================================================

  static TextStyle button = TextStyle(
    fontFamily: primaryFont,
    fontSize: AppConstants.fontSizeMd,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: 1.25,
  );

  static TextStyle buttonSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: AppConstants.fontSizeSm,
    fontWeight: FontWeight.w600,
    height: 1,
    letterSpacing: 1.25,
  );

  // ==========================================================================
  // Label Styles
  // ==========================================================================

  static TextStyle labelLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
  );

  static TextStyle labelMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
  );

  static TextStyle labelSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
  );

  static TextStyle labelXSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
  );

  // ==========================================================================
  // Input / Form Styles
  // ==========================================================================

  static TextStyle input = TextStyle(
    fontFamily: primaryFont,
    fontSize: AppConstants.fontSizeMd,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
  );

  static TextStyle inputLabel = TextStyle(
    fontFamily: primaryFont,
    fontSize: AppConstants.fontSizeSm,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.4,
  );

  static TextStyle inputHint = TextStyle(
    fontFamily: primaryFont,
    fontSize: AppConstants.fontSizeMd,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
  );

  static TextStyle inputError = TextStyle(
    fontFamily: primaryFont,
    fontSize: AppConstants.fontSizeSm,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.4,
  );

  // ==========================================================================
  // Link Style
  // ==========================================================================

  static TextStyle link = TextStyle(
    fontFamily: primaryFont,
    fontSize: AppConstants.fontSizeMd,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0.15,
    decoration: TextDecoration.underline,
  );

  // ==========================================================================
  // Home Screen Styles
  // ==========================================================================

  static TextStyle greetingTitle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    color: AppColors.text500,
  );

  static TextStyle greetingSubtitle = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    color: AppColors.text300,
  );

  // ==========================================================================
  // Settings Page Styles  (English / Nepali)
  // ==========================================================================

  static String? getFontFamily(String languageCode) =>
      languageCode == 'ne' ? secondaryFont : primaryFont;

  static TextStyle settingsHeader(String languageCode) => TextStyle(
    fontFamily: getFontFamily(languageCode),
    fontSize: 28,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static TextStyle settingsLabel(String languageCode) => TextStyle(
    fontFamily: getFontFamily(languageCode),
    fontSize: 17,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
  );

  static TextStyle settingsSublabel(String languageCode) => TextStyle(
    fontFamily: getFontFamily(languageCode),
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.text300,
  );

  static TextStyle settingsDestructive(String languageCode) => TextStyle(
    fontFamily: getFontFamily(languageCode),
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary500,
  );

  // ==========================================================================
  // Theme-aware helpers
  // ==========================================================================

  static TextStyle withLightColor(
    final TextStyle style, {
    final Color? color,
  }) => style.copyWith(color: color ?? AppColors.textPrimaryLight);

  static TextStyle withDarkColor(final TextStyle style, {final Color? color}) =>
      style.copyWith(color: color ?? AppColors.textPrimaryDark);
}
