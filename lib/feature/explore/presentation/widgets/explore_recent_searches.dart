// ==============================================================================
// lib/feature/explore/presentation/widgets/explore_recent_searches.dart
// Recent-search chips shown above the result list while the query box is
// empty. Tapping a chip re-runs that search; "Clear" wipes the list.
// ==============================================================================

import 'package:flutter/material.dart';

import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

class ExploreRecentSearches extends StatelessWidget {
  const ExploreRecentSearches({
    required this.terms,
    required this.onTap,
    required this.onClear,
    super.key,
  });

  final List<String> terms;
  final ValueChanged<String> onTap;
  final VoidCallback onClear;

  @override
  Widget build(final BuildContext context) {
    if (terms.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Recent searches',
              style: AppTextStyles.captionBold.copyWith(
                color: AppColors.text300,
                letterSpacing: 0.4,
              ),
            ),
            GestureDetector(
              onTap: onClear,
              child: Text(
                'Clear',
                style: AppTextStyles.captionBold.copyWith(
                  color: AppColors.text300,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: terms
              .map(
                (final String term) => GestureDetector(
                  onTap: () => onTap(term),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Icon(
                          Icons.history,
                          size: 14,
                          color: AppColors.text300,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          term,
                          style: AppTextStyles.bodySmallBold.copyWith(
                            color: AppColors.text500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
