// ==============================================================================
// lib/core/network/api_endpoints.dart
// Typed accessors for every endpoint the mobile app calls.
// Grouped by feature so new contributors can find what they need fast.
//
// Two URL bases:
//   - Edge Functions → AppConfig.apiBaseUrl  (Dio default base)
//   - Supabase Auth  → AppConfig.supabaseUrl (used by the auth data source)
// ==============================================================================

import '../constants/api_constants.dart';

abstract final class ApiEndpoints {
  ApiEndpoints._();

  // ===========================================================================
  // System
  // ===========================================================================

  static const String health = ApiConstants.health;

  // ===========================================================================
  // Profile + organizer onboarding
  // ===========================================================================

  static const String profile = ApiConstants.profile;
  static const String becomeOrganizer = ApiConstants.becomeOrganizer;

  // ===========================================================================
  // Location
  // ===========================================================================

  static const String locationsPopular = ApiConstants.locationsPopular;

  // ===========================================================================
  // Discover
  // ===========================================================================

  static const String events = ApiConstants.events;
  static const String eventDetail = ApiConstants.eventDetail;
  static const String eventsNearby = ApiConstants.eventsNearby;
  static const String eventsSearch = ApiConstants.eventsSearch;
  static const String homeLayout = ApiConstants.homeLayout;

  // ===========================================================================
  // Event management (organizer)
  // ===========================================================================

  static const String createEvent = ApiConstants.createEvent;
  static const String updateEvent = ApiConstants.updateEvent;
  static const String publishEvent = ApiConstants.publishEvent;

  // ===========================================================================
  // Tiers + seats
  // ===========================================================================

  static const String upsertTier = ApiConstants.upsertTier;
  static const String upsertSeats = ApiConstants.upsertSeats;

  // ===========================================================================
  // Favorites
  // ===========================================================================

  static const String toggleFavorite = ApiConstants.toggleFavorite;
  static const String favoritesList = ApiConstants.favoritesList;

  // ===========================================================================
  // Checkout (Khalti)
  // ===========================================================================

  static const String startCheckout = ApiConstants.startCheckout;
  static const String verifyCheckout = ApiConstants.verifyCheckout;

  // ===========================================================================
  // Tickets
  // ===========================================================================

  static const String myTickets = ApiConstants.myTickets;
  static const String ticketQr = ApiConstants.ticketQr;

  // ===========================================================================
  // Check-in (scanner)
  // ===========================================================================

  static const String validateCheckin = ApiConstants.validateCheckin;

  // ===========================================================================
  // Organizer dashboard
  // ===========================================================================

  static const String organizerStats = ApiConstants.organizerStats;

  // ===========================================================================
  // Push notifications
  // ===========================================================================

  static const String registerDevice = ApiConstants.registerDevice;
  static const String broadcastPush = ApiConstants.broadcastPush;

  // ===========================================================================
  // Supabase Auth (against AppConfig.supabaseUrl)
  // ===========================================================================

  static const String signUp = ApiConstants.signUp;
  static const String signIn = ApiConstants.signIn;
  static const String refreshToken = ApiConstants.refreshToken;
  static const String currentUser = ApiConstants.currentUser;
  static const String signOut = ApiConstants.signOut;
  static const String resetPassword = ApiConstants.resetPassword;
  static const String verifyOtp = ApiConstants.verifyOtp;

  // ===========================================================================
  // Profile
  // ===========================================================================
  static const String profileGet = ApiConstants.profileGet;
  static const String ordersMine = ApiConstants.ordersMine;
  static const String unregisterDevice = ApiConstants.unregisterDevice;
  static const String accountDelete = ApiConstants.accountDelete;

  /// OAuth redirect URL for [provider] ('google' or 'apple').
  /// Open in an external browser or webview.
  static String oauth(final String provider) =>
      '${ApiConstants.authorize}?provider=$provider';
}
