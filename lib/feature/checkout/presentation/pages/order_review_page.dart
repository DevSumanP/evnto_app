import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tap_app/core/constants/image_constants.dart';
import 'package:tap_app/core/di/core_injection.dart';
import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/core/theme/app_colors.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

import '../../data/models/checkout_initiate_model.dart';
import '../../domain/entities/cart_item.dart';
import '../blocs/checkout_bloc.dart';
import 'khalti_webview_page.dart';

const Color _kAccentOrange = Color(0xFFFF8551);

@RoutePage(name: 'OrderReviewRoute')
class OrderReviewPage extends StatelessWidget {
  const OrderReviewPage({
    super.key,
    @PathParam('id') required this.eventId,
    required this.items,
    required this.buyer,
  });

  final String eventId;
  final List<CartItem> items;
  final BuyerDto buyer;

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<CheckoutBloc>(
      create: (_) => inject<CheckoutBloc>()
        ..add(
          CheckoutEvent.started(eventId: eventId, items: items, buyer: buyer),
        ),
      child: const _OrderReviewView(),
    );
  }
}

class _OrderReviewView extends StatelessWidget {
  const _OrderReviewView();

  @override
  Widget build(final BuildContext context) {
    return BlocListener<CheckoutBloc, CheckoutState>(
      listenWhen: (a, b) => a.status != b.status,
      listener: (final BuildContext ctx, final CheckoutState s) async {
        if (s.isReady) {
          final result = await Navigator.of(ctx).push<KhaltiResult>(
            MaterialPageRoute<KhaltiResult>(
              builder: (_) => KhaltiWebviewPage(
                paymentUrl: s.session!.paymentUrl,
              ),
              fullscreenDialog: true,
            ),
          );

          if (!ctx.mounted) return;

          if (result?.outcome == KhaltiOutcome.completed) {
            ctx.read<CheckoutBloc>().add(CheckoutEvent.verifyRequested(
              orderId: s.session!.orderId,
              pidx: result!.pidx ?? s.session!.pidx,
            ));
          } else {
            ctx.read<CheckoutBloc>().add(
              const CheckoutEvent.paymentCanceled(),
            );
          }
        }

        if (s.hasSucceeded && s.session != null) {
          // replace() so back doesn't return into a stale checkout.
          ctx.router.replace(OrderCompleteRoute(orderId: s.session!.orderId));
        }

        if (s.hasFailed && s.error != null) {
          ScaffoldMessenger.of(ctx)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(s.error!)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: const <Widget>[
              _TopBar(),
              Expanded(child: _ReviewBody()),
            ],
          ),
        ),
        bottomNavigationBar: const _PlaceOrderBar(),
      ),
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
            'Order Review',
            style: AppTextStyles.bodyLargeBold.copyWith(
              color: AppColors.text500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewBody extends StatelessWidget {
  const _ReviewBody();
  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (final BuildContext ctx, final CheckoutState s) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _SectionTitle('Tickets'),
              const SizedBox(height: 8),
              for (final CartItem i in s.items) _CartLine(item: i),
              const SizedBox(height: 24),
              _SectionTitle('Buyer'),
              const SizedBox(height: 8),
              _BuyerCard(buyer: s.buyer),
              const SizedBox(height: 24),
              _SectionTitle('Payment'),
              const SizedBox(height: 8),
              const _PaymentMethodCard(),
              const SizedBox(height: 24),
              _SectionTitle('Order summary'),
              const SizedBox(height: 8),
              _PriceRow(label: 'Subtotal', paisa: s.subtotalPaisa),
              const SizedBox(height: 6),
              _PriceRow(label: 'Fees', paisa: s.feesPaisa),
              const Divider(height: 24),
              _PriceRow(label: 'Total', paisa: s.totalPaisa, emphasised: true),
            ],
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(final BuildContext context) => Text(
    text,
    style: AppTextStyles.bodyBold.copyWith(color: AppColors.text500),
  );
}

class _CartLine extends StatelessWidget {
  const _CartLine({required this.item});
  final CartItem item;
  @override
  Widget build(final BuildContext context) {
    final int rs = item.lineTotalPaisa ~/ 100;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '${item.tier.name} × ${item.quantity}',
              style: AppTextStyles.bodyRegular.copyWith(
                color: AppColors.text500,
              ),
            ),
          ),
          Text(
            item.tier.isFree ? 'FREE' : 'Rs $rs',
            style: AppTextStyles.bodyBold.copyWith(color: AppColors.text500),
          ),
        ],
      ),
    );
  }
}

class _BuyerCard extends StatelessWidget {
  const _BuyerCard({required this.buyer});
  final BuyerDto? buyer;
  @override
  Widget build(final BuildContext context) {
    final BuyerDto? b = buyer;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.text30),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            b?.name ?? '—',
            style: AppTextStyles.bodyBold.copyWith(color: AppColors.text500),
          ),
          if ((b?.email ?? '').isNotEmpty) ...<Widget>[
            const SizedBox(height: 4),
            Text(
              b!.email!,
              style: AppTextStyles.captionRegular.copyWith(
                color: AppColors.text300,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard();
  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: _kAccentOrange),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.account_balance_wallet_outlined,
            color: _kAccentOrange,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Khalti',
              style: AppTextStyles.bodyBold.copyWith(color: AppColors.text500),
            ),
          ),
          const Icon(Icons.check_circle, color: _kAccentOrange, size: 20),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.paisa,
    this.emphasised = false,
  });
  final String label;
  final int paisa;
  final bool emphasised;

  @override
  Widget build(final BuildContext context) {
    final int rs = paisa ~/ 100;
    final TextStyle base = emphasised
        ? AppTextStyles.bodyBold
        : AppTextStyles.bodyRegular;
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: base.copyWith(
              color: emphasised ? AppColors.text500 : AppColors.text300,
            ),
          ),
        ),
        Text('Rs $rs', style: base.copyWith(color: AppColors.text500)),
      ],
    );
  }
}

class _PlaceOrderBar extends StatelessWidget {
  const _PlaceOrderBar();
  @override
  Widget build(final BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          buildWhen: (a, b) =>
              a.status != b.status || a.totalPaisa != b.totalPaisa,
          builder: (final BuildContext ctx, final CheckoutState s) {
            final bool busy = s.isInitiating || s.isVerifying;
            return Container(
              decoration: const BoxDecoration(
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
                          'Total',
                          style: AppTextStyles.captionRegular.copyWith(
                            color: AppColors.text300,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Rs ${s.totalPaisa ~/ 100}',
                          style: AppTextStyles.h4Bold.copyWith(
                            color: AppColors.text500,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  _PlaceOrderButton(
                    busy: busy,
                    onTap: busy
                        ? null
                        : () => ctx.read<CheckoutBloc>().add(
                            const CheckoutEvent.placeOrderTapped(),
                          ),
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

class _PlaceOrderButton extends StatelessWidget {
  const _PlaceOrderButton({required this.busy, required this.onTap});
  final bool busy;
  final VoidCallback? onTap;

  @override
  Widget build(final BuildContext context) {
    return Material(
      color: onTap == null ? AppColors.text20 : _kAccentOrange,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: busy
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                  ),
                )
              : Text(
                  'Place Order',
                  style: AppTextStyles.bodyBold.copyWith(
                    color: AppColors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
