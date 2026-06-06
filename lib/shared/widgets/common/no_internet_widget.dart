import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/shared/widgets/common/custom_error_widget.dart';

/// Full-screen no-internet route.
///
/// Doubles as the page used by `NoInternetRoute` and as an embeddable widget
/// for any feature that wants to render the same message inline. When used
/// as a route (no [onRetry] passed) it pops back to the splash so startup
/// checks rerun.
@RoutePage(name: 'NoInternetRoute')
class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key, this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        // Status bar
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,

        // Bottom navigation bar (Android)
        systemNavigationBarColor: AppColors.white,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: CustomErrorWidget(
            message: 'No Internet Connection',
            description: 'Please check your network settings and try again.',
            icon: Icons.wifi_off_rounded,
            onRetry: onRetry ?? () => _defaultRetry(context),
          ),
        ),
      ),
    );
  }

  void _defaultRetry(BuildContext context) {
    // Pop back to whatever pushed us. The splash, if reached, will rerun its
    // startup checks. If there is nothing to pop (deep link case), just stay.
    if (context.router.canPop()) {
      context.router.maybePop();
    }
  }
}
