import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather/presentation/widgets/temperature_range_bar.dart';

void main() {
  Future<Rect> pumpBar(WidgetTester tester, {required double min, required double max}) async {
    await tester.pumpWidget(MaterialApp(
      home: Center(
        child: SizedBox(
          width: 200,
          child: TemperatureRangeBar(min: min, max: max, rangeMin: 10, rangeMax: 30),
        ),
      ),
    ));
    final track = tester.getRect(find.byType(TemperatureRangeBar));
    final fill = tester.getRect(find.byKey(TemperatureRangeBar.fillKey));
    return Rect.fromLTRB(fill.left - track.left, 0, fill.right - track.left, 0);
  }

  testWidgets('fill spans min..max relative to the global range', (tester) async {
    final fill = await pumpBar(tester, min: 15, max: 25);
    expect(fill.left, moreOrLessEquals(50)); // (15 - 10) / 20 * 200
    expect(fill.right, moreOrLessEquals(150)); // (25 - 10) / 20 * 200
  });

  testWidgets('fill covers the whole track for the extreme day', (tester) async {
    final fill = await pumpBar(tester, min: 10, max: 30);
    expect(fill.left, moreOrLessEquals(0));
    expect(fill.right, moreOrLessEquals(200));
  });

  test('fractions are clamped and tolerate an empty range', () {
    expect(TemperatureRangeBar.fractions(min: 5, max: 40, rangeMin: 10, rangeMax: 30), (start: 0.0, end: 1.0));
    expect(TemperatureRangeBar.fractions(min: 20, max: 20, rangeMin: 20, rangeMax: 20), (start: 0.0, end: 1.0));
  });
}
