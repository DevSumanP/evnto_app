// ==============================================================================
// lib/feature/home/domain/entities/section_type.dart
// The closed set of SDUI section kinds the client knows how to render.
//
// Any wire `type` string we do NOT recognise maps to [SectionType.unknown] so
// the backend can ship a new section type before every client supports it —
// older clients skip it instead of crashing (forward-compat).
// ==============================================================================

enum SectionType {
  hero,
  interestPicker,
  nextTicket,
  rail,
  list,
  unknown;

  /// Maps a wire string to a [SectionType]. Unrecognised values → [unknown].
  static SectionType fromWire(final String? raw) {
    switch (raw) {
      case 'hero':
        return SectionType.hero;
      case 'interest_picker':
        return SectionType.interestPicker;
      case 'next_ticket':
        return SectionType.nextTicket;
      case 'rail':
        return SectionType.rail;
      case 'list':
        return SectionType.list;
      default:
        return SectionType.unknown;
    }
  }
}

/// Which card layout a [RailSection] should use for its event items.
/// `popular` → image-top card, `upcoming` → image-left card.
enum CardStyle {
  popular,
  upcoming;

  static CardStyle fromWire(final String? raw) =>
      raw == 'upcoming' ? CardStyle.upcoming : CardStyle.popular;
}
