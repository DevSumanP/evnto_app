import 'package:flutter/material.dart';

import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/home/domain/entities/home_section.dart';

/// Cold-start welcome block (newcomer). Clean soft-surface card with an ink
/// title, muted subtitle, and a single Rausch pill CTA — no gradient.
class HeroSectionWidget extends StatelessWidget {
  const HeroSectionWidget({required this.section, super.key});

  final HeroSection section;

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            section.title,
            style: AppTextStyles.bodyXlBold.copyWith(color: AppColors.ink),
          ),
          if (section.subtitle != null) ...<Widget>[
            const SizedBox(height: 6),
            Text(
              section.subtitle!,
              style: AppTextStyles.bodySmallRegular.copyWith(
                color: AppColors.muted,
                height: 1.45,
              ),
            ),
          ],
          if (section.ctaLabel != null) ...<Widget>[
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 11,
                ),
                child: Text(
                  section.ctaLabel!,
                  style: AppTextStyles.bodySmallBold.copyWith(
                    color: AppColors.canvas,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
