// ==============================================================================
// lib/feature/tickets/presentation/pages/ticket_detail_page.dart
// Single-ticket view. Header + orange-bordered ticket card (image + white
// info card with a dashed perforation and id strip) + Download / Show QR
// buttons. The ticket itself is passed in as a route arg so no fetch is
// needed here; the QR token is loaded on the next screen.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/shared/widgets/buttons/primary_button.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/ticket_entity.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

@RoutePage(name: 'TicketDetailRoute')
class TicketDetailPage extends StatelessWidget {
  const TicketDetailPage({
    super.key,
    @PathParam('id') required this.ticketId,
    required this.ticket,
  });

  final String ticketId;
  final TicketEntity ticket;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _Header(title: 'Tickets', onBack: () => context.router.maybePop()),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                child: _TicketCard(ticket: ticket),
              ),
            ),
            _BottomBar(
              primaryLabel: 'Download Image',
              primaryIcon: Icons.file_download_outlined,
              onPrimary: () {},
              secondaryLabel: 'Show QR Code',
              secondaryIcon: Icons.qr_code_2_outlined,
              onSecondary: () => context.router.push(
                TicketQrRoute(ticketId: ticket.id, ticket: ticket),
              ),
            ),
          ],
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
    final DateFormat dateFmt = DateFormat('MMMM d, y');
    final DateFormat timeFmt = DateFormat('hh:mm a');

    return Container(
      decoration: BoxDecoration(
        color: _kAccentOrange,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // 1. Hero image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ticket.event.heroImageUrl != null
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AppNetworkImage(
                          ticket.event.heroImageUrl!,
                          fit: BoxFit.cover,
                          errorWidget: Container(color: AppColors.text20),
                        ),
                      ),
                    )
                  : Container(color: AppColors.text20),
            ),
          ),

          const SizedBox(height: 16),

          // 2. customShape — zero spacing, sits flush against the image above
          Image.asset(
            ImageConstants.customShape,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),

          // 3. Ticket detail card — flush against the shape above
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      ticket.event.title,
                      style: AppTextStyles.bodyLargeBold.copyWith(
                        color: AppColors.text500,
                      ),
                    ),
                  ),
                  if ((ticket.event.venueName ?? '').isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        ticket.event.venueName!,
                        style: AppTextStyles.bodySmallRegular.copyWith(
                          color: AppColors.text300,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: _DashedDivider(),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _LabelValue(
                            label: 'Date',
                            value: dateFmt.format(ticket.event.startsAt),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: _LabelValue(
                            label: 'Time',
                            value: timeFmt.format(ticket.event.startsAt),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: _LabelValue(
                            label: 'Venue',
                            value: ticket.event.venueName ?? '—',
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: _LabelValue(
                            label: 'Seat',
                            value: ticket.seats?.displayLabel ?? 'No seat',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: <Widget>[
                      Transform.translate(
                        offset: const Offset(-16, 0),
                        child: const _PerfDot(),
                      ),
                      const SizedBox(width: 6),
                      const Expanded(child: _DashedDivider()),
                      const SizedBox(width: 6),
                      Transform.translate(
                        offset: const Offset(16, 0),
                        child: const _PerfDot(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Center(
                      child: BarcodeWidget(
                        barcode: Barcode.code128(),
                        data: ticket.id,
                        width: double.infinity,
                        height: 42,
                        drawText: false,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          letterSpacing: 3,
                          color: AppColors.text500,
                        ),
                        color: AppColors.text500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelValue extends StatelessWidget {
  const _LabelValue({required this.label, required this.value});

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

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(final BuildContext context) {
    return LayoutBuilder(
      builder: (final BuildContext _, final BoxConstraints c) {
        const double dashW = 6;
        final int n = (c.maxWidth / (dashW * 2)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List<Widget>.generate(
            n,
            (_) => Container(width: dashW, height: 1, color: AppColors.text30),
          ),
        );
      },
    );
  }
}

// ─── Shared header / bottom bar (also used by the QR page) ───────────────────

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
  const _BottomBar({
    required this.primaryLabel,
    required this.primaryIcon,
    required this.onPrimary,
    required this.secondaryLabel,
    required this.secondaryIcon,
    required this.onSecondary,
  });

  final String primaryLabel;
  final IconData primaryIcon;
  final VoidCallback onPrimary;
  final String secondaryLabel;
  final IconData secondaryIcon;
  final VoidCallback onSecondary;

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
                label: primaryLabel,
                icon: SvgPicture.asset(
                  ImageConstants.download,
                  height: 16,
                  width: 16,
                  color: AppColors.white,
                ),
                backgroundColor: _kAccentOrange,
                textColor: AppColors.white,
                onPressed: onPrimary,
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 4,
              child: PrimaryButton(
                label: secondaryLabel,
                icon: SvgPicture.asset(
                  ImageConstants.qrCode,
                  height: 16,
                  width: 16,
                ),
                backgroundColor: AppColors.text10,
                textColor: AppColors.black,
                onPressed: onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PerfDot extends StatelessWidget {
  const _PerfDot();

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: _kAccentOrange,
        shape: BoxShape.circle,
      ),
    );
  }
}
