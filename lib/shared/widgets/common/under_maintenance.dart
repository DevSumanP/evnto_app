import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/image_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_style.dart';

@RoutePage()
class UnderMaintenancePage extends StatelessWidget {
  const UnderMaintenancePage({super.key});

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
        backgroundColor: Color(0xffF1F5F9),
        body: SafeArea(
          child: Stack(
            children: [
              /// Centered content
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Illustration
                      SizedBox(
                        width: 374,
                        height: 234,
                        child: Image.asset(
                          ImageConstants.appIcon,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// Text block
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Title
                          Text(
                            "We'll Be Back Soon",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.h4Bold.copyWith(
                              color: AppColors.text500,
                            ),
                          ),

                          const SizedBox(height: 8),

                          /// Subtitle
                          SizedBox(
                            width: 308,
                            child: Text(
                              'Our system is temporarily unavailable while we fix an issue. Thank you for your patience.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodySmallRegular.copyWith(
                                color: AppColors.text500, // #0F172A
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// Bottom CTA Button
              Positioned(
                left: 14,
                right: 14,
                bottom: 32,
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary500, // #234B82
                      foregroundColor: AppColors.white,
                      elevation: 2,
                      shadowColor: const Color(0x29706960),
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    child: Text(
                      'Contact Support',
                      style: AppTextStyles.bodySmallMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
