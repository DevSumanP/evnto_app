// ==============================================================================
// lib/core/services/analytics/posthog_analytics_service.dart
// PostHog-backed implementation of [AnalyticsService].
// ==============================================================================

import 'package:injectable/injectable.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

import '../../config/app_config.dart';
import '../../utils/logger.dart';
import 'analytics_service.dart';

/// PostHog implementation of [AnalyticsService].
///
/// Session replay is on. Outside development, text and image masking is
/// also on, and PostHog's own debug log is off. This keeps PII and noisy
/// diagnostics out of production analytics.
@LazySingleton(as: AnalyticsService)
class PosthogAnalyticsService implements AnalyticsService {
  final Posthog _posthog = Posthog();
  final AppLogger _logger = AppLogger.instance;

  bool _enabled = false;

  @override
  Future<void> initialize() async {
    final String apiKey = AppConfig.posthogApiKey;
    final String host = AppConfig.posthogHost;

    if (apiKey.isEmpty) {
      _logger.warning(
        'PostHog API key is empty. Analytics will be a no-op.',
        category: 'Analytics',
      );
      return;
    }

    final bool isDev = AppConfig.instance.flavor.isDevelopment;

    try {
      final PostHogConfig config = PostHogConfig(apiKey)
        ..host = host
        ..captureApplicationLifecycleEvents = true
        ..sessionReplay = true
        ..debug = isDev;

      // Mask session replays by default. We only unmask text and images in
      // development, where there is no real user data.
      config.sessionReplayConfig
        ..maskAllTexts = !isDev
        ..maskAllImages = !isDev
        ..throttleDelay = const Duration(milliseconds: 1000);

      await _posthog.setup(config);
      _enabled = true;
      _logger.success(
        'PostHog initialized (replay masking=${!isDev ? 'on' : 'off'})',
        category: 'Analytics',
      );
    } on Object catch (e, s) {
      _logger.error('Failed to initialize PostHog', e, s, 'Analytics');
    }
  }

  @override
  Future<void> identifyUser(
    final String userId, {
    final Map<String, dynamic>? properties,
  }) async {
    if (!_enabled) return;
    try {
      await _posthog.identify(
        userId: userId,
        userProperties: properties?.cast<String, Object>(),
      );
    } on Object catch (e, s) {
      _logger.error('Failed to identify user', e, s, 'Analytics');
    }
  }

  @override
  Future<void> logScreenView(final String screenName) async {
    if (!_enabled) return;
    try {
      await _posthog.screen(screenName: screenName);
    } on Object catch (e, s) {
      _logger.error('Failed to log screen view', e, s, 'Analytics');
    }
  }

  @override
  Future<void> logEvent(
    final String eventName, {
    final Map<String, dynamic>? properties,
  }) async {
    if (!_enabled) return;
    try {
      await _posthog.capture(
        eventName: eventName,
        properties: properties?.cast<String, Object>(),
      );
    } on Object catch (e, s) {
      _logger.error('Failed to log event "$eventName"', e, s, 'Analytics');
    }
  }

  @override
  Future<void> reset() async {
    if (!_enabled) return;
    try {
      await _posthog.reset();
    } on Object catch (e, s) {
      _logger.error('Failed to reset analytics session', e, s, 'Analytics');
    }
  }
}
