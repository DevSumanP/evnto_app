import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/shared/widgets/buttons/back_button.dart';

/// A title bar with a back button and a title.
/// Used in screens without a standard AppBar.
class CustomTitleBar extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;
  final bool showActionButton;
  final Widget actionButton;

  const CustomTitleBar({
    super.key,
    required this.title,
    this.onBackTap,
    this.showActionButton = false,
    this.actionButton = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomBackButton(onTap: onBackTap ?? () => context.router.back()),
            if (showActionButton) ...[actionButton],
          ],
        ),
        const SizedBox(height: 16),
        Text(title, style: AppTextStyles.h4Bold),
      ],
    );
  }
}
