import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/domain/weather.dart';

ForecastEntry entry(DateTime date, double min, double max, String icon) => ForecastEntry(
      date: date,
      temperature: (min + max) / 2,
      tempMin: min,
      tempMax: max,
      description: 'desc $icon',
      iconCode: icon,
    );

void main() {
  test('groups 3h steps by local day with min/max and midday icon', () {
    final days = groupByDay([
      entry(DateTime(2026, 9, 25, 9), 12, 15, '02d'),
      entry(DateTime(2026, 9, 24, 21), 10, 11, '01n'),
      entry(DateTime(2026, 9, 25, 12), 14, 19, '01d'),
      entry(DateTime(2026, 9, 25, 18), 13, 17, '03d'),
    ]);
    expect(days, hasLength(2));
    expect(days.first.day, DateTime(2026, 9, 24));
    final second = days.last;
    expect(second.day, DateTime(2026, 9, 25));
    expect(second.tempMin, 12);
    expect(second.tempMax, 19);
    expect(second.iconCode, '01d');
  });

  test('empty input gives empty list', () {
    expect(groupByDay(const []), isEmpty);
  });
}
