// ==============================================================================
// lib/core/services/analytics/analytics_service.dart
// Analytics contract. Used to swap providers (PostHog, Firebase, etc.)
// without touching callers.
// ==============================================================================

/// Contract for an analytics sink (PostHog, Firebase, etc.).
///
/// Implementations must be safe to call before [initialize]:
/// a method invoked on an uninitialized sink should be a no-op,
/// never a throw.
abstract class AnalyticsService {
  /// Initialize the analytics service. Safe to call more than once.
  Future<void> initialize();

  /// Tag the current session with a user ID and optional properties.
  Future<void> identifyUser(
    final String userId, {
    final Map<String, dynamic>? properties,
  });

  /// Log a screen view.
  Future<void> logScreenView(final String screenName);

  /// Log a custom event.
  Future<void> logEvent(
    final String eventName, {
    final Map<String, dynamic>? properties,
  });

  /// Reset the user session (for example, on logout). After this, events
  /// are sent as an anonymous user.
  Future<void> reset();
}
