import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/di/core_injection.dart';
import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/event-detail/domain/entities/event_detail.dart';
import 'package:tap_app/feature/event-detail/presentation/blocs/event_detail_bloc.dart';
import 'package:tap_app/feature/favorite/presentation/widgets/favorite_button.dart';
import 'package:tap_app/shared/widgets/common/avatar_widget.dart';
import 'package:tap_app/shared/widgets/common/global_calendar.dart';
import 'package:tap_app/shared/widgets/common/map_location_card.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

@RoutePage(name: 'EventDetailRoute')
class EventDetailPage extends StatelessWidget {
  const EventDetailPage({super.key, @PathParam('id') required this.eventId});

  final String eventId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventDetailBloc>(
      create: (_) =>
          inject<EventDetailBloc>()..add(EventDetailEvent.started(eventId)),
      child: const _EventDetailView(),
    );
  }
}

class _EventDetailView extends StatelessWidget {
  const _EventDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<EventDetailBloc, EventDetailState>(
          builder: (final BuildContext context, final EventDetailState state) {
            if (state.isLoading || state.status == EventDetailStatus.idle) {
              return const _LoadingView();
            }
            if (state.hasFailed) {
              return _ErrorView(
                message: state.error,
                onRetry: () => context.read<EventDetailBloc>().add(
                  const EventDetailEvent.retried(),
                ),
              );
            }

            final EventDetail? detail = state.detail;
            if (detail == null) return const _LoadingView();

            return _LoadedView(detail: detail);
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<EventDetailBloc, EventDetailState>(
        buildWhen: (a, b) => a.detail != b.detail,
        builder: (final BuildContext context, final EventDetailState state) {
          final EventDetail? detail = state.detail;
          if (detail == null) return const SizedBox.shrink();
          return _StickyCta(detail: detail);
        },
      ),
    );
  }
}

// ─── Loaded view ─────────────────────────────────────────────────────────────

class _LoadedView extends StatelessWidget {
  const _LoadedView({required this.detail});

  final EventDetail detail;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        _TopBar(eventId: detail.id),
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Hero(detail: detail),
                const SizedBox(height: 16),
                Text(
                  detail.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.h4Bold.copyWith(
                    color: AppColors.text500,
                    fontSize: 22,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 16),
                _DateRow(detail: detail),
                const SizedBox(height: 24),
                Text(
                  'About this events',
                  style: AppTextStyles.bodyBold.copyWith(
                    color: AppColors.text500,
                  ),
                ),
                const SizedBox(height: 8),
                _Description(text: detail.description),
                const SizedBox(height: 24),
                _Organizer(detail: detail),
                const SizedBox(height: 24),
                _Location(detail: detail),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Organizer ─────────────────────────────────────────────────────────────────
class _Location extends StatelessWidget {
  const _Location({required this.detail});

  final EventDetail detail;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Location',
          style: AppTextStyles.bodyBold.copyWith(color: AppColors.text500),
        ),
        const SizedBox(height: 12),
        MapLocationCard(
          title: detail.venue?.name ?? 'Venue: No given',
          subtitle: detail.venue?.address ?? 'No address',
          location: LatLng(27.6939, 85.3417),
          height: 160,
          interactive: false,
          onTap: () => (),
        ),
      ],
    );
  }
}

// ─── Organizer ─────────────────────────────────────────────────────────────────
class _Organizer extends StatelessWidget {
  const _Organizer({required this.detail});

  final EventDetail detail;

  @override
  Widget build(final BuildContext context) {
    final Organizer organizer = detail.organizer;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Avatar(size: 50, url: organizer.logoUrl, initials: organizer.name[0]),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                organizer.name,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.text500,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                organizer.slug,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: AppColors.text300,
                ),
              ),
            ],
          ),
        ),
        _FollowButton(onTap: () => () {}),
      ],
    );
  }
}

// ─── Top bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar({required this.eventId});

  final String eventId;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Row(
        children: <Widget>[
          _CircleIconButton(
            icon: ImageConstants.backArrow,
            onTap: () => context.router.maybePop(),
          ),
          const Spacer(),
          _CircleIconButton(icon: ImageConstants.share, onTap: () {}),
          const SizedBox(width: 8),
          FavoriteButton(eventId: eventId),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            icon,
            height: 22,
            width: 22,
            color: AppColors.text500,
          ),
        ),
      ),
    );
  }
}

// ─── Hero image ──────────────────────────────────────────────────────────────

class _Hero extends StatelessWidget {
  const _Hero({required this.detail});

  final EventDetail detail;

  @override
  Widget build(final BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: _CoverImage(url: detail.heroImageUrl),
          ),
          // Bottom-left category chip (the screenshot has a Watch video pill;
          // we surface category instead since we have no video URL yet).
          Positioned(
            left: 12,
            bottom: 12,
            child: _DarkChip(
              icon: Icons.local_activity_outlined,
              label: detail.category,
            ),
          ),
        ],
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

// ─── Date row ────────────────────────────────────────────────────────────────

class _DateRow extends StatelessWidget {
  const _DateRow({required this.detail});

  final EventDetail detail;

  @override
  Widget build(final BuildContext context) {
    final String day = DateFormat('EEEE').format(detail.startsAt);
    final String timeRange = _formatTimeRange(detail.startsAt, detail.endsAt);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _DateBadge(date: detail.startsAt),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                day,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.text500,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                timeRange,
                style: AppTextStyles.bodySmallRegular.copyWith(
                  color: AppColors.text300,
                ),
              ),
            ],
          ),
        ),
        _CalendarButton(
          onTap: () => _openCalendarSheet(context, detail.startsAt),
        ),
      ],
    );
  }

  /// Opens GlobalCalendar in a bottom sheet, anchored to the event's start
  /// date. Read-only here: tapping a day dismisses the sheet.
  void _openCalendarSheet(final BuildContext context, final DateTime date) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (final BuildContext sheetCtx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: GlobalCalendar(
            initialDate: date,
            firstDate: DateTime(date.year - 1),
            lastDate: DateTime(date.year + 5),
            eventDates: <DateTime>{DateUtils.dateOnly(date)},
            onDateSelected: (_) => Navigator.of(sheetCtx).maybePop(),
          ),
        ),
      ),
    );
  }

  String _formatTimeRange(final DateTime start, final DateTime end) {
    final String startStr = DateFormat('h:mm a').format(start);
    final bool sameDay =
        start.year == end.year &&
        start.month == end.month &&
        start.day == end.day;
    final String endStr = sameDay ? DateFormat('h:mm a').format(end) : 'End';
    return '$startStr - $endStr';
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date});

  final DateTime date;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 4),
            color: Color(0x14000000),
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
              fontSize: 18,
              height: 1.1,
            ),
          ),
          Text(
            DateFormat('MMM').format(date),
            style: AppTextStyles.captionRegular.copyWith(
              color: AppColors.text300,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _CalendarButton extends StatelessWidget {
  const _CalendarButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _kAccentOrange),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SvgPicture.asset(
            ImageConstants.calendar,
            color: _kAccentOrange,
            height: 22,
            width: 22,
          ),
        ),
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: _kAccentOrange),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Text(
            'Follow',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── About + show more ──────────────────────────────────────────────────────

class _Description extends StatefulWidget {
  const _Description({required this.text});

  final String? text;

  @override
  State<_Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<_Description> {
  bool _expanded = false;
  static const int _collapsedLines = 4;

  @override
  Widget build(final BuildContext context) {
    final String body = (widget.text ?? '').trim();
    if (body.isEmpty) {
      return Text(
        'No description yet.',
        style: AppTextStyles.bodyRegular.copyWith(color: AppColors.text300),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          body,
          maxLines: _expanded ? null : _collapsedLines,
          overflow: _expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: AppTextStyles.bodyRegular.copyWith(
            color: AppColors.text300,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Text(
            _expanded ? 'Show less' : 'Show more',
            style: AppTextStyles.bodySmallBold.copyWith(color: _kAccentOrange),
          ),
        ),
      ],
    );
  }
}

// ─── Sticky CTA bar ──────────────────────────────────────────────────────────

class _StickyCta extends StatelessWidget {
  const _StickyCta({required this.detail});

  final EventDetail detail;

  @override
  Widget build(final BuildContext context) {
    final int spotsLeft = detail.tiers.fold<int>(
      0,
      (final int sum, final TicketTier t) => sum + t.quantityRemaining,
    );
    final bool isSoldOut =
        detail.hasTiers && detail.tiers.every((t) => t.isSoldOut);

    return Material(
      color: AppColors.white,
      elevation: 0,
      child: SafeArea(
        top: false,
        child: Padding(
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
                      _priceLabel(detail),
                      style: AppTextStyles.h4Bold.copyWith(
                        color: AppColors.text500,
                        fontSize: 18,
                      ),
                    ),
                    if (detail.hasTiers) ...<Widget>[
                      const SizedBox(height: 2),
                      Text(
                        isSoldOut ? 'Sold out' : '$spotsLeft Spot left',
                        style: AppTextStyles.captionRegular.copyWith(
                          color: AppColors.text300,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _GetTicketButton(
                onTap: isSoldOut
                    ? null
                    : () => context.router.push(
                        GetTicketRoute(eventId: detail.id),
                      ),
                label: isSoldOut ? 'Sold Out' : 'Get a Ticket',
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _priceLabel(final EventDetail d) {
    if (!d.hasTiers) return '—';
    if (d.isFree) return 'FREE';
    final int? min = d.minPricePaisa;
    final int? max = d.maxPricePaisa;
    if (min == null) return '—';
    final int minRs = (min / 100).round();
    if (max == null || max == min) return 'Rs $minRs';
    final int maxRs = (max / 100).round();
    return 'Rs $minRs - Rs $maxRs';
  }
}

class _GetTicketButton extends StatelessWidget {
  const _GetTicketButton({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    final bool enabled = onTap != null;
    return Material(
      color: enabled ? _kAccentOrange : AppColors.grey200,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          child: Text(
            label,
            style: AppTextStyles.bodySmallBold.copyWith(
              color: AppColors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _DarkChip extends StatelessWidget {
  const _DarkChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.55),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.captionBold.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// ─── Loading + error states ─────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: _kAccentOrange),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry, this.message});

  final String? message;
  final VoidCallback onRetry;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              message ?? 'Could not load this event.',
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
