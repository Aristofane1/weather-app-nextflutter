import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/utils/formatters.dart';

void main() {
  test('formatDateTime pads values', () {
    expect(formatDateTime(DateTime(2026, 9, 4, 8, 5)), '04/09 à 08:05');
  });

  test('formatDay returns Aujourd\'hui or weekday + date', () {
    final now = DateTime(2026, 9, 24, 10);
    expect(formatDay(DateTime(2026, 9, 24), now: now), "Aujourd'hui");
    expect(formatDay(DateTime(2026, 9, 25), now: now), 'Vendredi 25/09');
  });

  test('capitalize', () {
    expect(capitalize('ciel dégagé'), 'Ciel dégagé');
    expect(capitalize(''), '');
  });
}
