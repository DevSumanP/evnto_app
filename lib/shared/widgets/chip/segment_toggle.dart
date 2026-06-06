import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_shadows.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

class SegmentToggle extends StatelessWidget {
  const SegmentToggle({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onChanged,
  }) : assert(labels.length == 2, 'SegmentToggle only supports 2 tabs');

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: AppShadows.shadow13,
      ),
      child: Row(
        children: List.generate(labels.length, (i) {
          final isActive = selectedIndex == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                height: 48,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary500 : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  labels[i],
                  style: isActive
                      ? AppTextStyles.bodySmallBold.copyWith(
                          color: AppColors.white,
                        )
                      : AppTextStyles.bodySmallRegular.copyWith(
                          color: AppColors.text500,
                        ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
