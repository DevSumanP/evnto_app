//==============================================================================
// lib/feature/home/domain/entities/home_layout.dart/
// The decoded SDUI document: an ordered list of sections plus the resolved
// segment.
//[kSupportedHomeLayoutSchema] is the highest schemaVersion this    /
// client understands; anything newer triggers the legacy-layout fallback.
// ==============================================================================

import 'package:equatable/equatable.dart';
import 'package:tap_app/feature/home/domain/entities/home_section.dart';
import 'package:tap_app/feature/home/domain/entities/user_segment.dart';

/// Highest layout schema version this build can render.
const int kSupportedHomeLayoutSchema = 1;

class HomeLayout extends Equatable {
  const HomeLayout({
    required this.schemaVersion,
    required this.segment,
    required this.sections,
  });

  final int schemaVersion;
  final UserSegment segment;
  final List<HomeSection> sections;

  /// True which this build can render the layout's schema version.
  bool get isSupported => schemaVersion <= kSupportedHomeLayoutSchema;

  @override
  List<Object?> get props => <Object?>[schemaVersion, segment, sections];
}
