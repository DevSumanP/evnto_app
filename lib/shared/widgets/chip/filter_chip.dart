import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_shadows.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

/// A pill-shaped filter/tab button used in filter chip rows across the app.
///
/// [label]      — display text
/// [isSelected] — when true uses [AppColors.primary500] background, else white
/// [onTap]      — tap callback
class FilterChipButton extends StatelessWidget {
  const FilterChipButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary500 : AppColors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: isSelected ? null : AppShadows.soft,
        ),
        child: Text(
          label,
          style: isSelected
              ? AppTextStyles.bodySmallMedium.copyWith(color: AppColors.white)
              : AppTextStyles.bodySmallMedium.copyWith(
                  color: AppColors.text500,
                ),
        ),
      ),
    );
  }
}
