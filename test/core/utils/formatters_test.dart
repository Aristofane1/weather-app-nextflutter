import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather_app/core/utils/formatters.dart';

void main() {
  setUpAll(() => initializeDateFormatting());

  test('formatDateTime per locale', () {
    final d = DateTime(2026, 9, 4, 8, 5);
    expect(formatDateTime(d, 'fr'), '04/09 à 08:05');
    expect(formatDateTime(d, 'en'), '09/04 at 8:05 AM');
  });

  test('formatDay returns today label or localized weekday + date', () {
    final now = DateTime(2026, 9, 24, 10);
    expect(formatDay(DateTime(2026, 9, 24), locale: 'fr', todayLabel: "Aujourd'hui", now: now), "Aujourd'hui");
    expect(formatDay(DateTime(2026, 9, 25), locale: 'fr', todayLabel: "Aujourd'hui", now: now), 'Vendredi 25/09');
    expect(formatDay(DateTime(2026, 9, 25), locale: 'en', todayLabel: 'Today', now: now), 'Friday 9/25');
  });

  test('capitalize', () {
    expect(capitalize('ciel dégagé'), 'Ciel dégagé');
    expect(capitalize(''), '');
  });

  test('countryFlag builds the emoji flag from an ISO code, case-insensitive', () {
    expect(countryFlag('FR'), '🇫🇷');
    expect(countryFlag('us'), '🇺🇸');
  });

  test('countryFlag falls back to a globe for missing or invalid codes', () {
    expect(countryFlag(null), '🌍');
    expect(countryFlag(''), '🌍');
    expect(countryFlag('F1'), '🌍');
    expect(countryFlag('FRA'), '🌍');
  });
}
