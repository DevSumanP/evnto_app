// ==============================================================================
// lib/feature/splash/domain/entities/splash_navigation_result.dart
// Where the splash should send the user once startup checks finish.
// ==============================================================================

enum SplashNavigationResult {
  /// Device is offline. Show the no-internet screen.
  noInternet,

  /// Backend is unreachable or signalled maintenance.
  maintenance,

  /// First-time user. Show the welcome / sign-up screen.
  onboard,

  /// Returning user without a valid session. Show the sign-in screen.
  login,

  /// Signed-in user without a stored location. Send them to the picker
  /// before showing the home feed.
  chooseLocation,

  /// Signed-in user with a stored token. Go straight to home.
  home,
}
