// ==============================================================================
// lib/feature/auth/domain/validators/password_validator.dart
// Minimum-length only. The server is the source of truth for strength rules.
// ==============================================================================

enum PasswordError { empty, tooShort }

abstract final class PasswordValidator {
  PasswordValidator._();

  static const int minLength = 6;

  static PasswordError? validate(final String value) {
    if (value.isEmpty) return PasswordError.empty;
    if (value.length < minLength) return PasswordError.tooShort;
    return null;
  }

  static String message(final PasswordError error) {
    switch (error) {
      case PasswordError.empty:
        return 'Password is required';
      case PasswordError.tooShort:
        return 'Password must be at least $minLength characters';
    }
  }
}
