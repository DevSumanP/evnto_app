import 'package:injectable/injectable.dart';
import 'package:tap_app/core/services/storage_service.dart';

/// Persists the user's recent Exlpore searches (most-recent first , de-duped, capped).
/// Backed by StoreageService so it rides the same prefs instance.
@lazySingleton
class RecentSearchesStore {
  const RecentSearchesStore(this._storage);

  final StorageService _storage;

  static const String _key = 'explore_recent_searches';
  static const int _max = 8;

  List<String> read() => _storage.getStringList(_key) ?? const <String>[];

  /// Add [raw] to the top and return the updated list. No-op for the blank input.
  Future<List<String>> add(final String raw) async {
    final String q = raw.trim();
    if (q.isEmpty) return read();
    final List<String> next = <String>[...read()]
      ..removeWhere((e) => e.toLowerCase() == q.toLowerCase())
      ..insert(0, q);

    final List<String> capped = next.take(_max).toList(growable: false);

    await _storage.setStringList(_key, capped);

    return capped;
  }

  Future<List<String>> clear() async {
    await _storage.remove(_key);
    return const <String>[];
  }
}
