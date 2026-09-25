String _two(int n) => n.toString().padLeft(2, '0');

const _weekdays = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche'];

/// « 24/09 à 14:05 »
String formatDateTime(DateTime d) => '${_two(d.day)}/${_two(d.month)} à ${_two(d.hour)}:${_two(d.minute)}';

/// « Aujourd'hui » ou « Jeudi 25/09 »
String formatDay(DateTime day, {DateTime? now}) {
  final today = now ?? DateTime.now();
  if (day.year == today.year && day.month == today.month && day.day == today.day) return "Aujourd'hui";
  return '${_weekdays[day.weekday - 1]} ${_two(day.day)}/${_two(day.month)}';
}

String capitalize(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
