import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/di/core_injection.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/feature/favorite/presentation/blocs/favorites_cubit.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    required this.eventId,
    super.key,
    this.size = 22,
    this.padding = const EdgeInsets.all(8),
    this.inactiveColor,
  });

  final String eventId;
  final double size;
  final EdgeInsetsGeometry padding;

  /// Color of the outline heart. Defaults to AppColors.text500.
  final Color? inactiveColor;

  @override
  Widget build(final BuildContext context) {
    // Provide the singleton at this scope so the widget works anywhere,
    // even when no FavoritesCubit ancestor is already in the tree.
    return BlocProvider<FavoritesCubit>.value(
      value: inject<FavoritesCubit>(),
      child: _FavoriteIcon(
        eventId: eventId,
        size: size,
        padding: padding,
        inactiveColor: inactiveColor ?? AppColors.text500,
      ),
    );
  }
}

class _FavoriteIcon extends StatelessWidget {
  const _FavoriteIcon({
    required this.eventId,
    required this.size,
    required this.padding,
    required this.inactiveColor,
  });

  final String eventId;
  final double size;
  final EdgeInsetsGeometry padding;
  final Color inactiveColor;

  @override
  Widget build(final BuildContext context) {
    final bool favorited = context.select<FavoritesCubit, bool>(
      (c) => c.state.contains(eventId),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: () => context.read<FavoritesCubit>().toggle(eventId),
        child: Padding(
          padding: padding,
          child: SvgPicture.asset(
            favorited ? ImageConstants.heartFilled : ImageConstants.heart,
            height: size,
            width: size,
            colorFilter: ColorFilter.mode(
              favorited ? _kAccentOrange : inactiveColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
