// ==============================================================================
// lib/core/services/storage_service.dart
// Wrapper around SharedPreferences for app-wide key-value storage.
//
// SECURITY NOTE
// -------------
// SharedPreferences is NOT encrypted. The auth and refresh token helpers
// below save credentials in plain text. This is only a first pass.
//
// Before release, replace the token helpers with a secure backend such as
// `flutter_secure_storage` (Android Keystore + iOS Keychain). The rest of
// the API can stay on SharedPreferences. Migration steps:
//
//   1. Add the dependency. Create `SecureStorageService` with the same
//      methods (getAuthToken / setAuthToken / clearTokens).
//   2. Inject `SecureStorageService` into `AuthInterceptor`.
//   3. On startup, if a token exists here, copy it across and clear it.
// ==============================================================================

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../errors/exceptions.dart';
import '../utils/logger.dart';

/// Saves small key-value data using [SharedPreferences].
@lazySingleton
class StorageService {
  StorageService(this._prefs);

  final SharedPreferences _prefs;
  final AppLogger _logger = AppLogger.instance;

  // Storage keys
  static const String _keyAuthToken = 'auth_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyAuthExpiresAt = 'auth_expires_at_iso';
  static const String _keyOnboardingDone = 'onboarding_done';
  static const String _keyLanguageCode = 'language_code';
  static const String _keyUserCity = 'user_city';
  static const String _keyUserCountry = 'user_country';

  // ── Home lifecycle counters + interests ──────────────────────────────
  static const String _keyHomeOpenCount = 'home_open_count';
  static const String _keyHomeActiveDays = 'home_active_days';
  static const String _keyHomeLastOpenDay = 'home_last_open_day'; // yyyy-MM-dd
  static const String _keyHomeLastVisitIso = 'home_last_visit_iso';
  static const String _keyHomeInterests = 'home_interests';

  int get homeOpenCount => _prefs.getInt(_keyHomeOpenCount) ?? 0;
  int get homeActiveDays => _prefs.getInt(_keyHomeActiveDays) ?? 0;

  // ---------------------------------------------------------------------------
  // Typed accessors.
  //
  // Writes go through [_guardedWrite] so a failing SharedPreferences call
  // throws a typed StorageWriteException instead of returning a silent
  // false.
  // ---------------------------------------------------------------------------

  Future<void> setString(final String key, final String value) =>
      _guardedWrite(key, () => _prefs.setString(key, value));

  String? getString(final String key) => _prefs.getString(key);

  Future<void> setBool(final String key, final bool value) =>
      _guardedWrite(key, () => _prefs.setBool(key, value));

  bool? getBool(final String key) => _prefs.getBool(key);

  Future<void> setInt(final String key, final int value) =>
      _guardedWrite(key, () => _prefs.setInt(key, value));

  int? getInt(final String key) => _prefs.getInt(key);

  Future<void> setDouble(final String key, final double value) =>
      _guardedWrite(key, () => _prefs.setDouble(key, value));

  double? getDouble(final String key) => _prefs.getDouble(key);

  Future<void> setStringList(final String key, final List<String> value) =>
      _guardedWrite(key, () => _prefs.setStringList(key, value));

  List<String>? getStringList(final String key) => _prefs.getStringList(key);

  bool containsKey(final String key) => _prefs.containsKey(key);

  Future<void> remove(final String key) async {
    try {
      await _prefs.remove(key);
    } on Object catch (e, s) {
      throw StorageDeleteException(details: e, stackTrace: s);
    }
  }

  /// Clears ALL persisted state. Used for logout and "reset app data".
  /// Note: this also wipes onboarding and language preferences.
  Future<void> clear() async {
    try {
      await _prefs.clear();
    } on Object catch (e, s) {
      throw StorageWriteException(details: e, stackTrace: s);
    }
  }

  // ---------------------------------------------------------------------------
  // Auth tokens.
  //
  // See the SECURITY NOTE at the top of this file. These should move to a
  // secure backend before launch.
  // ---------------------------------------------------------------------------

  /// The stored bearer token, or null if the user is not signed in.
  String? getAuthToken() => _prefs.getString(_keyAuthToken);

  Future<void> setAuthToken(final String token) => _guardedWrite(
    _keyAuthToken,
    () => _prefs.setString(_keyAuthToken, token),
  );

  String? getRefreshToken() => _prefs.getString(_keyRefreshToken);

  Future<void> setRefreshToken(final String token) => _guardedWrite(
    _keyRefreshToken,
    () => _prefs.setString(_keyRefreshToken, token),
  );

  /// Remove both auth and refresh tokens. Used on logout and 401.
  Future<void> clearTokens() async {
    try {
      await _prefs.remove(_keyAuthToken);
      await _prefs.remove(_keyRefreshToken);
    } on Object catch (e, s) {
      throw StorageDeleteException(details: e, stackTrace: s);
    }
  }

  // ---------------------------------------------------------------------------
  // Auth token expiry
  //
  // Stored as an ISO-8601 timestamp so we can compare against DateTime.now()
  // and proactively refresh before the server rejects the token. Set on
  // login, signup, and refresh; cleared on logout / session expiry.
  // ---------------------------------------------------------------------------

  /// Absolute moment the current access token expires.
  /// Returns null when we have not stored an expiry yet (treat as unknown,
  /// not as "still valid").
  DateTime? getAuthExpiresAt() {
    final String? raw = _prefs.getString(_keyAuthExpiresAt);
    if (raw == null || raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }

  Future<void> setAuthExpiresAt(final DateTime expiresAt) => _guardedWrite(
    _keyAuthExpiresAt,
    () => _prefs.setString(
      _keyAuthExpiresAt,
      expiresAt.toUtc().toIso8601String(),
    ),
  );

  Future<void> clearAuthExpiresAt() async {
    try {
      await _prefs.remove(_keyAuthExpiresAt);
    } on Object catch (e, s) {
      throw StorageDeleteException(details: e, stackTrace: s);
    }
  }

  // ---------------------------------------------------------------------------
  // Onboarding
  // ---------------------------------------------------------------------------

  bool get isOnboardingDone => _prefs.getBool(_keyOnboardingDone) ?? false;

  Future<void> setOnboardingDone({final bool done = true}) => _guardedWrite(
    _keyOnboardingDone,
    () => _prefs.setBool(_keyOnboardingDone, done),
  );

  // ---------------------------------------------------------------------------
  // User location
  //
  // Set by the "Choose your location" screen on first signup. Presence of a
  // non-empty city means we have already asked, so the splash skips the
  // location screen on subsequent launches.
  // ---------------------------------------------------------------------------

  String? getUserCity() => _prefs.getString(_keyUserCity);

  String? getUserCountry() => _prefs.getString(_keyUserCountry);

  bool get isUserLocationSet => (getUserCity() ?? '').isNotEmpty;

  Future<void> setUserLocation({
    required final String city,
    final String? country,
  }) async {
    await _guardedWrite(
      _keyUserCity,
      () => _prefs.setString(_keyUserCity, city),
    );
    if (country != null && country.isNotEmpty) {
      await _guardedWrite(
        _keyUserCountry,
        () => _prefs.setString(_keyUserCountry, country),
      );
    } else {
      await _prefs.remove(_keyUserCountry);
    }
  }

  Future<void> clearUserLocation() async {
    try {
      await _prefs.remove(_keyUserCity);
      await _prefs.remove(_keyUserCountry);
    } on Object catch (e, s) {
      throw StorageDeleteException(details: e, stackTrace: s);
    }
  }

  // ---------------------------------------------------------------------------
  // Language
  // ---------------------------------------------------------------------------

  String? getLanguageCode() => _prefs.getString(_keyLanguageCode);

  Future<void> setLanguageCode(final String code) => _guardedWrite(
    _keyLanguageCode,
    () => _prefs.setString(_keyLanguageCode, code),
  );

  // ---------------------------------------------------------------------------
  // Home - Moment of previous Home open. for "New since your last visit".
  // ---------------------------------------------------------------------------

  DateTime? getHomeLastVisit() {
    final raw = _prefs.getString(_keyHomeLastVisitIso);
    return (raw == null || raw.isEmpty) ? null : DateTime.tryParse(raw);
  }

  List<String> getHomeInterest() =>
      _prefs.getStringList(_keyHomeInterests) ?? const <String>[];

  Future<void> setHomeInterests(final List<String> categories) => _guardedWrite(
    _keyHomeInterests,
    () => _prefs.setStringList(_keyHomeInterests, categories),
  );

  /// Call once each time Home is opened. Bumps the open counts, bumps
  /// active-days at most once per calendar day, and recors last-visit.
  Future<void> recordHomeOpen() async {
    final now = DateTime.now();
    final today = '${now.year}-${now.month}-${now.day}';
    await _guardedWrite(
      _keyHomeOpenCount,
      () => _prefs.setInt(_keyHomeOpenCount, homeOpenCount + 1),
    );

    if (_prefs.getString(_keyHomeLastOpenDay) != today) {
      await _guardedWrite(
        _keyHomeActiveDays,
        () => _prefs.setInt(_keyHomeActiveDays, homeActiveDays + 1),
      );
      await _guardedWrite(
        _keyHomeLastOpenDay,
        () => _prefs.setString(_keyHomeLastOpenDay, today),
      );
    }

    // Save *previous* visit before overwriting (read it first next time).
    await _guardedWrite(
      _keyHomeLastVisitIso,
      () => _prefs.setString(_keyHomeLastVisitIso, now.toIso8601String()),
    );
  }

  // ---------------------------------------------------------------------------
  // Internals
  // ---------------------------------------------------------------------------

  /// Wraps a SharedPreferences write so:
  ///   - a false return becomes a typed exception
  ///     (writes can fail under disk pressure on Android), and
  ///   - any plugin-level throw is wrapped in StorageWriteException.
  Future<void> _guardedWrite(
    final String key,
    final Future<bool> Function() write,
  ) async {
    try {
      final bool ok = await write();
      if (!ok) {
        throw StorageWriteException(
          message: 'Failed to write key "$key" to preferences',
        );
      }
    } on StorageException {
      rethrow;
    } on Object catch (e, s) {
      _logger.error('SharedPreferences write failed for $key', e, s, 'Storage');
      throw StorageWriteException(details: e, stackTrace: s);
    }
  }
}
