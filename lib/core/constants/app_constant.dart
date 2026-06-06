// ==============================================================================
// lib/core/constants/app_constants.dart
// Application-wide constants and configuration values
// Centralized constant management following immutable patterns
// ==============================================================================

/// Immutable application constants class
/// Uses private constructor to prevent instantiation
/// All values are compile-time constants where possible for performance
abstract final class AppConstants {
  AppConstants._();

  // ==========================================================================
  // App Metadata
  // ==========================================================================

  static const String appName = 'MyApp';
  static const String appTagline = 'Your tagline here';
  static const String appDescription = 'Your app description';

  /// Semantic version following semver.org
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;
  static const String fullVersion = '$appVersion+$buildNumber';

  // ==========================================================================
  // Platform Identifiers
  // ==========================================================================

  static const String iosAppId = '123456789';
  static const String androidAppId = 'com.company.myapp';
  static const String iosBundleId = 'com.company.myapp';
  static const String androidPackageName = 'com.company.myapp';

  // ==========================================================================
  // Store URLs
  // ==========================================================================

  static const String appStoreUrl = 'https://apps.apple.com/app/id$iosAppId';
  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=$androidPackageName';
  static const String appWebsiteUrl = 'https://myapp.com';

  // ==========================================================================
  // Support & Legal
  // ==========================================================================

  static const String supportEmail = 'support@myapp.com';
  static const String contactEmail = 'contact@myapp.com';
  static const String feedbackEmail = 'feedback@myapp.com';
  static const String privacyPolicyUrl = 'https://myapp.com/privacy';
  static const String termsOfServiceUrl = 'https://myapp.com/terms';
  static const String cookiePolicyUrl = 'https://myapp.com/cookies';
  static const String helpCenterUrl = 'https://help.myapp.com';
  static const String faqUrl = 'https://myapp.com/faq';

  /// Network and API timeouts
  static const int apiTimeoutMs = 30000;
  static const int apiConnectTimeoutMs = 15000;
  static const int apiReceiveTimeoutMs = 30000;

  // ==========================================================================
  // Network & Retry Configuration
  // ==========================================================================

  static const int maxRetryAttempts = 3;
  static const int retryDelayMs = 2000;
  static const double retryBackoffMultiplier = 1.5;
  static const int maxConcurrentRequests = 5;

  // ==========================================================================
  // Locale & Internationalization
  // ==========================================================================

  static const String defaultLocale = 'en';
  static const String defaultCountryCode = 'US';
  static const List<String> supportedLanguages = <String>['en', 'np'];

  // ==========================================================================
  // Error Messages (Default fallbacks)
  // ==========================================================================

  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork =
      'Network error. Please check your connection.';
  static const String errorTimeout = 'Request timed out. Please try again.';
  static const String errorUnauthorized =
      'Session expired. Please login again.';
  static const String errorForbidden =
      'You do not have permission to access this.';
  static const String errorNotFound = 'The requested resource was not found.';
  static const String errorServerError =
      'Server error. Please try again later.';
  static const String errorValidation =
      'Please check your input and try again.';

  // ==========================================================================
  // Layout & Spacing
  // ==========================================================================

  static const double paddingXs = 4.0;
  static const double paddingSm = 8.0;
  static const double paddingMd = 16.0;
  static const double paddingLg = 24.0;
  static const double paddingXl = 32.0;
  static const double paddingXxl = 48.0;

  // ==========================================================================
  // Font Sizes
  // ==========================================================================

  static const double fontSizeHeading1 = 32.0;
  static const double fontSizeHeading2 = 24.0;
  static const double fontSizeHeading3 = 20.0;
  static const double fontSizeHeading4 = 18.0;
  static const double fontSizeHeading5 = 16.0;
  static const double fontSizeHeading6 = 14.0;
  static const double fontSizeHeading7 = 12.0;

  static const double fontSizeXs = 10.0;
  static const double fontSizeSm = 12.0;
  static const double fontSizeMd = 14.0;
  static const double fontSizeLg = 16.0;
  static const double fontSizeXl = 18.0;

  // ==========================================================================
  // Border Radius
  // ==========================================================================

  static const double borderRadiusXs = 4.0;
  static const double borderRadiusSm = 8.0;
  static const double borderRadiusMd = 12.0;
  static const double borderRadiusLg = 16.0;
  static const double borderRadiusXl = 24.0;
  static const double borderRadiusCircular = 100.0;

  // ==========================================================================
  // Icon Sizes
  // ==========================================================================

  static const double iconSizeXs = 12.0;
  static const double iconSizeSm = 16.0;
  static const double iconSizeMd = 24.0;
  static const double iconSizeLg = 32.0;
  static const double iconSizeXl = 48.0;
  static const double iconSizeXxl = 64.0;

  // ==========================================================================
  // Component Dimensions
  // ==========================================================================

  static const double buttonHeightSm = 32.0;
  static const double buttonHeightMd = 48.0;
  static const double buttonHeightLg = 56.0;
  static const double buttonMinWidth = 64.0;

  static const double appBarHeight = 56.0;
  static const double bottomBarHeight = 64.0;
  static const double tabBarHeight = 48.0;

  // ==========================================================================
  // Elevation
  // ==========================================================================

  static const double elevationNone = 0.0;
  static const double elevationLow = 2.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  static const double elevationHighest = 12.0;

  // ==========================================================================
  // Grid Configuration
  // ==========================================================================

  static const int gridCrossAxisCount = 2;
  static const double gridChildAspectRatio = 1.0;
}
