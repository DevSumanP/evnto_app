// ==============================================================================
// lib/feature/explore/presentation/widgets/explore_join_card.dart
// Bottom-sheet card for the map view: thumbnail with date badge, title,
// location, and a "Join" button. Card tap and Join both open the event.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

class ExploreJoinCard extends StatelessWidget {
  const ExploreJoinCard({required this.event, super.key});

  final Event event;

  void _open(final BuildContext context) =>
      context.router.push(EventDetailRoute(eventId: event.id));

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _open(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 72,
                height: 72,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _Cover(url: event.heroImageUrl),
                    ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: _DateBadge(date: event.startsAt),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      event.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.text500,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: AppColors.text300,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            event.venueName ??
                                event.venueCity ??
                                event.venueAddress ??
                                'No address',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.captionRegular.copyWith(
                              color: AppColors.text300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _JoinButton(onTap: () => _open(context)),
            ],
          ),
        ),
      ),
    );
  }
}

class _JoinButton extends StatelessWidget {
  const _JoinButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: _kAccentOrange,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Join',
          style: AppTextStyles.bodySmallBold.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover({required this.url});

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
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(9),
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
              fontSize: 14,
              height: 1.0,
            ),
          ),
          Text(
            DateFormat('MMM').format(date),
            style: AppTextStyles.captionRegular.copyWith(
              color: AppColors.text300,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
