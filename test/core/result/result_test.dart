import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/result/result.dart';

void main() {
  test('map transforms data and keeps cache metadata', () {
    final at = DateTime(2026, 9, 24);
    final mapped = Success(2, fromCache: true, cachedAt: at).map((v) => 'v$v');
    expect(mapped, isA<Success<String>>());
    final success = mapped as Success<String>;
    expect(success.data, 'v2');
    expect(success.fromCache, isTrue);
    expect(success.cachedAt, at);
  });

  test('map keeps failure', () {
    final mapped = const Failed<int>(Failure.network()).map((v) => '$v');
    expect(mapped.failureOrNull, const Failure.network());
    expect(mapped.dataOrNull, isNull);
  });
}
