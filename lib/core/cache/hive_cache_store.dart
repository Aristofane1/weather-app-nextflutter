import 'dart:convert';

import 'package:hive_ce/hive.dart';

import 'cache_store.dart';

/// Stocke chaque entrée sous forme de chaîne JSON `{json, cachedAt}` :
/// pas de TypeAdapter, et le format reste lisible.
class HiveCacheStore implements CacheStore {
  HiveCacheStore(this._box, {DateTime Function()? clock}) : _clock = clock ?? DateTime.now;

  static const boxName = 'cache';

  final Box<String> _box;
  final DateTime Function() _clock;

  @override
  Future<CacheEntry?> read(String key) async {
    final raw = _box.get(key);
    if (raw == null) return null;
    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      return CacheEntry(
        json: decoded['json'] as Object,
        cachedAt: DateTime.parse(decoded['cachedAt'] as String),
      );
    } catch (_) {
      await _box.delete(key);
      return null;
    }
  }

  @override
  Future<void> write(String key, Object json) =>
      _box.put(key, jsonEncode({'json': json, 'cachedAt': _clock().toIso8601String()}));

  @override
  Future<void> delete(String key) => _box.delete(key);

  @override
  Future<void> clear() async {
    await _box.clear();
  }
}
