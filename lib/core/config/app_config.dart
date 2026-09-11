// ==============================================================================
// lib/core/config/app_config.dart
// App configuration singleton. Values come from `.env.<flavor>` files.
// ==============================================================================

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'flavor.dart';

/// Central place to read environment-driven configuration.
///
/// Values are read on demand from [dotenv]. In development this means
/// hot-reload can pick up `.env.<flavor>` edits without an app restart.
/// In release builds the values are effectively constant once [initialize]
/// has run.
class AppConfig {
  AppConfig._({required this.flavor});

  static AppConfig? _instance;

  /// The active singleton. Throws if accessed before [initialize].
  static AppConfig get instance {
    final AppConfig? inst = _instance;
    if (inst == null) {
      throw StateError(
        'AppConfig accessed before initialize(). '
        'Call AppConfig.initialize(flavor) in bootstrap.',
      );
    }
    return inst;
  }

  /// True if [initialize] has run.
  static bool get isInitialized => _instance != null;

  /// The flavor of the running build.
  final Flavor flavor;

  // ---------------------------------------------------------------------------
  // Typed environment getters.
  //
  // Anything that the app needs to run (such as the API base URL) calls
  // [_required] and throws when missing. This way a bad .env fails loudly
  // at bootstrap instead of producing 404s later.
  // ---------------------------------------------------------------------------

  static String get appName => dotenv.get('APP_NAME', fallback: 'Tap App');

  /// Base URL for the Edge Functions REST API.
  /// e.g. https://<ref>.functions.supabase.co
  static String get apiBaseUrl => _required('API_BASE_URL');

  /// Base URL for Supabase Auth / Storage / Realtime.
  /// e.g. https://<ref>.supabase.co
  /// Falls back to [apiBaseUrl] with the `.functions` infix removed so older
  /// `.env` files that only set API_BASE_URL keep working.
  static String get supabaseUrl {
    final String? explicit = dotenv.maybeGet('SUPABASE_URL');
    if (explicit != null && explicit.isNotEmpty) return explicit;
    return apiBaseUrl.replaceFirst('.functions.supabase.co', '.supabase.co');
  }

  /// Supabase project anon key. Sent as the `apikey` header on every request
  /// to functions.supabase.co. Falls back to empty when not set so the env
  /// failure surfaces at the first request instead of at bootstrap.
  static String get supabaseAnonKey =>
      dotenv.maybeGet('SUPABASE_ANON_KEY') ?? '';

  static int get apiTimeoutSeconds =>
      int.tryParse(dotenv.get('API_TIMEOUT_SECONDS', fallback: '30')) ?? 30;

  static bool get enableLogging =>
      _bool('ENABLE_LOGGING', fallback: kDebugMode);

  /// Master switch for the Server-Driven UI Home screen. When false the app
  /// renders the legacy fixed Home. Phase A defaults to on; Phase B can flip
  /// this from a remote config to act as a kill-switch.
  static bool get sduiHomeEnabled =>
      _bool('SDUI_HOME_ENABLED', fallback: true);

  static String get posthogApiKey =>
      dotenv.get('POSTHOG_API_KEY', fallback: '');

  static String get posthogHost =>
      dotenv.get('POSTHOG_HOST', fallback: 'https://us.i.posthog.com');

  /// True if the MaterialApp debug banner should be shown.
  bool get showDebugBanner => flavor.isDevelopment;

  /// Load the correct `.env.<flavor>` file and create the singleton.
  /// Safe to call more than once; later calls are no-ops, so hot restart
  /// will not reload the env file mid-session.
  static Future<void> initialize(final Flavor flavor) async {
    if (_instance != null) return;
    await dotenv.load(fileName: '.env.${flavor.name}');
    _instance = AppConfig._(flavor: flavor);
  }

  /// For tests only. Production code must not call this.
  @visibleForTesting
  static void resetForTest() {
    _instance = null;
  }

  /// Read [key] from dotenv. Throws if missing or empty.
  static String _required(final String key) {
    final String value = dotenv.maybeGet(key) ?? '';
    if (value.isEmpty) {
      throw StateError(
        'Missing required environment variable "$key". '
        'Check .env.${_instance?.flavor.name ?? '<flavor>'}.',
      );
    }
    return value;
  }

  /// Parse a boolean from dotenv. Accepts true/false, 1/0, yes/no.
  static bool _bool(final String key, {required final bool fallback}) {
    final String? raw = dotenv.maybeGet(key);
    if (raw == null) return fallback;
    switch (raw.trim().toLowerCase()) {
      case 'true':
      case '1':
      case 'yes':
      case 'y':
        return true;
      case 'false':
      case '0':
      case 'no':
      case 'n':
        return false;
      default:
        return fallback;
    }
  }
}
