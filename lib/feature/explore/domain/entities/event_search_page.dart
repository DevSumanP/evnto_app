import 'package:equatable/equatable.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

class EventSearchPage extends Equatable {
  const EventSearchPage({required this.events, required this.total});

  final List<Event> events;

  /// Total mathcing events across all pages (from the backend `meta.total`).
  final int total;

  @override
  List<Object?> get props => [events, total];
}
