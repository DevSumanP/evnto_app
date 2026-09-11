import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tap_app/core/constants/image_constants.dart';

import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';
import 'package:tap_app/feature/home/domain/entities/home_section.dart';
import 'package:tap_app/shared/widgets/common/network_image.dart';

class NextTicketSectionWidget extends StatelessWidget {
  const NextTicketSectionWidget({required this.section, super.key});

  final NextTicketSection section;

  (String label, String number) _countdown(final DateTime startsAt) {
    final DateTime now = DateTime.now();
    final int days = DateTime(
      startsAt.year,
      startsAt.month,
      startsAt.day,
    ).difference(DateTime(now.year, now.month, now.day)).inDays;
    if (days < 0) return ('started', '');
    if (days == 0) return ('today', '!');
    if (days == 1) return ('day to go', '1');
    return ('days to go', '$days');
  }

  @override
  Widget build(final BuildContext context) {
    final event = section.event;
    final String venue = (event.venueName ?? event.venueCity ?? '').trim();
    final String when = DateFormat(
      'EEE, MMM d · h:mm a',
    ).format(event.startsAt);
    final String? image = event.heroImageUrl;
    final (String countdownLabel, String countdownNumber) = _countdown(
      event.startsAt,
    );

    return Container(
      height: 140,
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.muted.withOpacity(0.15),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ── Left spine: dark panel with image + countdown ──────
          _TicketSpine(
            image: image,
            countdownNumber: countdownNumber,
            countdownLabel: countdownLabel,
          ),

          // ── Notch divider ──────────────────────────────────────
          _NotchDivider(),

          // ── Right: event details ───────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 14, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Top: label + title + meta
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'UPCOMING EVENT',
                        style: AppTextStyles.captionRegular.copyWith(
                          color: AppColors.muted,
                          letterSpacing: 0.8,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        event.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (venue.isNotEmpty) ...<Widget>[
                        _MetaRow(icon: ImageConstants.location, label: venue),
                        const SizedBox(height: 3),
                      ],
                      _MetaRow(icon: ImageConstants.calendar, label: when),
                    ],
                  ),

                  // Bottom: admit + button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ADMIT ONE',
                        style: AppTextStyles.captionRegular.copyWith(
                          color: AppColors.muted,
                          letterSpacing: 1.0,
                          fontSize: 9,
                        ),
                      ),
                      const Spacer(),
                      _ViewTicketButton(
                        onTap: () => context.router.push(
                          EventDetailRoute(eventId: event.id),
                        ),
                      ),
                    ],
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

// ── Left dark spine ───────────────────────────────────────────────────────────

class _TicketSpine extends StatelessWidget {
  const _TicketSpine({
    required this.image,
    required this.countdownNumber,
    required this.countdownLabel,
  });

  final String? image;
  final String countdownNumber;
  final String countdownLabel;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 110,
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(10, 10, 4, 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 75,
              height: 72,
              child: (image == null || image!.isEmpty)
                  ? const ColoredBox(
                      color: Color(0xFF2E2E4A),
                      child: Icon(
                        Icons.music_note,
                        color: Colors.white24,
                        size: 24,
                      ),
                    )
                  : AppNetworkImage(image!, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 4),
          if (countdownNumber.isNotEmpty)
            Text(
              countdownNumber,
              style: AppTextStyles.h4Bold.copyWith(
                color: AppColors.black,
                fontSize: 18,
                height: 1.1,
              ),
            ),
          Text(
            countdownLabel,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.text300,
              fontSize: 10,
              letterSpacing: 0.3,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Notch divider ─────────────────────────────────────────────────────────────

class _NotchDivider extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      width: 16,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          // Dashed vertical line
          Positioned.fill(
            child: Center(
              child: CustomPaint(
                painter: _DashedLinePainter(),
                size: const Size(1, double.infinity),
              ),
            ),
          ),
          // Top notch
          Positioned(top: -9, left: 0, right: 0, child: _Notch()),
          // Bottom notch
          Positioned(bottom: -9, left: 0, right: 0, child: _Notch()),
        ],
      ),
    );
  }
}

class _Notch extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFF8F8F8),
          border: Border.all(
            color: AppColors.muted.withOpacity(0.15),
            width: 0.5,
          ),
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.text300.withOpacity(0.25)
      ..strokeWidth = 1.3;
    const double dashHeight = 6;
    const double dashSpace = 4;
    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Meta row (icon + text) ────────────────────────────────────────────────────

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        SvgPicture.asset(icon, height: 12, width: 12, color: AppColors.muted),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.captionRegular.copyWith(
              color: AppColors.muted,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}

// ── View ticket button ────────────────────────────────────────────────────────

class _ViewTicketButton extends StatelessWidget {
  const _ViewTicketButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Text(
            'View ticket',
            style: AppTextStyles.captionBold.copyWith(
              color: AppColors.canvas,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}
