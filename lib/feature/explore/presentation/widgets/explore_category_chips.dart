// ==============================================================================
// lib/feature/explore/presentation/widgets/explore_category_chips.dart
// Horizontal category chips with icons and a leading "All". Single-select:
// "All" clears the category (null); tapping a category selects it.
// ==============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_app/core/constants/image_constants.dart';

import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

/// The categories events use (free-text on the backend, fixed set in the UI).
const List<String> kExploreCategories = <String>[
  'art',
  'music',
  'tech',
  'sports',
  'food',
];

String _iconFor(final String? category) {
  switch (category) {
    case 'art':
      return ImageConstants.arts;
    case 'music':
      return ImageConstants.music;
    case 'tech':
      return ImageConstants.tech;
    case 'sports':
      return ImageConstants.sports;
    case 'food':
      return ImageConstants.food;
    default:
      return ImageConstants.exploreAll; // "All"
  }
}

class ExploreCategoryChips extends StatelessWidget {
  const ExploreCategoryChips({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  /// Currently selected category, or null for "All".
  final String? selected;

  /// Called with the new category, or null for "All".
  final ValueChanged<String?> onSelected;

  @override
  Widget build(final BuildContext context) {
    // null is the leading "All" chip, then each category.
    final List<String?> items = <String?>[null, ...kExploreCategories];
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (_, final int i) {
          final String? category = items[i];
          final bool isOn = selected == category;
          return _Chip(
            label: category == null ? 'All' : _label(category),
            icon: _iconFor(category),
            selected: isOn,
            onTap: () => onSelected(category),
          );
        },
      ),
    );
  }

  String _label(final String c) => c[0].toUpperCase() + c.substring(1);
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    final Color fg = selected ? AppColors.white : AppColors.text500;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: selected ? _kAccentOrange : AppColors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? _kAccentOrange : AppColors.grey200,
          ),
        ),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              icon,
              height: 14,
              width: 14,
              color: selected ? fg : AppColors.text500,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.bodyRegular.copyWith(
                color: fg,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
