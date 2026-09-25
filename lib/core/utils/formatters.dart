import 'package:intl/intl.dart';

/// FR « 24/09 à 14:05 », EN « 09/24 at 2:05 PM ».
String formatDateTime(DateTime d, String locale) =>
    DateFormat(locale == 'fr' ? "dd/MM 'à' HH:mm" : "MM/dd 'at' h:mm a", locale).format(d);

/// « Aujourd'hui » / « Today », sinon FR « Jeudi 25/09 », EN « Thursday 9/25 ».
String formatDay(DateTime day, {required String locale, required String todayLabel, DateTime? now}) {
  final today = now ?? DateTime.now();
  if (day.year == today.year && day.month == today.month && day.day == today.day) return todayLabel;
  return capitalize(DateFormat(locale == 'fr' ? 'EEEE dd/MM' : 'EEEE M/d', locale).format(day));
}

String capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

/// Drapeau emoji d'un code pays ISO 3166-1 alpha-2 (« FR » → 🇫🇷), 🌍 si absent ou invalide.
String countryFlag(String? isoCode) {
  final code = isoCode?.toUpperCase() ?? '';
  if (!RegExp(r'^[A-Z]{2}$').hasMatch(code)) return '🌍';
  // Chaque lettre devient un « regional indicator symbol » (U+1F1E6 = A).
  return String.fromCharCodes(code.codeUnits.map((c) => 0x1F1E6 + c - 0x41));
}
