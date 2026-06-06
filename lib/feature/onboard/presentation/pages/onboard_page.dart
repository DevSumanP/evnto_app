// ==============================================================================
// lib/feature/onboard/presentation/pages/onboard_page.dart
// First-run welcome screen. Shows the three sign-in options.
//
// The actual auth flows are wired up later; this is a stub that the splash
// can navigate to and that exposes the entry points. When a button is tapped
// it marks onboarding done and routes to LoginRoute.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/shared/widgets/buttons/primary_button.dart';
import 'package:tap_app/shared/widgets/buttons/secondary_button.dart';

import '../../../../core/di/core_injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

@RoutePage()
class OnBoardPage extends StatelessWidget {
  const OnBoardPage({super.key});

  Future<void> _continueWith(BuildContext context, String provider) async {
    await inject<StorageService>().setOnboardingDone();
    if (!context.mounted) return;
    context.router.push(const LoginRoute());
  }

  Future<void> _goToSignUp(BuildContext context) async {
    await inject<StorageService>().setOnboardingDone();
    if (!context.mounted) return;
    context.router.push(const SignUpRoute());
  }

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                Text(
                  'Discover events near you',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2Bold.copyWith(
                    color: AppColors.text500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Find concerts, food festivals and meetups. Buy tickets in seconds. Check in with a QR.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.text300,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Spacer(),
                PrimaryButton(
                  label: 'Continue with email',
                  onPressed: () => _continueWith(context, 'email'),
                  backgroundColor: AppColors.primary,
                ),
                const SizedBox(height: 12),
                SecondaryButton(
                  label: 'Continue with Google',
                  icon: Center(
                    child: SvgPicture.asset(
                      ImageConstants.google,
                      height: 18,
                      width: 18,
                    ),
                  ),
                  onPressed: () => _continueWith(context, 'google'),
                ),
                const SizedBox(height: 12),
                SecondaryButton(
                  label: 'Continue with Apple',
                  icon: Center(
                    child: SvgPicture.asset(
                      ImageConstants.apple,
                      height: 18,
                      width: 18,
                    ),
                  ),
                  onPressed: () => _continueWith(context, 'apple'),
                ),
                const SizedBox(height: 46),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                    children: [
                      TextSpan(text: "Don't have an account? "),
                      TextSpan(
                        text: 'Sign Up',
                        style: AppTextStyles.bodyRegular.copyWith(
                          color: AppColors.primarymain,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => _goToSignUp(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
