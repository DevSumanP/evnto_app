// ==============================================================================
// lib/feature/explore/presentation/widgets/explore_search_header.dart
// Search bar with a location pill on the right (tap to change city) and a
// small filter button that carries a badge for active refinements.
// ==============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

class ExploreSearchHeader extends StatelessWidget {
  const ExploreSearchHeader({
    required this.controller,
    required this.city,
    required this.activeFilterCount,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
    required this.onLocationTap,
    required this.onFilterTap,
    super.key,
  });

  final TextEditingController controller;
  final String? city;
  final int activeFilterCount;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;
  final VoidCallback onLocationTap;
  final VoidCallback onFilterTap;

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 52,
            padding: const EdgeInsets.fromLTRB(16, 6, 6, 6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: AppColors.grey200),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  ImageConstants.search,
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.text300,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onChanged: onChanged,
                    onSubmitted: onSubmitted,
                    textInputAction: TextInputAction.search,
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.text500,
                    ),
                    decoration: InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: 'Search all events',
                      hintStyle: AppTextStyles.bodyRegular.copyWith(
                        color: AppColors.text300,
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller,
                  builder: (_, final TextEditingValue value, _) {
                    if (value.text.isEmpty) return const SizedBox(width: 6);
                    return GestureDetector(
                      onTap: onClear,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: AppColors.text300,
                        ),
                      ),
                    );
                  },
                ),
                _LocationPill(city: city, onTap: onLocationTap),
              ],
            ),
          ),
        ),
        // const SizedBox(width: 10),
        // _FilterButton(count: activeFilterCount, onTap: onFilterTap),
      ],
    );
  }
}

class _LocationPill extends StatelessWidget {
  const _LocationPill({required this.city, required this.onTap});

  final String? city;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.text20.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Center(
                child: SvgPicture.asset(
                  ImageConstants.locationFilled,
                  height: 16,
                  width: 16,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(width: 4),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 86),
              child: Text(
                city?.trim().isNotEmpty == true ? city! : 'Kathamndu',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Used by the filter button in the search header (currently disabled, see the
// commented usage above). Suppress the unused warning until it is re-enabled.
// ignore: unused_element
class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          color: count > 0 ? _kAccentOrange : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Icon(
              Icons.tune,
              size: 22,
              color: count > 0 ? AppColors.white : AppColors.text500,
            ),
            if (count > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$count',
                    style: AppTextStyles.captionBold.copyWith(
                      color: _kAccentOrange,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
