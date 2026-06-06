// ==============================================================================
// lib/core/constants/api_constants.dart
// Endpoint paths and network constants used by the mobile app.
//
// Scope is mobile only: server-only endpoints (Khalti webhook, admin tools,
// cron jobs) are not included here. They live on the backend and never need
// a Dart constant.
//
// Two URL bases the app talks to:
//   - Edge Functions  → AppConfig.apiBaseUrl  (https://<ref>.functions.supabase.co)
//   - Supabase Auth   → AppConfig.supabaseUrl (https://<ref>.supabase.co)
// ==============================================================================

abstract final class ApiConstants {
  ApiConstants._();

  // ==========================================================================
  // Headers
  // ==========================================================================

  static const String contentType = 'Content-Type';
  static const String accept = 'Accept';
  static const String authorization = 'Authorization';
  static const String supabaseApiKey = 'apikey';
  static const String requestId = 'X-Request-Id';
  static const String idempotencyKey = 'Idempotency-Key';
  static const String platform = 'X-Platform';
  static const String appVersion = 'X-App-Version';
  static const String language = 'Accept-Language';

  // Legacy aliases kept so older scaffolded interceptors keep compiling.
  static const String headerContentType = contentType;
  static const String headerAccept = accept;
  static const String headerAuthorization = authorization;
  static const String headerPlatform = platform;
  static const String headerAppVersion = appVersion;
  static const String headerLanguage = language;
  static const String headerRequestId = requestId;

  // ==========================================================================
  // Content types
  // ==========================================================================

  static const String jsonType = 'application/json';
  static const String formDataType = 'multipart/form-data';
  static const String urlEncodedType = 'application/x-www-form-urlencoded';

  // Legacy aliases.
  static const String contentTypeJson = jsonType;
  static const String contentTypeFormData = formDataType;
  static const String contentTypeUrlEncoded = urlEncodedType;

  // ==========================================================================
  // Edge Function paths (relative to AppConfig.apiBaseUrl)
  // ==========================================================================

  // System
  static const String health = '/health';

  // Profile + organizer onboarding
  static const String profile = '/profile-upsert';
  static const String becomeOrganizer = '/organizers-create';

  // Location
  static const String locationsPopular = '/locations-popular';

  // Discover feed (public — apikey only, no JWT required)
  static const String events = '/events-list';
  static const String eventDetail = '/events-get';
  static const String eventsNearby = '/events-nearby';
  static const String eventsSearch = '/events-search';

  // Event management (organizer)
  static const String createEvent = '/events-create';
  static const String updateEvent = '/events-update';
  static const String publishEvent = '/events-publish';

  // Tiers + seats (organizer)
  static const String upsertTier = '/tiers-upsert';
  static const String upsertSeats = '/seats-bulk-upsert';

  // Favorites
  static const String toggleFavorite = '/favorites-toggle';
  static const String favoritesList = '/favorites-list';

  // Checkout (Khalti)
  static const String startCheckout = '/checkout-initiate';
  static const String verifyCheckout = '/checkout-verify';

  // Tickets
  static const String myTickets = '/tickets-mine';
  static const String ticketQr = '/tickets-qr';

  // Check-in (scanner)
  static const String validateCheckin = '/checkin-validate';

  // Organizer dashboard
  static const String organizerStats = '/organizer-dashboard';

  // Push notifications
  static const String registerDevice = '/push-register';
  static const String broadcastPush = '/push-broadcast';

  // Profile
  static const String profileGet = '/profiles-get';
  static const String ordersMine = '/orders-mine';
  static const String unregisterDevice = '/push-unregister';
  static const String accountDelete = '/account-delete';

  // ==========================================================================
  // Supabase Auth paths (relative to AppConfig.supabaseUrl)
  // ==========================================================================

  static const String _authBase = '/auth/v1';

  static const String signUp = '$_authBase/signup';
  static const String signIn = '$_authBase/token'; // grant_type=password
  static const String refreshToken =
      '$_authBase/token'; // grant_type=refresh_token
  static const String currentUser = '$_authBase/user';
  static const String signOut = '$_authBase/logout';
  static const String resetPassword = '$_authBase/recover';
  static const String verifyOtp = '$_authBase/verify';

  // OAuth: open `${authorize}?provider=google` (or apple) in a browser/webview.
  static const String authorize = '$_authBase/authorize';
}
