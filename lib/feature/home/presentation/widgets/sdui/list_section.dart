import 'package:flutter/material.dart';

import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/home/domain/entities/home_section.dart';

import '../../../../../shared/widgets/buttons/icon_button.dart';
import '../cards/event_cards.dart';

/// Vertical list of event cards (e.g. "Suggestion for you"). Short, fully
/// hydrated lists, so a plain Column is fine. Renders nothing when empty.
class ListSectionWidget extends StatelessWidget {
  const ListSectionWidget({required this.section, super.key});

  final ListSection section;

  @override
  Widget build(final BuildContext context) {
    if (section.items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (section.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  section.title,
                  style: AppTextStyles.bodyBold.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                CustomIconButton(
                  onTap: () {},
                  elevation: 0,
                  backgroundColor: AppColors.primary50,
                  icon: Icons.arrow_forward,
                  iconSize: 16,
                  size: 30,
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              for (
                int i = 0;
                i < section.items.take(2).length;
                i++
              ) ...<Widget>[
                if (i > 0) const SizedBox(height: 16),
                SuggestionCard(event: section.items[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
