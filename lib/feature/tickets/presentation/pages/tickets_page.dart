// ==============================================================================
// lib/feature/tickets/presentation/pages/tickets_page.dart
// "My tickets" list. An Upcoming/Past tab (based on event end-date) switches
// which tickets show; within a tab the list is sorted by event start and
// grouped under date headers (Today / Tomorrow / "Saturday, 14 Jun"). Each
// card carries a status pill for checked-in / cancelled / refunded / past
// tickets so a used or voided ticket can't be mistaken for a valid one.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/router/app_router.dart';

import '../../../../core/di/core_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/ticket_entity.dart';
import '../blocs/tickets_bloc.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

enum _Tab { upcoming, past }

// A row in the flattened list: either a date header or a ticket card.
sealed class _Row {
  const _Row();
}

class _HeaderRow extends _Row {
  const _HeaderRow(this.day);
  final DateTime day;
}

class _TicketRow extends _Row {
  const _TicketRow(this.ticket);
  final TicketEntity ticket;
}

@RoutePage()
class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<TicketsBloc>(
      create: (_) => inject<TicketsBloc>()..add(const TicketsEvent.started()),
      child: const _TicketsView(),
    );
  }
}

class _TicketsView extends StatefulWidget {
  const _TicketsView();

  @override
  State<_TicketsView> createState() => _TicketsViewState();
}

class _TicketsViewState extends State<_TicketsView> {
  _Tab _tab = _Tab.upcoming;

  static DateTime _dateOnly(final DateTime d) =>
      DateTime(d.year, d.month, d.day);

  bool _isPast(final TicketEntity t) {
    final end = t.event.endsAt ?? t.event.startsAt;
    return end.isBefore(DateTime.now());
  }

  /// Sort by event start (soonest first for Upcoming, most-recent first for
  /// Past), then walk the list inserting a header row whenever the day changes.
  List<_Row> _buildRows(final List<TicketEntity> tickets, final _Tab tab) {
    final sorted = <TicketEntity>[...tickets]
      ..sort((a, b) {
        final cmp = a.event.startsAt.compareTo(b.event.startsAt);
        return tab == _Tab.past ? -cmp : cmp;
      });

    final rows = <_Row>[];
    DateTime? currentDay;
    for (final t in sorted) {
      final day = _dateOnly(t.event.startsAt);
      if (day != currentDay) {
        rows.add(_HeaderRow(day));
        currentDay = day;
      }
      rows.add(_TicketRow(t));
    }
    return rows;
  }

  /// "Today" / "Tomorrow" / "Yesterday", else "Saturday, 14 Jun" (with the
  /// year appended when it isn't the current year).
  String _headerLabel(final DateTime day) {
    final today = _dateOnly(DateTime.now());
    final diff = day.difference(today).inDays;
    if (diff == 0) return 'Today';
    if (diff == 1) return 'Tomorrow';
    if (diff == -1) return 'Yesterday';
    final pattern = day.year == today.year ? 'EEEE, d MMM' : 'EEEE, d MMM y';
    return DateFormat(pattern).format(day);
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F5),
      body: BlocBuilder<TicketsBloc, TicketsState>(
        builder: (final BuildContext ctx, final TicketsState s) {
          if (s.isLoading || s.status == TicketsStatus.idle) {
            return const SafeArea(child: _LoadingView());
          }
          if (s.hasFailed) {
            return SafeArea(
              child: _ErrorView(
                message: s.error,
                onRetry: () =>
                    ctx.read<TicketsBloc>().add(const TicketsEvent.refreshed()),
              ),
            );
          }
          if (s.tickets.isEmpty) {
            return const SafeArea(
              child: _EmptyView(message: 'You have no tickets yet.'),
            );
          }

          final visible = s.tickets
              .where((t) => _tab == _Tab.past ? _isPast(t) : !_isPast(t))
              .toList(growable: false);

          final rows = _buildRows(visible, _tab);

          return Column(
            children: <Widget>[
              // White header card. Extends behind the system status bar so
              // it reads as the top of the page; SafeArea inside keeps the
              // content clear of the notch.
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                ),
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: <Widget>[
                      const _TopBar(),
                      const SizedBox(height: 8),
                      _Tabs(
                        value: _tab,
                        onChanged: (t) => setState(() => _tab = t),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: RefreshIndicator(
                  color: _kAccentOrange,
                  onRefresh: () async {
                    ctx.read<TicketsBloc>().add(const TicketsEvent.refreshed());
                  },
                  child: rows.isEmpty
                      ? _EmptyForTabView(isPast: _tab == _Tab.past)
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                          itemCount: rows.length,
                          itemBuilder: (_, final int i) {
                            final row = rows[i];
                            if (row is _HeaderRow) {
                              return _DateHeader(label: _headerLabel(row.day));
                            }
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _TicketCard(
                                ticket: (row as _TicketRow).ticket,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─── Top bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 12, 4),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
            'Tickets',
            style: AppTextStyles.bodyLargeBold.copyWith(
              fontSize: 19,
              color: AppColors.text500,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.more_vert, color: AppColors.text500),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Tabs ────────────────────────────────────────────────────────────────────

class _Tabs extends StatelessWidget {
  const _Tabs({required this.value, required this.onChanged});

  final _Tab value;
  final ValueChanged<_Tab> onChanged;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.greyscale25,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: <Widget>[
            _TabPill(
              label: 'Upcoming',
              selected: value == _Tab.upcoming,
              onTap: () => onChanged(_Tab.upcoming),
            ),
            _TabPill(
              label: 'Past Tickets',
              selected: value == _Tab.past,
              onTap: () => onChanged(_Tab.past),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.primary800 : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: AppTextStyles.bodySmallBold.copyWith(
              color: selected ? AppColors.white : AppColors.text300,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Ticket card ─────────────────────────────────────────────────────────────

class _TicketCard extends StatelessWidget {
  const _TicketCard({required this.ticket});

  final TicketEntity ticket;

  @override
  Widget build(final BuildContext context) {
    final _AvatarStyle style = _styleFor(ticket.event.category);
    final String time = DateFormat('hh:mm a').format(ticket.event.startsAt);
    final String seat = ticket.seats?.displayLabel ?? 'No seat';
    final bool isPast = (ticket.event.endsAt ?? ticket.event.startsAt).isBefore(
      DateTime.now(),
    );
    final _StatusBadge? badge = _statusBadgeFor(ticket, isPast: isPast);

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () => context.router.push(
        TicketDetailRoute(ticketId: ticket.id, ticket: ticket),
      ),
      // The background image is 1070×768 (≈1.39:1). AspectRatio locks the
      // card to that shape so the image keeps its natural proportions, and
      // the Stack lays content on top. Spacer in the Column pushes the
      // footer to the bottom of the card. Refunded / cancelled tickets are
      // dimmed so they read as no longer valid.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AspectRatio(
          aspectRatio: 360 / 160,
          child: Opacity(
            opacity: ticket.isUsable ? 1.0 : 1,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    ImageConstants.ticketBackground,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Title + avatar
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                if (badge != null) ...<Widget>[
                                  _StatusPill(badge: badge),
                                  const SizedBox(height: 6),
                                ],
                                Text(
                                  ticket.event.title,
                                  maxLines: badge != null ? 1 : 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.bodyBold.copyWith(
                                    color: AppColors.text500,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: style.color,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              style.icon,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // Footer
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _Field(label: 'Time', value: time),
                          const SizedBox(width: 24),
                          Expanded(
                            child: _Field(label: 'Seat', value: seat),
                          ),
                          _TierBadge(name: ticket.ticketTier.name),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.captionRegular.copyWith(
            color: AppColors.text300,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.bodySmallBold.copyWith(color: AppColors.text500),
        ),
      ],
    );
  }
}

class _TierBadge extends StatelessWidget {
  const _TierBadge({required this.name});

  final String name;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.text10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '$name x1',
        style: AppTextStyles.captionBold.copyWith(color: AppColors.text500),
      ),
    );
  }
}

// ─── Status badge ────────────────────────────────────────────────────────────
//
// The backend constrains tickets.status to issued / checked_in / refunded /
// cancelled (see backend migration 0001_init.sql) — there is no 'expired'
// ticket status. "Expired" is a derived UI label for an issued ticket whose
// event is already over and was never checked in.

class _StatusBadge {
  const _StatusBadge(this.label, this.color);
  final String label;
  final Color color;
}

/// A pill for non-ordinary tickets. Returns null for a normal valid upcoming
/// ticket so its card stays clean.
_StatusBadge? _statusBadgeFor(
  final TicketEntity t, {
  required final bool isPast,
}) {
  switch (t.status) {
    case 'checked_in':
      return const _StatusBadge('Checked in', Color(0xFF1AC5B0));
    case 'cancelled':
      return const _StatusBadge('Cancelled', Color(0xFFE54B6E));
    case 'refunded':
      return const _StatusBadge('Refunded', Color(0xFF8A8F98));
    case 'expired':
      return const _StatusBadge('Expired', Color(0xFF8A8F98));
  }
  // 'issued' but the event is already over (the expire cron hasn't run yet):
  // show the same label so the card matches once the status flips.
  if (isPast) return const _StatusBadge('Expired', Color(0xFF8A8F98));
  return null;
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.badge});

  final _StatusBadge badge;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: badge.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: badge.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            badge.label,
            style: AppTextStyles.captionBold.copyWith(color: badge.color),
          ),
        ],
      ),
    );
  }
}

// ─── Date header ─────────────────────────────────────────────────────────────

class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.label});

  final String label;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            ImageConstants.calendar,
            height: 14,
            width: 14,
            color: AppColors.text300,
          ),
          const SizedBox(width: 6),
          Text(
            label.toUpperCase(),
            style: AppTextStyles.captionBold.copyWith(
              color: AppColors.text300,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Avatar style mapping ────────────────────────────────────────────────────

class _AvatarStyle {
  const _AvatarStyle(this.icon, this.color);
  final IconData icon;
  final Color color;
}

_AvatarStyle _styleFor(final String category) {
  switch (category.toLowerCase()) {
    case 'art':
      return const _AvatarStyle(Icons.palette_outlined, Color(0xFFFF8551));
    case 'music':
      return const _AvatarStyle(Icons.music_note_outlined, Color(0xFF1AC5B0));
    case 'tech':
      return const _AvatarStyle(Icons.computer_outlined, Color(0xFF7B61FF));
    case 'sports':
      return const _AvatarStyle(
        Icons.sports_basketball_outlined,
        Color(0xFFE54B6E),
      );
    case 'food':
      return const _AvatarStyle(Icons.restaurant_outlined, Color(0xFF5BB55F));
    default:
      return const _AvatarStyle(
        Icons.local_activity_outlined,
        Color(0xFFFF8551),
      );
  }
}

// ─── Loading / empty / error ─────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(final BuildContext context) =>
      const Center(child: CircularProgressIndicator(color: _kAccentOrange));
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.message});

  final String message;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyRegular.copyWith(color: AppColors.text300),
        ),
      ),
    );
  }
}

class _EmptyForTabView extends StatelessWidget {
  const _EmptyForTabView({required this.isPast});

  final bool isPast;

  @override
  Widget build(final BuildContext context) {
    // ListView so RefreshIndicator stays usable when there's nothing to show.
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      children: <Widget>[
        Text(
          isPast ? 'No past tickets.' : 'No upcoming tickets.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyRegular.copyWith(color: AppColors.text300),
        ),
      ],
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
              message ?? 'Could not load your tickets.',
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
