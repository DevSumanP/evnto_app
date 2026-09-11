// ─── Back Button ─────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:tap_app/core/theme/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double iconSize;
  final double size;
  final double borderRadius;
  final double borderWidth;
  final Color borderColor;
  final double elevation;
  final Color shadowColor;
  final EdgeInsetsGeometry padding;
  final bool enableHaptic;
  final Duration animationDuration;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.iconColor = const Color(0xFF2B2B2B),
    this.backgroundColor = AppColors.primarymain,
    this.iconSize = 20,
    this.size = 40,
    this.borderRadius = 100,
    this.borderWidth = 1,
    this.borderColor = Colors.transparent,
    this.elevation = 0.0,
    this.padding = EdgeInsets.zero,
    this.enableHaptic = true,
    this.animationDuration = const Duration(milliseconds: 250),
    this.shadowColor = AppColors.primarymain,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Icon(icon, color: iconColor, size: iconSize),
      ),
    );
  }
}
