// ==============================================================================
// lib/feature/checkout/presentation/pages/get_ticket_page.dart
// Screen 1 of the checkout flow. Cart-only — no backend calls.
// Annotated with @RoutePage directly on the widget (project convention).
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/di/core_injection.dart';
import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/checkout/data/models/checkout_initiate_model.dart';
import 'package:tap_app/feature/checkout/presentation/blocs/get_ticket_bloc.dart';
import 'package:tap_app/feature/event-detail/domain/entities/event_detail.dart';
import 'package:tap_app/feature/event-detail/presentation/blocs/event_detail_bloc.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

const Color _kAccentOrange = Color(0xFFFF8551);
const Color _kAccentOrangeSoft = Color(0xFFFFE5DA);

@RoutePage(name: 'GetTicketRoute')
class GetTicketPage extends StatelessWidget {
  const GetTicketPage({super.key, @PathParam('id') required this.eventId});

  final String eventId;

  @override
  Widget build(final BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<EventDetailBloc>(
          create: (_) =>
              inject<EventDetailBloc>()..add(EventDetailEvent.started(eventId)),
        ),
        BlocProvider<GetTicketBloc>(create: (_) => inject<GetTicketBloc>()),
      ],
      child: _GetTicketView(eventId: eventId),
    );
  }
}

class _GetTicketView extends StatelessWidget {
  const _GetTicketView({required this.eventId});

  final String eventId;

  @override
  Widget build(final BuildContext context) {
    return BlocListener<EventDetailBloc, EventDetailState>(
      listenWhen: (a, b) => a.detail != b.detail && b.detail != null,
      listener: (final BuildContext ctx, final EventDetailState s) {
        ctx.read<GetTicketBloc>().add(
          GetTicketEvent.started(eventId: eventId, tiers: s.detail!.tiers),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<EventDetailBloc, EventDetailState>(
            builder: (final BuildContext ctx, final EventDetailState s) {
              if (s.hasFailed) {
                return _ErrorView(
                  message: s.error,
                  onRetry: () => ctx.read<EventDetailBloc>().add(
                    const EventDetailEvent.retried(),
                  ),
                );
              }
              if (s.isLoading ||
                  s.status == EventDetailStatus.idle ||
                  s.detail == null) {
                return const _LoadingView();
              }
              return _LoadedBody(detail: s.detail!);
            },
          ),
        ),
        bottomNavigationBar: const _SubtotalBar(),
      ),
    );
  }
}

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.detail});
  final EventDetail detail;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        const _TopBar(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _DateStrip(detail: detail),
                const SizedBox(height: 24),
                Text(
                  'Choose the ticket',
                  style: AppTextStyles.bodyBold.copyWith(
                    color: AppColors.text500,
                  ),
                ),
                const SizedBox(height: 12),
                _TierList(detail: detail),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              borderRadius: BorderRadius.circular(999),
              onTap: () => context.router.maybePop(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  ImageConstants.backArrow,
                  height: 22,
                  width: 22,
                  color: AppColors.text500,
                ),
              ),
            ),
          ),
          Text(
            'Get a Ticket',
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.text500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateStrip extends StatelessWidget {
  const _DateStrip({required this.detail});
  final EventDetail detail;

  static DateTime _dateOnly(final DateTime d) =>
      DateTime(d.year, d.month, d.day);

  @override
  Widget build(final BuildContext context) {
    final DateTime start = _dateOnly(detail.startsAt);
    final DateTime end = _dateOnly(detail.endsAt);
    final List<DateTime> days = List<DateTime>.generate(
      5,
      (i) => start.add(Duration(days: i - 2)),
    );

    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (final BuildContext ctx, final int i) {
          final DateTime d = days[i];
          final bool inRange = !d.isBefore(start) && !d.isAfter(end);
          return _DayCell(date: d, inRange: inRange);
        },
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({required this.date, required this.inRange});
  final DateTime date;
  final bool inRange;

  @override
  Widget build(final BuildContext context) {
    final String day = DateFormat('d').format(date);
    final String month = DateFormat('MMM').format(date);
    final Color bg = inRange ? AppColors.primary700 : Colors.transparent;
    final Color fg = inRange ? AppColors.white : AppColors.text300;
    final Border? border = inRange ? null : Border.all(color: AppColors.text30);

    return Container(
      width: 58,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: border,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            day,
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: fg,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            month,
            style: AppTextStyles.captionBold.copyWith(
              color: fg,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _TierList extends StatelessWidget {
  const _TierList({required this.detail});
  final EventDetail detail;

  @override
  Widget build(final BuildContext context) {
    if (detail.tiers.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          'No ticket tiers available for this event.',
          style: AppTextStyles.bodyRegular.copyWith(color: AppColors.text300),
        ),
      );
    }
    return Column(
      children: <Widget>[
        for (final TicketTier t in detail.tiers) ...<Widget>[
          _TierRow(tier: t, detail: detail),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _TierRow extends StatefulWidget {
  const _TierRow({required this.tier, required this.detail});
  final TicketTier tier;
  final EventDetail detail;

  @override
  State<_TierRow> createState() => _TierRowState();
}

class _TierRowState extends State<_TierRow> {
  bool _benefitOpen = false;

  @override
  Widget build(final BuildContext context) {
    final TicketTier tier = widget.tier;
    final EventDetail detail = widget.detail;
    final bool hasBenefit = (tier.description ?? '').trim().isNotEmpty;

    return BlocBuilder<GetTicketBloc, GetTicketState>(
      buildWhen: (a, b) =>
          (a.quantities[tier.id] ?? 0) != (b.quantities[tier.id] ?? 0) ||
          a.items.length != b.items.length,
      builder: (final BuildContext ctx, final GetTicketState s) {
        final int qty = s.quantities[tier.id] ?? 0;
        final int cap = s.capFor(tier);
        final bool selected = qty > 0;
        final bool canInc =
            tier.isOnSale &&
            qty < cap &&
            (qty > 0 || s.items.length < GetTicketState.kMaxLineItems);
        final bool canDec = qty > 0;

        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? AppColors.primary700 : AppColors.text30,
                width: selected ? 1 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _TierHeader(tierName: tier.name, selected: selected),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: detail.heroImageUrl == null
                              ? const ColoredBox(color: AppColors.text20)
                              : AppNetworkImage(
                                  detail.heroImageUrl!,
                                  fit: BoxFit.cover,
                                  errorWidget: const ColoredBox(
                                    color: AppColors.text20,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              detail.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodyBold.copyWith(
                                color: AppColors.text500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                (tier.quantityTotal > 0)
                                    ? Text(
                                        '${tier.quantityRemaining} spot left',
                                        style: AppTextStyles.captionRegular
                                            .copyWith(color: AppColors.text300),
                                      )
                                    : const SizedBox.shrink(),

                                Text(
                                  tier.isFree
                                      ? 'FREE'
                                      : 'Rs ${tier.pricePaisa ~/ 100}',
                                  style: AppTextStyles.bodyBold.copyWith(
                                    color: AppColors.text500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 1, color: AppColors.text20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  child: Row(
                    children: <Widget>[
                      if (hasBenefit)
                        Expanded(
                          child: InkWell(
                            onTap: () =>
                                setState(() => _benefitOpen = !_benefitOpen),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  _benefitOpen
                                      ? Icons.keyboard_arrow_down
                                      : Icons.keyboard_arrow_right,
                                  size: 18,
                                  color: _kAccentOrange,
                                ),
                                Text(
                                  'Show benefit',
                                  style: AppTextStyles.bodySmallBold.copyWith(
                                    color: _kAccentOrange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        const Spacer(),
                      if (tier.isOnSale)
                        _QtyStepper(
                          quantity: qty,
                          canIncrement: canInc,
                          canDecrement: canDec,
                          onInc: () => ctx.read<GetTicketBloc>().add(
                            GetTicketEvent.incremented(tier.id),
                          ),
                          onDec: () => ctx.read<GetTicketBloc>().add(
                            GetTicketEvent.decremented(tier.id),
                          ),
                        )
                      else
                        Text(
                          _saleStatusLabel(tier),
                          style: AppTextStyles.captionRegular.copyWith(
                            color: AppColors.text300,
                          ),
                        ),
                    ],
                  ),
                ),
                if (_benefitOpen && hasBenefit)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
                    child: Text(
                      tier.description!,
                      style: AppTextStyles.captionRegular.copyWith(
                        color: AppColors.text300,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _saleStatusLabel(final TicketTier t) {
    if (t.isSoldOut) return 'Sold out';
    if (t.salesNotStarted) return 'Sales not started';
    if (t.salesEnded) return 'Sales ended';
    return '';
  }
}

class _TierHeader extends StatelessWidget {
  const _TierHeader({required this.tierName, required this.selected});
  final String tierName;
  final bool selected;

  @override
  Widget build(final BuildContext context) {
    final Color bg = selected ? AppColors.primary800 : AppColors.text10;
    final Color fg = selected ? AppColors.white : AppColors.text500;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      color: bg,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '$tierName price',
              style: AppTextStyles.bodySmallBold.copyWith(color: fg),
            ),
          ),
          if (selected)
            const Icon(Icons.check_circle, size: 20, color: AppColors.white)
          else
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.text100, width: 1.5),
              ),
            ),
        ],
      ),
    );
  }
}

class _QtyStepper extends StatelessWidget {
  const _QtyStepper({
    required this.quantity,
    required this.canIncrement,
    required this.canDecrement,
    required this.onInc,
    required this.onDec,
  });

  final int quantity;
  final bool canIncrement;
  final bool canDecrement;
  final VoidCallback onInc;
  final VoidCallback onDec;

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        _RoundIcon(icon: Icons.remove, onTap: canDecrement ? onDec : null),
        SizedBox(
          width: 36,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyBold.copyWith(color: AppColors.text500),
          ),
        ),
        _RoundIcon(icon: Icons.add, onTap: canIncrement ? onInc : null),
      ],
    );
  }
}

class _RoundIcon extends StatelessWidget {
  const _RoundIcon({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    final bool enabled = onTap != null;
    return Material(
      color: enabled ? _kAccentOrangeSoft : AppColors.text20,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            icon,
            size: 18,
            color: enabled ? _kAccentOrange : AppColors.text200,
          ),
        ),
      ),
    );
  }
}

class _SubtotalBar extends StatelessWidget {
  const _SubtotalBar();

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 0,
      child: SafeArea(
        top: false,
        child: BlocBuilder<GetTicketBloc, GetTicketState>(
          buildWhen: (a, b) =>
              a.subtotalPaisa != b.subtotalPaisa ||
              a.canPlaceOrder != b.canPlaceOrder,
          builder: (final BuildContext ctx, final GetTicketState s) {
            final bool enabled = s.canPlaceOrder;
            final int rs = s.subtotalPaisa ~/ 100;
            return Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.text20)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Subtotal',
                          style: AppTextStyles.captionRegular.copyWith(
                            color: AppColors.text300,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          s.subtotalPaisa == 0 ? 'Rs 0' : 'Rs $rs',
                          style: AppTextStyles.h4Bold.copyWith(
                            color: AppColors.text500,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  _ContinueButton(
                    enabled: enabled,
                    onTap: enabled
                        ? () => ctx.router.push(
                            OrderReviewRoute(
                              eventId: s.eventId,
                              items: s.items,
                              buyer: BuyerDto(
                                name: s.buyer!.displayName ?? s.buyer!.email,
                                email: s.buyer!.email,
                                phone: s.buyer!.phone,
                              ),
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.enabled, required this.onTap});
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: enabled ? _kAccentOrange : AppColors.text20,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Text(
            'Continue',
            style: AppTextStyles.bodyBold.copyWith(
              color: enabled ? AppColors.white : AppColors.text200,
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();
  @override
  Widget build(final BuildContext context) =>
      const Center(child: CircularProgressIndicator());
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});
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
              message ?? 'Something went wrong.',
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.text300,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
