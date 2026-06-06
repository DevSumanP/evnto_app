// ==============================================================================
// lib/feature/auth/domain/validators/email_validator.dart
// Pure validator. Returns a typed error or null. Keeping the error as an enum
// lets the UI layer choose the wording (or translate it).
// ==============================================================================

enum EmailError { empty, invalidFormat }

abstract final class EmailValidator {
  EmailValidator._();

  // Intentionally permissive. Real address validation happens server-side.
  static final RegExp _pattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static EmailError? validate(final String raw) {
    final String value = raw.trim();
    if (value.isEmpty) return EmailError.empty;
    if (!_pattern.hasMatch(value)) return EmailError.invalidFormat;
    return null;
  }

  static String message(final EmailError error) {
    switch (error) {
      case EmailError.empty:
        return 'Email is required';
      case EmailError.invalidFormat:
        return 'Enter a valid email address';
    }
  }
}
