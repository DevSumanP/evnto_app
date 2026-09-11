// ==============================================================================
// lib/feature/home/presentation/widgets/sdui/section_registry.dart
// The SDUI component registry: turns one HomeSection into its widget.
// The switch is exhaustive because HomeSection is sealed — adding a new
// section variant is a compile error until it's handled here. An unknown
// section renders nothing (graceful skip / forward-compat).
// ==============================================================================

import 'package:flutter/material.dart';

import 'package:tap_app/feature/home/domain/entities/home_section.dart';

import 'hero_section.dart';
import 'interest_picker_section.dart';
import 'list_section.dart';
import 'next_ticket_section.dart';
import 'rail_section.dart';

Widget buildSection(final BuildContext context, final HomeSection section) {
  return switch (section) {
    HeroSection s => HeroSectionWidget(section: s),
    InterestPickerSection s => InterestPickerSectionWidget(section: s),
    NextTicketSection s => NextTicketSectionWidget(section: s),
    RailSection s => RailSectionWidget(section: s),
    ListSection s => ListSectionWidget(section: s),
    UnknownSection() => const SizedBox.shrink(),
  };
}
