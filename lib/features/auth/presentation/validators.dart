import '../../../l10n/l10n.dart';

final _emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

String? validateEmail(String? value, AppLocalizations l10n) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return l10n.emailRequired;
  if (!_emailRegExp.hasMatch(v)) return l10n.emailInvalid;
  return null;
}

String? validatePassword(String? value, AppLocalizations l10n) =>
    (value == null || value.isEmpty) ? l10n.passwordRequired : null;

/// Règle Supabase par défaut : 6 caractères minimum.
String? validateNewPassword(String? value, AppLocalizations l10n) {
  if (value == null || value.isEmpty) return l10n.passwordRequired;
  if (value.length < 6) return l10n.passwordTooShort;
  return null;
}
