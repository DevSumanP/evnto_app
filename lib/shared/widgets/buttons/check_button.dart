// ─── Back Button ─────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';

class CheckButton extends StatelessWidget {
  final VoidCallback onTap;
  const CheckButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primarymain,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: AppColors.primarymain.withValues(alpha: 0.04),
              blurRadius: 2,
            ),
            BoxShadow(
              color: AppColors.primarymain.withValues(alpha: 0.16),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(Icons.check, color: AppColors.white, size: 20),
      ),
    );
  }
}
