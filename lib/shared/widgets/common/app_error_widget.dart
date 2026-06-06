import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';

/// User-friendly error widget shown in production/staging when a build error occurs.
/// Replaces the default Flutter red screen.
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    required this.details,
    super.key,
    this.isDevelopment = false,
  });

  final FlutterErrorDetails details;
  final bool isDevelopment;

  @override
  Widget build(final BuildContext context) {
    if (isDevelopment) {
      // In development, show the standard Flutter error screen
      return ErrorWidget(details.exception);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.errorLight,
                  size: 80,
                ),
                const SizedBox(height: 24),
                Text(
                  'Oops! Something went wrong',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'We have encountered an unexpected error. Our team has been notified, and we are working to fix it.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.grey700),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to root or restart
                    Navigator.of(
                      context,
                    ).popUntil((final route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryLight,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Go Back Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
