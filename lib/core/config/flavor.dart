// ==============================================================================
// lib/core/config/flavor.dart
// Build-time flavor for the app.
// ==============================================================================

/// Build-time flavor of the app.
///
/// We use Dart's built-in `EnumName.name`, which already returns
/// `'development'`, `'staging'`, or `'production'`. We do not shadow it
/// with a custom getter.
enum Flavor {
  development,
  staging,
  production;

  /// Human-readable label for logs and developer-facing UI.
  String get displayName {
    switch (this) {
      case Flavor.development:
        return 'Development';
      case Flavor.staging:
        return 'Staging';
      case Flavor.production:
        return 'Production';
    }
  }

  bool get isDevelopment => this == Flavor.development;
  bool get isStaging => this == Flavor.staging;
  bool get isProduction => this == Flavor.production;

  /// Parse [value] into a [Flavor]. Throws on unknown input instead of
  /// silently falling back to development. A typo in the entry point
  /// should not quietly ship the wrong flavor.
  static Flavor fromString(final String value) {
    switch (value.toLowerCase()) {
      case 'development':
      case 'dev':
        return Flavor.development;
      case 'staging':
      case 'stg':
        return Flavor.staging;
      case 'production':
      case 'prod':
        return Flavor.production;
      default:
        throw ArgumentError.value(value, 'value', 'Unknown flavor');
    }
  }
}
