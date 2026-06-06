// ==============================================================================
// lib/feature/checkout/presentation/pages/khalti_webview_page.dart
// Hosts the Khalti payment page. Listens for the configured return URL
// (io.tapapp://khalti/callback?...) and pops with a typed KhaltiResult
// before the OS tries to launch the scheme.
// ==============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

/// Khalti payment outcomes. Mirrors the status values Khalti sends on the
/// return URL. `closed` covers the user backing out without paying.
enum KhaltiOutcome { completed, userCanceled, failed, pending, closed }

class KhaltiResult {
  const KhaltiResult({required this.outcome, this.pidx, this.transactionId});

  final KhaltiOutcome outcome;
  final String? pidx;
  final String? transactionId;
}

class KhaltiWebviewPage extends StatefulWidget {
  const KhaltiWebviewPage({
    super.key,
    required this.paymentUrl,
    this.returnUrlPrefix = 'https://tap.app/khalti/callback',
  });

  final String paymentUrl;

  /// Must match the backend's KHALTI_RETURN_URL (without query string).
  /// The webview cancels navigation to any URL starting with this prefix.
  final String returnUrlPrefix;

  @override
  State<KhaltiWebviewPage> createState() => _KhaltiWebviewPageState();
}

class _KhaltiWebviewPageState extends State<KhaltiWebviewPage> {
  bool _settled = false;

  void _settle(final KhaltiResult result) {
    if (_settled) return;
    _settled = true;
    Navigator.of(context).pop(result);
  }

  // shouldOverrideUrlLoading on Android does not always fire for
  // JS-initiated redirects (Khalti's success page uses window.location.replace).
  // onLoadStart catches those — we match the return URL prefix in both
  // places and the _settled flag dedupes.
  bool _tryHandleReturn(final Uri? uri) {
    if (uri == null) return false;
    if (!uri.toString().startsWith(widget.returnUrlPrefix)) return false;
    final params = uri.queryParameters;
    _settle(
      KhaltiResult(
        outcome: _outcomeFromStatus(params['status']),
        pidx: params['pidx'],
        transactionId: params['transaction_id'] ?? params['txnId'],
      ),
    );
    return true;
  }

  KhaltiOutcome _outcomeFromStatus(final String? status) {
    switch (status) {
      case 'Completed':
        return KhaltiOutcome.completed;
      case 'User canceled':
        return KhaltiOutcome.userCanceled;
      case 'Pending':
        return KhaltiOutcome.pending;
      case 'Failed':
      case 'Expired':
        return KhaltiOutcome.failed;
      default:
        return KhaltiOutcome.failed;
    }
  }

  @override
  Widget build(final BuildContext context) {
    // No PopScope here: the natural back-button pop returns null to the
    // awaiting OrderReviewPage listener, which treats null as "canceled".
    return SafeArea(
      child: Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(widget.paymentUrl)),
          initialSettings: InAppWebViewSettings(
            javaScriptEnabled: true,
            useShouldOverrideUrlLoading: true,
          ),
          shouldOverrideUrlLoading: (controller, action) async {
            if (_tryHandleReturn(action.request.url)) {
              return NavigationActionPolicy.CANCEL;
            }
            return NavigationActionPolicy.ALLOW;
          },
          onLoadStart: (controller, url) async {
            if (_tryHandleReturn(url)) {
              await controller.stopLoading();
            }
          },
          onUpdateVisitedHistory: (controller, url, androidIsReload) {
            _tryHandleReturn(url);
          },
        ),
      ),
    );
  }
}
