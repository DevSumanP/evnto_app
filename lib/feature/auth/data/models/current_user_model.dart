// ==============================================================================
// lib/feature/auth/data/models/current_user_model.dart
// Wire model for GET /auth/v1/user. Supabase stores the signup display name
// under user_metadata.display_name (see auth_remote_data_source signup body),
// so we read it from there.
// ==============================================================================

import '../../domain/entities/current_user.dart';

class CurrentUserModel {
  const CurrentUserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.phone,
  });

  final String id;
  final String email;
  final String? displayName;
  final String? phone;

  factory CurrentUserModel.fromJson(final Map<String, dynamic> json) {
    final Object? meta = json['user_metadata'];
    final Map<String, dynamic>? metaMap =
        meta is Map<String, dynamic> ? meta : null;

    return CurrentUserModel(
      id: (json['id'] as String?)?.trim() ?? '',
      email: (json['email'] as String?)?.trim() ?? '',
      displayName: _nullIfEmpty((metaMap?['display_name'] as String?)?.trim()),
      phone: _nullIfEmpty((json['phone'] as String?)?.trim()),
    );
  }

  static String? _nullIfEmpty(final String? s) =>
      (s == null || s.isEmpty) ? null : s;

  CurrentUser toEntity() => CurrentUser(
        id: id,
        email: email,
        displayName: displayName,
        phone: phone,
      );
}
