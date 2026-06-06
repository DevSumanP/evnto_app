import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/shared/widgets/buttons/primary_button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    this.message = 'Oops! Something went wrong',
    this.description = 'We have encountered an unexpected error.',
    this.icon = Icons.error_outline_rounded,
    this.onRetry,
    this.buttonText = 'Try Again',
  });

  final String message;
  final String description;
  final IconData icon;
  final VoidCallback? onRetry;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.errorLight, size: 80),
            const SizedBox(height: 24),
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.grey700),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 32),
              PrimaryButton(label: buttonText, onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }
}
