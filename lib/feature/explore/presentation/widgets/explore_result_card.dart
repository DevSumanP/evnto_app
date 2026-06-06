// ==============================================================================
// lib/feature/explore/presentation/widgets/explore_result_card.dart
// Search-result card for the Explore list. Image-left layout with a date
// badge, title, location, price, and the shared favorite heart. Mirrors the
// favorites card so the two surfaces look the same.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/favorite/presentation/widgets/favorite_button.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

/// 'FREE' when the event is free, `Rs <amount>` when we know the minimum
/// price, else '—'.
String _priceLabel(final Event event) {
  if (event.isFree) return 'FREE';
  final int? minPaisa = event.minPricePaisa;
  if (minPaisa == null) return '—';
  return 'Rs ${(minPaisa / 100).round()}';
}

class ExploreResultCard extends StatelessWidget {
  const ExploreResultCard({required this.event, super.key});

  final Event event;

  static const double _height = 112;

  @override
  Widget build(final BuildContext context) {
    final bool isPast = (event.endsAt ?? event.startsAt).isBefore(
      DateTime.now(),
    );
    return SizedBox(
      height: _height,
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.router.push(EventDetailRoute(eventId: event.id)),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  width: 96,
                  height: 96,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _CoverImage(url: event.heroImageUrl),
                      ),
                      Positioned(
                        top: 6,
                        left: 6,
                        child: _DateBadge(date: event.startsAt),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            if (isPast) ...<Widget>[
                              const _EndedPill(),
                              const SizedBox(width: 6),
                            ],
                            Expanded(
                              child: Text(
                                event.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.text500,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: <Widget>[
                            SvgPicture.asset(
                              ImageConstants.locationFilled,
                              height: 14,
                              width: 14,
                              colorFilter: const ColorFilter.mode(
                                AppColors.text300,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                event.venueCity ??
                                    event.venueName ??
                                    event.venueAddress ??
                                    'No address',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyRegular.copyWith(
                                  fontSize: 13,
                                  color: AppColors.text300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _priceLabel(event),
                              style: AppTextStyles.bodySmallBold.copyWith(
                                color: _kAccentOrange,
                              ),
                            ),
                            const Spacer(),
                            FavoriteButton(
                              eventId: event.id,
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.url});

  final String? url;

  @override
  Widget build(final BuildContext context) {
    final String? src = url;
    if (src == null || src.isEmpty) {
      return const ColoredBox(color: AppColors.grey200);
    }
    return AppNetworkImage(
      src,
      fit: BoxFit.cover,
      placeholder: const ColoredBox(color: AppColors.grey100),
      errorWidget: const ColoredBox(color: AppColors.grey200),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date});

  final DateTime date;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 6,
            offset: Offset(0, 2),
            color: Color(0x1F000000),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            DateFormat('dd').format(date),
            style: AppTextStyles.bodyBold.copyWith(
              color: AppColors.text500,
              fontSize: 16,
              height: 1.1,
            ),
          ),
          Text(
            DateFormat('MMM').format(date),
            style: AppTextStyles.captionRegular.copyWith(
              color: AppColors.text300,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _EndedPill extends StatelessWidget {
  const _EndedPill();

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.text10,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        'Ended',
        style: AppTextStyles.captionBold.copyWith(color: AppColors.text300),
      ),
    );
  }
}
