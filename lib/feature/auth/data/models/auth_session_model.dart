// ==============================================================================
// lib/feature/auth/data/models/auth_session_model.dart
// Wire model for Supabase Auth password grant. Owns JSON parsing.
//
// Response shape (relevant fields only):
// {
//   "access_token": "...",
//   "refresh_token": "...",
//   "expires_in": 3600,
//   "token_type": "bearer",
//   "user": { "id": "...", "email": "...", ... }
// }
// ==============================================================================

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/auth_session.dart';

class AuthSessionModel {
  const AuthSessionModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.userId,
    required this.email,
  });

  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String userId;
  final String email;

  factory AuthSessionModel.fromJson(final Map<String, dynamic> json) {
    final String? token = _asString(json['access_token']);
    if (token == null || token.isEmpty) {
      throw const JsonParsingException(
        message: 'Missing access_token in auth response',
      );
    }

    final Object? userRaw = json['user'];
    final Map<String, dynamic> user = userRaw is Map<String, dynamic>
        ? userRaw
        : const <String, dynamic>{};

    return AuthSessionModel(
      accessToken: token,
      refreshToken: _asString(json['refresh_token']) ?? '',
      expiresIn: _asInt(json['expires_in']) ?? 3600,
      userId: _asString(user['id']) ?? '',
      email: _asString(user['email']) ?? '',
    );
  }

  AuthSession toEntity() => AuthSession(
    accessToken: accessToken,
    refreshToken: refreshToken,
    expiresIn: Duration(seconds: expiresIn),
    userId: userId,
    email: email,
  );

  static String? _asString(final Object? value) =>
      value is String ? value : null;

  static int? _asInt(final Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
