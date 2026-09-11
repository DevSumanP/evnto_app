import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/home/domain/entities/home_section.dart';
import 'package:tap_app/feature/home/domain/entities/section_type.dart';
import 'package:tap_app/shared/widgets/buttons/icon_button.dart';

import '../cards/event_cards.dart';

/// Horizontal scroller of event cards. `popular` → image-top cards,
/// `upcoming` → image-left cards. Renders nothing when empty.
class RailSectionWidget extends StatelessWidget {
  const RailSectionWidget({required this.section, super.key});

  final RailSection section;

  @override
  Widget build(final BuildContext context) {
    if (section.items.isEmpty) return const SizedBox.shrink();

    // Airbnb-style sizing: photo-top cards, 4:3 image ratio.
    // popular → narrower grid-like cards; upcoming → slightly wider.
    final bool isPopular = section.style == CardStyle.popular;
    final double cardWidth = isPopular ? 175 : 175;
    final double height = isPopular ? 217 : 217;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _RailHeader(title: section.title),
        SizedBox(
          height: height,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: section.items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (final BuildContext context, final int index) {
              final event = section.items[index];
              return SizedBox(
                width: cardWidth,
                // PopularCard uses Expanded for photo, so wrap in fixed SizedBox.
                child: PopularCard(event: event),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RailHeader extends StatelessWidget {
  const _RailHeader({required this.title});

  final String title;

  @override
  Widget build(final BuildContext context) {
    if (title.isEmpty) return const SizedBox(height: 8);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyBold.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.ink,
            ),
          ),
          CustomIconButton(
            onTap: () {},
            elevation: 0,
            backgroundColor: AppColors.surfaceStrong,
            icon: Icons.arrow_forward,
            iconSize: 16,
            size: 30,
          ),
        ],
      ),
    );
  }
}
