import 'package:flutter/material.dart';

/// Shows a bottom sheet with a bouncy (elasticOut) animation.
Future<T?> showBouncyBottomSheet<T>(
  BuildContext context, {
  required Widget child,
  Color? backgroundColor,
  bool barrierDismissible = true,
}) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 900),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          clipBehavior: Clip.antiAlias,
          child: child,
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curve = animation.status == AnimationStatus.reverse
          ? Curves.easeInExpo
          : Curves.easeOutBack;
      final curvedValue = curve.transform(animation.value);
      return Transform.translate(
        offset: Offset(0, 100 * (1 - curvedValue)),
        child: child,
      );
    },
  );
}
