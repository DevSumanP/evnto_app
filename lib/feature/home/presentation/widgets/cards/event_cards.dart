// ==============================================================================
// lib/feature/home/presentation/widgets/cards/event_cards.dart
// Airbnb-style event cards: photo-first, no container/shadow on the card itself,
// "Guest favourite" white pill badge top-left, wishlist heart top-right (Rausch
// when saved), and clean muted meta text below. Used by both the legacy Home
// and the SDUI rails/lists.
//
//   PopularCard    — photo on top, 4:3 image, title + meta below (rail/grid)
//   UpcomingCard   — same as PopularCard, used for upcoming rail
//   SuggestionCard — horizontal layout: photo left, meta right (list section)
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:tap_app/core/di/core_injection.dart';
import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/favorite/presentation/blocs/favorites_cubit.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

// ─── Public helpers (used by rail_section, list_section, home_page) ──────────

/// Best location string: `City, Country` → `City` → venue name → `—`.
String eventLocationLabel(final Event event) {
  final String city = (event.venueCity ?? '').trim();
  final String country = (event.venueCountry ?? '').trim();
  if (city.isNotEmpty && country.isNotEmpty) return '$city, $country';
  if (city.isNotEmpty) return city;
  final String name = (event.venueName ?? '').trim();
  if (name.isNotEmpty) return name;
  return '—';
}

/// `Free` | `Rs {amount}` | `—`.
String eventPriceLabel(final Event event) {
  if (event.isFree) return 'Free';
  final int? minPaisa = event.minPricePaisa;
  if (minPaisa == null) return '—';
  return 'Rs ${(minPaisa / 100).round()}';
}

// ─── PopularCard (Airbnb photo-top, used for Popular Now / Picked for you) ───

/// Full Airbnb-style card: large rounded photo, "Guest favourite" badge,
/// heart, then title + location · date + price below. No outer container.
class PopularCard extends StatelessWidget {
  const PopularCard({required this.event, super.key});

  final Event event;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(EventDetailRoute(eventId: event.id)),
      behavior: HitTestBehavior.opaque,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ── Photo ──────────────────────────────────────────────────────────
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  _CoverImage(url: event.heroImageUrl),
                  // "Guest favourite" badge top-left
                  if (event.isFeatured)
                    const Positioned(
                      top: 12,
                      left: 12,
                      child: _GuestFavouriteBadge(),
                    ),
                  // Heart top-right
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _FavoriteHeart(eventId: event.id),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          // ── Title ──────────────────────────────────────────────────────────
          Text(
            event.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySmallBold.copyWith(
              color: AppColors.ink,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          // ── Location · date ────────────────────────────────────────────────
          Text(
            '${eventLocationLabel(event)} · ${DateFormat('MMM d').format(event.startsAt)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.captionRegular.copyWith(
              color: AppColors.muted,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 2),
          // ── Price line ─────────────────────────────────────────────────────
          RichText(
            text: TextSpan(
              style: AppTextStyles.captionRegular.copyWith(
                color: AppColors.ink,
                fontSize: 13,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: eventPriceLabel(event),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                if (!event.isFree)
                  const TextSpan(
                    text: ' · per person',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── UpcomingCard — same Airbnb photo-top style, used for upcoming rail ───────

class UpcomingCard extends StatelessWidget {
  const UpcomingCard({required this.event, super.key});

  final Event event;

  @override
  Widget build(final BuildContext context) =>
      PopularCard(event: event, key: key);
}

// ─── SuggestionCard — horizontal: photo left, Airbnb meta right ──────────────

class SuggestionCard extends StatelessWidget {
  const SuggestionCard({required this.event, super.key});

  final Event event;

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () => context.router.push(EventDetailRoute(eventId: event.id)),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Photo square
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  _CoverImage(url: event.heroImageUrl),
                  if (event.isFeatured)
                    const Positioned(
                      top: 8,
                      left: 8,
                      child: _GuestFavouriteBadge(compact: true),
                    ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: _FavoriteHeart(eventId: event.id, size: 20),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Meta
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmallBold.copyWith(
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySmallBold.copyWith(
                    color: AppColors.ink,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                Text(
                  eventLocationLabel(event),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.captionRegular.copyWith(
                    color: AppColors.muted,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  DateFormat('EEE, MMM d · h:mm a').format(event.startsAt),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.captionRegular.copyWith(
                    color: AppColors.muted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.captionRegular.copyWith(
                      color: AppColors.ink,
                      fontSize: 13,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: eventPriceLabel(event),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      if (!event.isFree)
                        const TextSpan(
                          text: ' · per person',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6A6A6A),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Private building blocks ──────────────────────────────────────────────────

class _CoverImage extends StatelessWidget {
  const _CoverImage({required this.url});

  final String? url;

  @override
  Widget build(final BuildContext context) {
    final String? src = url;
    if (src == null || src.isEmpty) {
      return ColoredBox(
        color: AppColors.surfaceStrong,
        child: Center(
          child: Icon(
            Icons.image_outlined,
            color: AppColors.muted.withValues(alpha: 0.5),
            size: 32,
          ),
        ),
      );
    }
    return AppNetworkImage(
      src,
      fit: BoxFit.cover,
      placeholder: const ColoredBox(color: AppColors.surfaceSoft),
      errorWidget: ColoredBox(
        color: AppColors.surfaceStrong,
        child: Center(
          child: Icon(
            Icons.broken_image_outlined,
            color: AppColors.muted.withValues(alpha: 0.5),
            size: 32,
          ),
        ),
      ),
    );
  }
}

/// Airbnb "Guest favourite" white pill badge floating over the photo.
class _GuestFavouriteBadge extends StatelessWidget {
  const _GuestFavouriteBadge({this.compact = false});

  final bool compact;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 10,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(999),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        'Guest favourite',
        style: AppTextStyles.labelSmall.copyWith(
          color: AppColors.ink,
          fontSize: compact ? 9 : 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Wishlist heart — Rausch (#FF385C) when saved, white outline when not.
class _FavoriteHeart extends StatelessWidget {
  const _FavoriteHeart({required this.eventId, this.size = 26});

  final String eventId;
  final double size;

  @override
  Widget build(final BuildContext context) {
    final FavoritesCubit favorites = inject<FavoritesCubit>();
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      bloc: favorites,
      builder: (final BuildContext context, final FavoritesState state) {
        final bool saved = state.contains(eventId);
        return GestureDetector(
          onTap: () => favorites.toggle(eventId),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(
              saved ? Icons.favorite : Icons.favorite_border,
              size: size,
              color: saved ? AppColors.rausch : AppColors.canvas,
              shadows: <Shadow>[
                Shadow(
                  color: AppColors.black.withValues(alpha: 0.3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
