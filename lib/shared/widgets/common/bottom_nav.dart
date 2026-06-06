import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_shadows.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

/// A single item in the bottom navigation bar.
class NavItem extends StatelessWidget {
  final String activeIcon;
  final String inactiveIcon;
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const NavItem({
    super.key,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.6,
        child: SizedBox(
          width: 72,
          height: 72,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                isActive ? activeIcon : inactiveIcon,
                height: 24,
                width: 24,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style:
                    (isActive
                            ? AppTextStyles.captionBold
                            : AppTextStyles.captionRegular)
                        .copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Pill-shaped bottom navigation bar.
class AppBottomNav extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int>? onTabChanged;

  const AppBottomNav({super.key, this.activeIndex = 0, this.onTabChanged});

  static const _items = [
    // (
    //   activeIcon: ImageConstants.homeActive,
    //   inactiveIcon: ImageConstants.homeInactive,
    //   label: 'Home',
    // ),
    // (
    //   activeIcon: ImageConstants.publicationActive,
    //   inactiveIcon: ImageConstants.publicationInactive,
    //   label: 'Publications',
    // ),
    // (
    //   activeIcon: ImageConstants.newsActive,
    //   inactiveIcon: ImageConstants.newsInactive,
    //   label: 'News',
    // ),
    // (
    //   activeIcon: ImageConstants.eventActive,
    //   inactiveIcon: ImageConstants.eventInactive,
    //   label: 'Events',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 72,
      decoration: BoxDecoration(
        color: AppColors.primary500,
        borderRadius: BorderRadius.circular(130),
        boxShadow: AppShadows.elevation05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          return NavItem(
            activeIcon: item.activeIcon,
            inactiveIcon: item.inactiveIcon,
            label: item.label,
            isActive: i == activeIndex,
            onTap: () => onTabChanged?.call(i),
          );
        }),
      ),
    );
  }
}
