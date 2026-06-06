// ==============================================================================
// lib/core/theme/app_shadows.dart
// Elevation system converted from Figma design tokens
// Use AppShadows.elevationXX on BoxDecoration.boxShadow
// ==============================================================================

import 'package:flutter/material.dart';

abstract final class AppShadows {
  AppShadows._();

  // ==========================================================================
  // Elevation / -01  –  Inset shadow
  // Figma: inset 0px 0.5px 4px 0px rgba(112, 105, 96, 0.32)
  //
  // NOTE: Flutter's BoxShadow does not support true CSS inset shadows.
  // Use this on a PhysicalModel or render it via a CustomPainter if needed.
  // The list below approximates the look with a blurStyle: BlurStyle.inner.
  // ==========================================================================

  static const List<BoxShadow> elevationInset = [
    BoxShadow(
      color: Color(0x52706960), // rgba(112, 105, 96, 0.32)
      offset: Offset(0, 0.5),
      blurRadius: 4,
      spreadRadius: 0,
      blurStyle: BlurStyle.inner,
    ),
  ];

  // ==========================================================================
  // Elevation / 00  –  Base (no shadow)
  // Figma: 0px 0px 0px 0px rgba(0, 0, 0, 0)
  // ==========================================================================

  static const List<BoxShadow> elevation00 = [];

  // ==========================================================================
  // Elevation / 01  –  Subtle lift
  // Figma: 0px 0.5px 2px rgba(112,96,96,0.16)
  //      + 0px 0px 1px rgba(61,40,40,0.08)
  // ==========================================================================

  static const List<BoxShadow> elevation01 = [
    BoxShadow(
      color: Color(0x29706060), // rgba(112, 96, 96, 0.16)
      offset: Offset(0, 0.5),
      blurRadius: 2,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x143D2828), // rgba(61, 40, 40, 0.08)
      offset: Offset(0, 0),
      blurRadius: 1,
      spreadRadius: 0,
    ),
  ];

  // ==========================================================================
  // Elevation / 02  –  Card resting
  // Figma: 0px 2px 4px rgba(112,105,96,0.16)
  //      + 0px 0px 1px rgba(61,50,40,0.04)
  // ==========================================================================

  static const List<BoxShadow> elevation02 = [
    BoxShadow(
      color: Color(0x29706960), // rgba(112, 105, 96, 0.16)
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A3D3228), // rgba(61, 50, 40, 0.04)
      offset: Offset(0, 0),
      blurRadius: 1,
      spreadRadius: 0,
    ),
  ];

  // ==========================================================================
  // Elevation / 03  –  Card hover / raised
  // Figma: 0px 4px 8px rgba(112,105,96,0.16)
  //      + 0px 0px 2px rgba(61,50,40,0.04)
  // ==========================================================================

  static const List<BoxShadow> elevation03 = [
    BoxShadow(
      color: Color(0x29706960), // rgba(112, 105, 96, 0.16)
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A3D3228), // rgba(61, 50, 40, 0.04)
      offset: Offset(0, 0),
      blurRadius: 2,
      spreadRadius: 0,
    ),
  ];

  // ==========================================================================
  // Elevation / 04  –  Dropdown / popover
  // Figma: 0px 8px 16px rgba(112,105,96,0.16)
  //      + 0px 2px 4px rgba(61,50,40,0.04)
  // ==========================================================================

  static const List<BoxShadow> elevation04 = [
    BoxShadow(
      color: Color(0x29706960), // rgba(112, 105, 96, 0.16)
      offset: Offset(0, 8),
      blurRadius: 16,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A3D3228), // rgba(61, 50, 40, 0.04)
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];

  // ==========================================================================
  // Elevation / 05  –  Modal / dialog
  // Figma: 0px 16px 24px rgba(112,105,96,0.16)
  //      + 0px 2px 8px rgba(61,50,40,0.04)
  // ==========================================================================

  static const List<BoxShadow> elevation05 = [
    BoxShadow(
      color: Color(0x29706960), // rgba(112, 105, 96, 0.16)
      offset: Offset(0, 16),
      blurRadius: 24,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A3D3228), // rgba(61, 50, 40, 0.04)
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  // ==========================================================================
  // Elevation / 06  –  Drawer / overlay panel
  // Figma: 0px 20px 32px rgba(112,105,96,0.24)
  //      + 0px 2px 8px rgba(61,50,40,0.08)
  // ==========================================================================

  static const List<BoxShadow> elevation06 = [
    BoxShadow(
      color: Color(0x3D706960), // rgba(112, 105, 96, 0.24)
      offset: Offset(0, 20),
      blurRadius: 32,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x143D3228), // rgba(61, 50, 40, 0.08)
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
    ),
  ];

  // ==========================================================================
  // Extra tokens from Figma (named "11" and "12")
  // ==========================================================================

  /// Large ambient shadow  –  token "11"
  /// Figma: 0px 3px 250px rgba(0,0,0,0.12)
  static const List<BoxShadow> ambient = [
    BoxShadow(
      color: Color(0x1F000000), // rgba(0, 0, 0, 0.12)
      offset: Offset(0, 3),
      blurRadius: 250,
      spreadRadius: 0,
    ),
  ];

  /// Soft card shadow  –  token "12"
  /// Figma: 0px 2px 12px rgba(0,0,0,0.06)
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x0F000000), // rgba(0, 0, 0, 0.06)
      offset: Offset(0, 2),
      blurRadius: 12,
      spreadRadius: 0,
    ),
  ];

  // --11: 0px 3px 250px rgba(0, 0, 0, 0.12)
  static const List<BoxShadow> shadow11 = [
    BoxShadow(color: Color(0x1F000000), offset: Offset(0, 3), blurRadius: 250),
  ];

  // --12: 0px 2px 12px rgba(0, 0, 0, 0.06)
  static const List<BoxShadow> shadow12 = [
    BoxShadow(color: Color(0x0F000000), offset: Offset(0, 2), blurRadius: 12),
  ];

  // --13: inset 0px 1px 2px rgba(0, 0, 0, 0.02), 0px 2px 20px rgba(74, 108, 247, 0.08)
  static const List<BoxShadow> shadow13 = [
    BoxShadow(
      color: Color(0x05000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
      // Flutter's BoxShadow doesn't support inset natively.
      // To achieve an inset effect, apply this shadow to an
      // inner Container or use a CustomPainter / InnerShadow widget.
    ),
    BoxShadow(color: Color(0x144A6CF7), offset: Offset(0, 2), blurRadius: 20),
  ];
}
