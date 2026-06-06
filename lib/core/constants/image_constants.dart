// ==============================================================================
// lib/core/constants/image_constants.dart
// Application-wide constants and configuration values
// Centralized constant management following immutable patterns
// ==============================================================================

/// Immutable application constants class
/// Uses private constructor to prevent instantiation
/// All values are compile-time constants where possible for performance
abstract final class ImageConstants {
  ImageConstants._();

  // ==========================================================================
  // App Icon
  // ==========================================================================

  static const String appIcon = 'assets/images/app_icon.jpg';
  static const String evnto = 'assets/images/evnto.svg';

  // ==========================================================================
  // Svg Icons
  // ==========================================================================

  static const String google = 'assets/images/google.svg';
  static const String apple = 'assets/images/apple.svg';

  static const String backArrow = 'assets/images/arrow-back.svg';
  static const String close = 'assets/images/close.svg';
  static const String more = 'assets/images/more.svg';

  static const String notification01 = 'assets/images/notification-01.svg';
  static const String notification02 = 'assets/images/notification-02.svg';

  static const String currentLocation = 'assets/images/current_location.svg';
  static const String download = 'assets/images/download.svg';
  static const String calendar = 'assets/images/calendar.svg';

  static const String heartFilled = 'assets/images/heart_filled.svg';
  static const String heart = 'assets/images/heart.svg';

  static const String locationFilled = 'assets/images/location_filled.svg';
  static const String location = 'assets/images/location.svg';

  static const String qrCode = 'assets/images/qr-code.svg';

  static const String search = 'assets/images/search.svg';

  static const String share = 'assets/images/share.svg';
  static const String share02 = 'assets/images/share-02.svg';

  static const String ticketBackground = 'assets/images/ticket.png';
  static const String customShape = 'assets/images/custom.png';

  // Bottom Nav Icons
  static const String homeNavActive = 'assets/images/homeActive.svg';
  static const String homeNavInactive = 'assets/images/homeInactive.svg';

  static const String exploreNavActive = 'assets/images/search.svg';
  static const String exploreNavInactive = 'assets/images/search.svg';

  static const String favoriteNavActive = 'assets/images/heartActive.svg';
  static const String favoriteNavInactive = 'assets/images/heartInactive.svg';

  static const String ticketNavActive = 'assets/images/ticketActive.svg';
  static const String ticketNavInactive = 'assets/images/ticketInactive.svg';

  static const String profielNavActive = 'assets/images/profileActive.svg';
  static const String profielNavInactive = 'assets/images/profileInactive.svg';

  // ==========================================================================
  // Profile Icons
  // ==========================================================================

  static const String user = 'assets/images/user.svg';
  static const String email = 'assets/images/email.svg';
  static const String phone = 'assets/images/pgone.svg';
  static const String password = 'assets/images/password.svg';
  static const String language = 'assets/images/language.svg';
  static const String edit = 'assets/images/edit.svg';
  static const String logout = 'assets/images/logout.svg';

  // ==========================================================================
  // Explore Icons
  // ==========================================================================

  static const String arts = 'assets/images/arts.svg';
  static const String music = 'assets/images/music.svg';
  static const String sports = 'assets/images/sports.svg';
  static const String food = 'assets/images/food.svg';
  static const String tech = 'assets/images/laptop.svg';
  static const String exploreAll = 'assets/images/lightning.svg';
}
