import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/home/domain/entities/home_section.dart';

import '../../blocs/home_layout_bloc.dart';

/// Interest chips (newcomer), Airbnb category-strip style: pill chips that are
/// white with a hairline border when off and Rausch-filled when on. Each tap
/// persists the new set via the bloc, which re-resolves the layout.
class InterestPickerSectionWidget extends StatelessWidget {
  const InterestPickerSectionWidget({required this.section, super.key});

  final InterestPickerSection section;

  static const List<String> _defaultOptions = <String>[
    'Music',
    'Art',
    'Tech',
    'Sports',
    'Food',
  ];

  @override
  Widget build(final BuildContext context) {
    final List<String> options = section.options.isNotEmpty
        ? section.options
        : _defaultOptions;
    final Set<String> selected = section.selected.toSet();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (section.title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
            child: Text(
              section.title,
              style: AppTextStyles.bodyLargeBold.copyWith(color: AppColors.ink),
            ),
          ),
        SizedBox(
          height: 24,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: options.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (final BuildContext context, final int index) {
              final String option = options[index];
              final bool isOn = selected.contains(option);
              return _InterestChip(
                label: option,
                selected: isOn,
                onTap: () {
                  final Set<String> next = Set<String>.of(selected);
                  if (isOn) {
                    next.remove(option);
                  } else {
                    next.add(option);
                  }
                  context.read<HomeLayoutBloc>().add(
                    HomeLayoutEvent.interestsChanged(next.toList()),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: selected ? AppColors.primary : AppColors.canvas,
      shape: StadiumBorder(
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.hairline,
        ),
      ),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: Text(
          label,
          style: AppTextStyles.bodySmallMedium.copyWith(
            color: selected ? AppColors.white : AppColors.ink,
          ),
        ),
      ),
    );
  }
}
