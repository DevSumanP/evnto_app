// ==============================================================================
// lib/feature/home/domain/entities/home_section.dart
// The sealed set of renderable Home sections (the SDUI building blocks).
//
// Each variant carries ONLY the typed data its widget needs. Embedded event
// data reuses the existing [Event] entity — we do not invent a new event type.
// The section_registry switches over this sealed type to pick a widget; the
// `sealed` keyword makes that switch exhaustive at compile time.
// ==============================================================================

import 'package:equatable/equatable.dart';

import 'event_entity.dart';
import 'section_type.dart';

sealed class HomeSection extends Equatable {
  const HomeSection();

  @override
  List<Object?> get props => const <Object?>[];
}

/// Cold-start welcome banner with a single call-to-action (newcomer).
class HeroSection extends HomeSection {
  const HeroSection({required this.title, this.subtitle, this.ctaLabel});

  final String title;
  final String? subtitle;
  final String? ctaLabel;

  @override
  List<Object?> get props => <Object?>[title, subtitle, ctaLabel];
}

/// Interest chips. Selecting a chip writes to StorageService.setHomeInterests.
/// [options] may be empty — the widget falls back to a default category set.
class InterestPickerSection extends HomeSection {
  const InterestPickerSection({
    required this.title,
    this.selected = const <String>[],
    this.options = const <String>[],
  });

  final String title;
  final List<String> selected;
  final List<String> options;

  @override
  List<Object?> get props => <Object?>[title, selected, options];
}

/// The caller's soonest usable upcoming ticket (regular). Reuses [Event] for
/// the event data; [ticketId] drives navigation to the QR screen.
class NextTicketSection extends HomeSection {
  const NextTicketSection({
    required this.event,
    required this.ticketId,
    required this.status,
  });

  final Event event;
  final String ticketId;
  final String status;

  @override
  List<Object?> get props => <Object?>[event, ticketId, status];
}

/// Horizontal scroller of event cards. [style] picks the card layout.
class RailSection extends HomeSection {
  const RailSection({
    required this.title,
    required this.items,
    this.style = CardStyle.popular,
  });

  final String title;
  final List<Event> items;
  final CardStyle style;

  @override
  List<Object?> get props => <Object?>[title, items, style];
}

/// Vertical list of event cards (e.g. "Suggestion for you").
class ListSection extends HomeSection {
  const ListSection({required this.title, required this.items});

  final String title;
  final List<Event> items;

  @override
  List<Object?> get props => <Object?>[title, items];
}

/// A section whose wire `type` the client does not understand. Rendered as
/// nothing — present so an unknown type degrades gracefully instead of
/// blanking the screen.
class UnknownSection extends HomeSection {
  const UnknownSection(this.rawType);

  final String rawType;

  @override
  List<Object?> get props => <Object?>[rawType];
}
