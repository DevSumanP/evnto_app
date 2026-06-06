import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/di/core_injection.dart';
import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/favorite/presentation/blocs/favorites_list_cubit.dart';
import 'package:tap_app/feature/favorite/presentation/widgets/favorite_button.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

@RoutePage()
class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<FavoritesListCubit>(
      create: (_) => inject<FavoritesListCubit>()..load(),
      child: const _FavoritesView(),
    );
  }
}

class _FavoritesView extends StatelessWidget {
  const _FavoritesView();

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocBuilder<FavoritesListCubit, FavoritesListState>(
          builder:
              (final BuildContext context, final FavoritesListState state) {
                return Column(
                  children: <Widget>[
                    _TopBar(count: state.hasLoaded ? state.items.length : null),
                    Expanded(
                      child: RefreshIndicator(
                        color: _kAccentOrange,
                        onRefresh: () =>
                            context.read<FavoritesListCubit>().refresh(),
                        child: _Body(state: state),
                      ),
                    ),
                  ],
                );
              },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.state});

  final FavoritesListState state;

  @override
  Widget build(final BuildContext context) {
    // Only take over the whole screen on the very first load. During a
    // pull-to-refresh the items are still in state, so we keep showing the
    // list (the RefreshIndicator draws its own spinner) instead of blanking it.
    final bool firstLoad =
        (state.isLoading || state.status == FavoritesListStatus.idle) &&
        state.items.isEmpty;
    if (firstLoad) {
      return const Center(
        child: CircularProgressIndicator(color: _kAccentOrange),
      );
    }
    if (state.hasFailed) {
      return _ErrorView(
        message: state.error,
        onRetry: () => context.read<FavoritesListCubit>().load(),
      );
    }
    if (state.isEmpty) {
      return const _EmptyView();
    }

    final List<_Row> rows = _buildRows(state.items);

    // The outer RefreshIndicator in _FavoritesView handles pull-to-refresh,
    // so we just return the scrollable directly.
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      itemCount: rows.length,
      separatorBuilder: (final BuildContext _, final int i) {
        final _Row next = rows[i + 1];
        // No gap before a date header — it brings its own top padding.
        if (next is _HeaderRow) return const SizedBox.shrink();
        return const SizedBox(height: 12);
      },
      itemBuilder: (final BuildContext _, final int i) {
        final _Row row = rows[i];
        if (row is _HeaderRow) {
          return _DateHeader(date: row.date);
        }
        final _EventRow er = row as _EventRow;
        return _FavoriteCard(event: er.event);
      },
    );
  }
}

// ─── Top bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({this.count});

  /// Total saved events, when known. Hidden while loading so the chip does
  /// not flash a stale value.
  final int? count;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Your saved events',
                  style: AppTextStyles.captionRegular.copyWith(
                    color: AppColors.text300,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Favorites',
                  style: AppTextStyles.h4Bold.copyWith(
                    color: AppColors.text500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          if (count != null && count! > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.text10,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '$count saved',
                style: AppTextStyles.captionBold.copyWith(
                  color: AppColors.text500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Grouping ────────────────────────────────────────────────────────────────

sealed class _Row {
  const _Row();
}

class _HeaderRow extends _Row {
  const _HeaderRow(this.date);
  final DateTime date;
}

class _EventRow extends _Row {
  const _EventRow(this.event);
  final Event event;
}

/// Group [events] by calendar day of their start time, then flatten to a
/// header-row + event-rows list. Days are ascending (soonest first); inside
/// each day events are ordered by start time ascending too.
List<_Row> _buildRows(final List<Event> events) {
  final Map<DateTime, List<Event>> byDay = <DateTime, List<Event>>{};
  for (final Event e in events) {
    final DateTime day = DateTime(
      e.startsAt.year,
      e.startsAt.month,
      e.startsAt.day,
    );
    (byDay[day] ??= <Event>[]).add(e);
  }
  final List<DateTime> days = byDay.keys.toList()..sort();
  final List<_Row> out = <_Row>[];
  for (final DateTime day in days) {
    out.add(_HeaderRow(day));
    final List<Event> dayEvents = byDay[day]!
      ..sort((a, b) => a.startsAt.compareTo(b.startsAt));
    for (final Event e in dayEvents) {
      out.add(_EventRow(e));
    }
  }
  return out;
}

// ─── Day header ─────────────────────────────────────────────────────────────

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.date});

  final DateTime date;

  @override
  Widget build(final BuildContext context) {
    // "Tue, March 28"
    final String label = DateFormat('EEE, MMMM d').format(date);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
      child: Row(
        children: [
          SvgPicture.asset(
            ImageConstants.calendar,
            color: AppColors.text300,
            height: 20,
            width: 20,
          ),
          SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.bodyBold.copyWith(color: AppColors.text500),
          ),
        ],
      ),
    );
  }
}

// ─── Card (matches home upcoming card; Join swapped for the heart) ──────────

class _FavoriteCard extends StatelessWidget {
  const _FavoriteCard({required this.event});

  final Event event;

  static const double _height = 112;

  @override
  Widget build(final BuildContext context) {
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
                        event.description != null
                            ? Text(
                                event.description!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.captionRegular.copyWith(
                                  color: AppColors.text500,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : SizedBox.shrink(),
                        const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Row(
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
                                  Flexible(
                                    child: Text(
                                      event.venueAddress ??
                                          event.venueName ??
                                          'No address',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodyRegular.copyWith(
                                        fontSize: 14,
                                        color: AppColors.text300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
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

// ─── Card sub-widgets (mirrors home_page private helpers) ───────────────────

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

// ─── Empty + error views ────────────────────────────────────────────────────

/// Wraps non-scrollable content in a scroll view so the outer
/// RefreshIndicator can detect the pull gesture even when the body is
/// just a centered message.
class _RefreshableCenter extends StatelessWidget {
  const _RefreshableCenter({required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (final BuildContext _, final BoxConstraints constraints) =>
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(child: child),
            ),
          ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(final BuildContext context) {
    return _RefreshableCenter(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          'No saved events yet.\nTap the heart on an event to save it.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyRegular.copyWith(color: AppColors.text300),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry, this.message});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(final BuildContext context) {
    return _RefreshableCenter(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              message ?? 'Could not load your favorites.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.text300,
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
              child: Text(
                'Retry',
                style: AppTextStyles.bodySmallBold.copyWith(
                  color: _kAccentOrange,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
