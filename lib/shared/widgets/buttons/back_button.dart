// ─── Back Button ─────────────────────────────────────────────
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3D3228).withValues(alpha: 0.04),
              blurRadius: 2,
            ),
            BoxShadow(
              color: const Color(0xFF706960).withValues(alpha: 0.16),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Color(0xFF2B2B2B),
          size: 20,
        ),
      ),
    );
  }
}
