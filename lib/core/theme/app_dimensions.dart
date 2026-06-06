// ==============================================================================
// lib/core/theme/app_dimensions.dart
// Spacing, sizing, and layout dimensions
// Ensures consistent spacing throughout the app
// ==============================================================================

import '../constants/app_constant.dart';

/// Application dimensions for spacing,sizing and layout
abstract final class AppDimensions {
  AppDimensions._();

  // ==========================================================================
  // Padding & Margin
  // ==========================================================================

  static const double paddingXs = AppConstants.paddingXs;
  static const double paddingSm = AppConstants.paddingSm;
  static const double paddingMd = AppConstants.paddingMd;
  static const double paddingLg = AppConstants.paddingLg;
  static const double paddingXl = AppConstants.paddingXl;
  static const double paddingXxl = AppConstants.paddingXxl;

  /// Screen edge padding
  static const double screenPadding = AppConstants.paddingMd;
  static const double screenPaddingHorizntal = AppConstants.paddingMd;
  static const double screenPaddingVertical = AppConstants.paddingMd;

  /// Card padding
  static const double cardPadding = AppConstants.paddingMd;
  static const double cardPaddingHorizontal = AppConstants.paddingMd;
  static const double cardPaddingVertical = AppConstants.paddingSm;

  /// List item padding
  static const double listItemPadding = AppConstants.paddingMd;
  static const double listItemPaddingHorizontal = AppConstants.paddingMd;
  static const double listItemPaddingVertical = AppConstants.paddingSm;

  // ==========================================================================
  // Border Radius (using constants)
  // ==========================================================================

  static const double borderRadiusXs = AppConstants.borderRadiusXs;
  static const double borderRadiusSm = AppConstants.borderRadiusSm;
  static const double borderRadiusMd = AppConstants.borderRadiusMd;
  static const double borderRadiusLg = AppConstants.borderRadiusLg;
  static const double borderRadiusXl = AppConstants.borderRadiusXl;
  static const double borderRadiusCircular = AppConstants.borderRadiusCircular;

  /// Component-specific radius
  static const double buttonBorderRadius = AppConstants.borderRadiusMd;
  static const double cardBorderRadius = AppConstants.borderRadiusMd;
  static const double inputBorderRadius = AppConstants.borderRadiusSm;
  static const double dialogBorderRadius = AppConstants.borderRadiusLg;
  static const double bottomSheetBorderRadius = AppConstants.borderRadiusLg;

  // ==========================================================================
  // Icon Sizes (using constants)
  // ==========================================================================

  static const double iconSizeXs = AppConstants.iconSizeXs;
  static const double iconSizeSm = AppConstants.iconSizeSm;
  static const double iconSizeMd = AppConstants.iconSizeMd;
  static const double iconSizeLg = AppConstants.iconSizeLg;
  static const double iconSizeXl = AppConstants.iconSizeXl;
  static const double iconSizeXxl = AppConstants.iconSizeXxl;

  // ==========================================================================
  // Button Dimensions (using constants)
  // ==========================================================================

  static const double buttonHeightSm = AppConstants.buttonHeightSm;
  static const double buttonHeightMd = AppConstants.buttonHeightMd;
  static const double buttonHeightLg = AppConstants.buttonHeightLg;
  static const double buttonMinWidth = AppConstants.buttonMinWidth;

  /// Button padding
  static const double buttonPaddingHorizontal = AppConstants.paddingLg;
  static const double buttonPaddingVertical = AppConstants.paddingSm;

  // ==========================================================================
  // App Bar & Navigation
  // ==========================================================================

  static const double appBarHeight = AppConstants.appBarHeight;
  static const double bottomBarHeight = AppConstants.bottomBarHeight;
  static const double tabBarHeight = AppConstants.tabBarHeight;
  static const double drawerWidth = 280;
  static const double fabSize = 56;
  static const double fabSizeSmall = 40;
  static const double fabSizeLarge = 96;

  // ==========================================================================
  // Elevation (using constants)
  // ==========================================================================

  static const double elevationNone = AppConstants.elevationNone;
  static const double elevationLow = AppConstants.elevationLow;
  static const double elevationMedium = AppConstants.elevationMedium;
  static const double elevationHigh = AppConstants.elevationHigh;
  static const double elevationHighest = AppConstants.elevationHighest;

  // ==========================================================================
  // Divider & Border
  // ==========================================================================

  static const double dividerThickness = 1;
  static const double dividerIndent = AppConstants.paddingMd;
  static const double borderWidth = 1;
  static const double borderWidthThick = 2;

  // ==========================================================================
  // Avatar & Image Sizes
  // ==========================================================================

  static const double avatarSizeXs = 24;
  static const double avatarSizeSm = 32;
  static const double avatarSizeMd = 48;
  static const double avatarSizeLg = 64;
  static const double avatarSizeXl = 96;
  static const double avatarSizeXxl = 128;

  static const double thumbnailSizeXs = 40;
  static const double thumbnailSizeSm = 60;
  static const double thumbnailSizeMd = 80;
  static const double thumbnailSizeLg = 120;
  static const double thumbnailSizeXl = 160;

  // ==========================================================================
  // Dialog & Bottom Sheet
  // ==========================================================================

  static const double dialogMaxWidth = 560;
  static const double dialogMinWidth = 280;
  static const double dialogPadding = AppConstants.paddingLg;
  static const double bottomSheetMaxHeight = 0.9; // 90% of screen height

  // ==========================================================================
  // Breakpoints (Responsive design)
  // ==========================================================================

  static const double breakpointMobile = 600;
  static const double breakpointTablet = 900;
  static const double breakpointDesktop = 1200;
  static const double breakpointLargeDesktop = 1800;

  // ==========================================================================
  // Grid & Layout
  // ==========================================================================

  static const double gridSpacing = AppConstants.paddingMd;
  static const double gridCrossAxisSpacing = AppConstants.paddingSm;
  static const double gridMainAxisSpacing = AppConstants.paddingSm;
  static const int gridCrossAxisCount = AppConstants.gridCrossAxisCount;
  static const double gridChildAspectRatio = AppConstants.gridChildAspectRatio;

  // ==========================================================================
  // Loading & Progress
  // ==========================================================================

  static const double progressIndicatorSize = 24;
  static const double progressIndicatorStrokeWidth = 3;
  static const double shimmerHeight = 16;

  // ==========================================================================
  // Chip & Badge
  // ==========================================================================

  static const double chipHeight = 32;
  static const double chipPaddingHorizontal = AppConstants.paddingSm;
  static const double badgeSize = 18;
  static const double badgeSizeSmall = 12;

  // ==========================================================================
  // Snackbar & Toast
  // ==========================================================================

  static const double snackbarMinWidth = 288;
  static const double snackbarMaxWidth = 600;
  static const double snackbarPadding = AppConstants.paddingMd;
  static const double snackbarBorderRadius = AppConstants.borderRadiusSm;
}
