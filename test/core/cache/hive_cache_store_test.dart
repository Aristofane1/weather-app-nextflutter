import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:weather_app/core/cache/hive_cache_store.dart';

void main() {
  late Directory dir;
  late Box<String> box;
  late HiveCacheStore store;
  final now = DateTime(2026, 9, 24, 14, 5);

  setUp(() async {
    dir = await Directory.systemTemp.createTemp('hive_cache_test');
    Hive.init(dir.path);
    box = await Hive.openBox<String>('cache_test');
    store = HiveCacheStore(box, clock: () => now);
  });

  tearDown(() async {
    await Hive.close();
    await dir.delete(recursive: true);
  });

  test('write then read returns json and timestamp', () async {
    await store.write('k', {'temp': 20, 'list': [1, 2]});
    final entry = await store.read('k');
    expect(entry!.json, {'temp': 20, 'list': [1, 2]});
    expect(entry.cachedAt, now);
  });

  test('missing key returns null', () async {
    expect(await store.read('nope'), isNull);
  });

  test('corrupt entry returns null and is removed', () async {
    await box.put('bad', 'not json');
    expect(await store.read('bad'), isNull);
    expect(box.containsKey('bad'), isFalse);
  });

  test('clear removes everything', () async {
    await store.write('a', 1);
    await store.write('b', 2);
    await store.clear();
    expect(box.isEmpty, isTrue);
  });
}
