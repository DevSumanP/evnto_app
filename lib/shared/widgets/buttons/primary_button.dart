import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_app/core/theme/app_text_style.dart';

import '../../../core/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.label,
    this.icon,
    this.iconRight = false,
    this.onPressed,
    this.onLongPress,
    this.isLoading = false,
    this.isDisabled = false,
    this.isSuccess = false,
    this.isError = false,
    this.backgroundColor = AppColors.primary500,
    this.gradient,
    this.textColor = AppColors.white,
    this.disabledColor,
    this.borderColor,
    this.borderWidth = 1,
    this.elevation = 0.0,
    this.borderRadius = 999.0,
    this.textStyle,
    this.shadowColor,
    this.height = 51.0,
    this.width,
    this.padding,
    this.enableHaptic = true,
    this.animationDuration = const Duration(milliseconds: 250),
  });

  final String? label;
  final Widget? icon;
  final bool iconRight;

  /// Callback function to be called when the button is pressed
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;

  // States
  final bool isLoading;
  final bool isDisabled;
  final bool isSuccess;
  final bool isError;

  /// Visual properties
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? textColor;
  final Color? disabledColor;
  final Color? borderColor;
  final double borderWidth;
  final double elevation;
  final double borderRadius;
  final TextStyle? textStyle;
  final Color? shadowColor;

  /// Size properties
  final double height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  /// Behavior properties
  final bool enableHaptic;
  final Duration animationDuration;

  @override
  Widget build(final BuildContext context) {
    final bool isButtonEnabled = !isDisabled && !isLoading && onPressed != null;

    return AnimatedContainer(
      duration: animationDuration,
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: isButtonEnabled ? gradient : null,
        color: !isButtonEnabled
            ? (disabledColor ?? AppColors.grey400)
            : gradient == null
            ? backgroundColor
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth,
        ),
        boxShadow: elevation >= 0 && isButtonEnabled
            ? [
                BoxShadow(
                  color: shadowColor ?? Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 10),
                  blurRadius: 15,
                  spreadRadius: -3,
                ),
                BoxShadow(
                  color: shadowColor ?? Colors.black.withValues(alpha: 0.1),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -4,
                ),
              ]
            : [],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: isButtonEnabled
              ? () async {
                  if (enableHaptic) {
                    await HapticFeedback.selectionClick();
                  }
                  onPressed?.call();
                }
              : null,
          onLongPress: isButtonEnabled ? onLongPress : null,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding:
                padding ??
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Center(
              child: AnimatedSwitcher(
                duration: animationDuration,
                child: _buildChild(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChild(final BuildContext context) {
    /// Loading
    if (isLoading) {
      return SizedBox(
        key: const ValueKey('_loading'),
        height: 20,
        width: 20,
        child: CircularProgressIndicator(strokeWidth: 2.5, color: textColor),
      );
    }

    /// Success
    if (isSuccess) {
      return SizedBox(
        key: const ValueKey('_success'),
        height: 20,
        width: 20,
        child: Icon(Icons.check, color: textColor, size: 20),
      );
    }

    /// Error
    if (isError) {
      return SizedBox(
        key: const ValueKey('_error'),
        height: 20,
        width: 20,
        child: Icon(Icons.error, color: textColor, size: 20),
      );
    }

    /// Default text style
    final defaultTextStyle = AppTextStyles.bodyMedium.copyWith(
      fontSize: 14,
      letterSpacing: 0.25,
      fontWeight: FontWeight.w600,
      color: textColor,
    );

    final effectiveTextStyle = textStyle ?? defaultTextStyle;

    /// Default
    return Row(
      key: const ValueKey('_default'),
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null && !iconRight) ...[
          IconTheme(
            data: IconThemeData(color: textColor, size: 14),
            child: icon!,
          ),
          if (label != null) const SizedBox(width: 8),
        ],
        if (label != null) Text(label!, style: effectiveTextStyle),
        if (icon != null && iconRight) ...[
          if (label != null) const SizedBox(width: 8),
          IconTheme(
            data: IconThemeData(color: textColor, size: 14),
            child: icon!,
          ),
        ],
      ],
    );
  }
}
