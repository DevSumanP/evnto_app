import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

import '../../../core/constants/image_constants.dart';
import '../buttons/primary_button.dart';

// ─── SuccessScreen ────────────────────────────────────────────────────────────

/// A fully dynamic success / confirmation screen.
///
/// Parameters:
///   [icon]            – Widget painted inside the 64 × 64 icon frame.
///                       Defaults to the blue document-check icon from the spec.
///   [title]           – Bold heading text.
///   [subtitle]        – Descriptive body text beneath the title.
///   [buttonLabel]     – CTA button label.
///   [onButtonPressed] – Callback fired when the CTA is tapped.
///   [backgroundColor] – Screen background (defaults to #F1F5F9).

@RoutePage()
class SuccessPage extends StatelessWidget {
  const SuccessPage({
    super.key,
    this.icon,
    this.title = 'Successfully Submitted',
    this.subtitle =
        'Your request has been successfully submitted.\nYou will be notified once it is reviewed.',
    this.buttonLabel = 'Done',
    required this.onButtonPressed,
    this.backgroundColor = const Color(0xFFF1F5F9),
  });

  final Widget? icon;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback onButtonPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // ── Centre content ──────────────────────────────────────────────
            Align(
              alignment: const Alignment(0, -0.08), // slightly above centre
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon frame 64 × 64
                    SizedBox(
                      width: 64,
                      height: 64,
                      child: icon ?? Image.asset(ImageConstants.appIcon),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    Text(
                      title,
                      style: AppTextStyles.h4Bold,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 8),

                    // Subtitle
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmallRegular,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // ── Bottom CTA button ───────────────────────────────────────────
            Positioned(
              left: 16,
              right: 16,
              bottom: 32,
              child: PrimaryButton(
                height: 48,
                backgroundColor: AppColors.primary500,
                label: buttonLabel,
                onPressed: onButtonPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
