// ==============================================================================
// lib/feature/checkout/presentation/pages/order_complete_page.dart
// Placeholder terminal screen. Verifies that navigation lands here after a
// successful Khalti payment. The real receipt UI (ticket list, QR, share)
// lands in step 5.
// ==============================================================================

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

@RoutePage(name: 'OrderCompleteRoute')
class OrderCompletePage extends StatelessWidget {
  const OrderCompletePage({
    super.key,
    @PathParam('id') required this.orderId,
  });

  final String orderId;

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.check_circle, size: 72, color: _kAccentOrange),
                const SizedBox(height: 16),
                Text(
                  'Payment received',
                  style: AppTextStyles.h4Bold.copyWith(
                    color: AppColors.text500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Order $orderId',
                  style: AppTextStyles.captionRegular.copyWith(
                    color: AppColors.text300,
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => context.router.maybePop(),
                  child: Text(
                    'Done',
                    style: AppTextStyles.bodyBold.copyWith(
                      color: _kAccentOrange,
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
