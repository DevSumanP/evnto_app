// ==============================================================================
// lib/feature/tickets/presentation/pages/ticket_qr_page.dart
// QR screen. Fetches a short-lived QR token via TicketDetailBloc and renders
// it inside a white card. Header + summary row + QR card + tip + buttons.
// ==============================================================================

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/shared/widgets/buttons/primary_button.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

import '../../../../core/di/core_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/ticket_entity.dart';
import '../blocs/ticket_detail_bloc.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

@RoutePage(name: 'TicketQrRoute')
class TicketQrPage extends StatelessWidget {
  const TicketQrPage({
    super.key,
    @PathParam('id') required this.ticketId,
    required this.ticket,
  });

  final String ticketId;
  final TicketEntity ticket;

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<TicketDetailBloc>(
      create: (_) =>
          inject<TicketDetailBloc>()..add(TicketDetailEvent.started(ticketId)),
      child: _QrView(ticket: ticket),
    );
  }
}

class _QrView extends StatefulWidget {
  const _QrView({required this.ticket});

  final TicketEntity ticket;

  @override
  State<_QrView> createState() => _QrViewState();
}

class _QrViewState extends State<_QrView> with WidgetsBindingObserver {
  // The backend signs QR tokens with a 12-minute lifetime, so refresh a little
  // before that to always show a live code without a visible gap.
  static const Duration _refreshEvery = Duration(minutes: 10);

  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _maximiseScreen();
    _refreshTimer = Timer.periodic(_refreshEvery, (_) => _refreshToken());
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _restoreScreen();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // The cached token may have expired while away, and the OS resets
      // brightness on background, so redo both on return.
      _maximiseScreen();
      _refreshToken();
    }
  }

  void _refreshToken() {
    if (!mounted) return;
    context.read<TicketDetailBloc>().add(const TicketDetailEvent.refreshed());
  }

  // Force full brightness and keep the screen awake so gate scanners can read
  // the code. Both are restored when the screen closes.
  Future<void> _maximiseScreen() async {
    try {
      await ScreenBrightness().setApplicationScreenBrightness(1.0);
      await WakelockPlus.enable();
    } catch (_) {
      // Best effort — a device that refuses brightness control must not crash
      // the QR screen.
    }
  }

  Future<void> _restoreScreen() async {
    try {
      await ScreenBrightness().resetApplicationScreenBrightness();
      await WakelockPlus.disable();
    } catch (_) {}
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 248),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _Header(title: 'QR Code', onBack: () => context.router.maybePop()),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                children: <Widget>[
                  _QrSummary(ticket: widget.ticket),
                  const SizedBox(height: 24),
                  const _Tip(
                    text:
                        'Please show this code at the event and scan it '
                        'to proceed.',
                  ),
                ],
              ),
            ),
            _BottomBar(onDownload: () {}, onShare: () {}),
          ],
        ),
      ),
    );
  }
}

class _QrSummary extends StatelessWidget {
  const _QrSummary({required this.ticket});

  final TicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: <Widget>[
          _SummaryRow(ticket: ticket),
          const _DashedDivider(),
          const _QrCard(),
        ],
      ),
    );
  }
}

// ─── Summary row (thumbnail + title + date / time) ───────────────────────────

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.ticket});

  final TicketEntity ticket;

  @override
  Widget build(final BuildContext context) {
    final DateFormat dateFmt = DateFormat('MMMM d, y');
    final DateFormat timeFmt = DateFormat('hh:mm a');

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 68,
              height: 68,
              child: ticket.event.heroImageUrl != null
                  ? AppNetworkImage(
                      ticket.event.heroImageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: Container(color: AppColors.text20),
                    )
                  : Container(color: AppColors.text20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  ticket.event.title,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.text500,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: AppColors.text300,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dateFmt.format(ticket.event.startsAt),
                      style: AppTextStyles.captionRegular.copyWith(
                        color: AppColors.text200,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.access_time,
                      size: 12,
                      color: AppColors.text300,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      timeFmt.format(ticket.event.startsAt),
                      style: AppTextStyles.captionRegular.copyWith(
                        color: AppColors.text200,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── QR card ─────────────────────────────────────────────────────────────────

class _QrCard extends StatelessWidget {
  const _QrCard();

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
      child: BlocBuilder<TicketDetailBloc, TicketDetailState>(
        builder: (final BuildContext ctx, final TicketDetailState s) {
          if (s.isLoading || s.status == TicketDetailStatus.idle) {
            return const SizedBox(
              height: 220,
              child: Center(
                child: CircularProgressIndicator(color: _kAccentOrange),
              ),
            );
          }
          if (s.hasFailed || s.qr == null) {
            return SizedBox(
              height: 220,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      s.error ?? 'Could not load QR code.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyRegular.copyWith(
                        color: AppColors.text300,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => ctx.read<TicketDetailBloc>().add(
                        const TicketDetailEvent.refreshed(),
                      ),
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
          return Center(
            child: QrImageView(
              data: s.qr!.token,
              version: QrVersions.auto,
              size: 220,
              backgroundColor: AppColors.white,
            ),
          );
        },
      ),
    );
  }
}

// ─── Yellow tip strip ────────────────────────────────────────────────────────

class _Tip extends StatelessWidget {
  const _Tip({required this.text});

  final String text;

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6E0),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.lightbulb_outline,
            color: Color(0xFFE3A516),
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.text400),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Header + bottom bar (kept local for now) ────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.onBack});

  final String title;
  final VoidCallback onBack;

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, color: AppColors.text500),
            ),
          ),
          Text(
            title,
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.text500,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert, color: AppColors.text500),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({required this.onDownload, required this.onShare});

  final VoidCallback onDownload;
  final VoidCallback onShare;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: SafeArea(
        top: false,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: PrimaryButton(
                label: 'Download',
                icon: SvgPicture.asset(
                  ImageConstants.download,
                  height: 16,
                  width: 16,
                  color: AppColors.white,
                ),
                backgroundColor: _kAccentOrange,
                textColor: AppColors.white,
                onPressed: () {},
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: PrimaryButton(
                label: 'Share',
                icon: SvgPicture.asset(
                  ImageConstants.share02,
                  height: 16,
                  width: 16,
                ),
                backgroundColor: AppColors.white,
                textColor: AppColors.black,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (final BuildContext _, final BoxConstraints c) {
        const double dashW = 6;
        final int n = (c.maxWidth / (dashW * 2)).floor();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List<Widget>.generate(
              n,
              (_) =>
                  Container(width: dashW, height: 1, color: AppColors.text30),
            ),
          ),
        );
      },
    );
  }
}
