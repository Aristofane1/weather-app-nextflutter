final _emailRegExp = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

String? validateEmail(String? value) {
  final v = value?.trim() ?? '';
  if (v.isEmpty) return 'Email requis';
  if (!_emailRegExp.hasMatch(v)) return 'Email invalide';
  return null;
}

String? validatePassword(String? value) => (value == null || value.isEmpty) ? 'Mot de passe requis' : null;

/// Règle Supabase par défaut : 6 caractères minimum.
String? validateNewPassword(String? value) {
  if (value == null || value.isEmpty) return 'Mot de passe requis';
  if (value.length < 6) return '6 caractères minimum';
  return null;
}
