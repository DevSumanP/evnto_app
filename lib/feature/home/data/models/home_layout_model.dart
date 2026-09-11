import 'package:tap_app/feature/home/data/models/event_model.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';
import 'package:tap_app/feature/home/domain/entities/home_layout.dart';
import 'package:tap_app/feature/home/domain/entities/home_section.dart';
import 'package:tap_app/feature/home/domain/entities/section_type.dart';
import 'package:tap_app/feature/home/domain/entities/user_segment.dart';

abstract final class HomeLayoutModel {
  HomeLayoutModel._();

  /// Entry point: turn the whole decoded JSON object into a [HomeLayout].
  static HomeLayout parse(final Map<String, dynamic> json) {
    final List<HomeSection> sections = <HomeSection>[];

    // The "sections" key should be a JSON array. Walk it and parse each entry.
    final Object? rawSections = json['sections'];
    if (rawSections is List) {
      for (final Object? entry in rawSections) {
        final Map<String, dynamic>? sectionJson = readMap(entry);
        // Skip anything that isn't JSON object.
        if (sectionJson != null) {
          sections.add(parseSection(sectionJson));
        }
      }
    }

    return HomeLayout(
      schemaVersion: readInt(json['schemaVersion']) ?? 1,
      segment: parseSegment(json['segment']),
      sections: sections,
    );
  }

  // ─── One section at a time ────────────────────────────────────────────────

  /// Build the right section object based on the JSON "type" field.
  static HomeSection parseSection(final Map<String, dynamic> json) {
    final SectionType type = SectionType.fromWire(json['type'] as String?);

    switch (type) {
      case SectionType.hero:
        return HeroSection(
          title: readString(json['title']) ?? '',
          subtitle: readString(json['subtitle']),
          ctaLabel: readString(json['ctaLabel']),
        );

      case SectionType.interestPicker:
        return InterestPickerSection(
          title: readString(json['title']) ?? '',
          selected: parseStringList(json['selected']),
          options: parseStringList(json['options']),
        );

      case SectionType.nextTicket:
        // next_ticket must carry an "event" object. If it's missing or broken,
        // fall back to an UnknownSection so the screen stil renders.
        final Map<String, dynamic>? eventJson = readMap(json['event']);
        final Event? event = eventJson == null
            ? null
            : parseSingleEvent(eventJson);
        if (event == null) {
          return const UnknownSection('next_ticket');
        }

        return NextTicketSection(
          event: event,
          // Accept either "ticketId" or "ticket_id" spelling.
          ticketId:
              readString(json['ticketId']) ??
              readString(json['ticket_id']) ??
              '',
          status: readString(json['status']) ?? 'issued',
        );
      case SectionType.rail:
        return RailSection(
          title: readString(json['title']) ?? '',
          items: parseEventList(json['items']),
          style: CardStyle.fromWire(json['style'] as String?),
        );

      case SectionType.list:
        return ListSection(
          title: readString(json['title']) ?? '',
          items: parseEventList(json['items']),
        );

      case SectionType.unknown:
        // A type string we don't understand. Keep the raw value for debugging.
        return UnknownSection((json['type'] as String?) ?? 'unknown');
    }
  }

  // ─── Small, reusable parsing helpers ──────────────────────────────────────

  /// Map the "segment" string to enum. Anything unexpected -> newcomer.
  static UserSegment parseSegment(final Object? raw) {
    switch (raw) {
      case 'regular':
        return UserSegment.regular;
      case 'explorer':
        return UserSegment.explorer;
      default:
        return UserSegment.newcomer;
    }
  }

  /// Parse a JSON array of event objects into a list of [Event]s. Any single
  /// event that fails to parse is skipped, so one bad row can't blank the rail.
  static List<Event> parseEventList(final Object? raw) {
    if (raw is! List) return const <Event>[];

    final List<Event> events = <Event>[];
    for (final Object? entry in raw) {
      final Map<String, dynamic>? eventJson = readMap(entry);
      if (eventJson == null) continue;

      final Event? event = parseSingleEvent(eventJson);
      if (event != null && event.title.isNotEmpty) {
        events.add(event);
      }
    }

    return events;
  }

  /// Parse one event object. Reuses the existing EventModel parser. Returns
  /// null (instead of throwing) when the row is malformed.
  static Event? parseSingleEvent(final Map<String, dynamic> json) {
    try {
      return EventModel.fromJson(json).toEntity();
    } on Object catch (_) {
      return null;
    }
  }

  /// Parse a JSON array of strings, dropping nulls, non-strings, and blanks.
  static List<String> parseStringList(final Object? raw) {
    if (raw is! List) return const <String>[];

    final List<String> result = <String>[];
    for (final Object? entry in raw) {
      if (entry is String && entry.trim().isNotEmpty) {
        result.add(entry.trim());
      }
    }
    return result;
  }

  /// Read a JSON value as a Map, or return null if it isn't one.
  static Map<String, dynamic>? readMap(final Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  /// Read a JSON value as a trimmed, non-empty String, or null otherwise.
  static String? readString(final Object? value) {
    if (value is String && value.trim().isNotEmpty) {
      return value.trim();
    }
    return null;
  }

  /// Read a JSON value as an int, tolerating numbers and numeric strings.
  static int? readInt(final Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
