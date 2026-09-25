import 'package:hive_ce/hive.dart';

/// Préférences clé/valeur (ex. langue choisie).
abstract interface class SettingsStore {
  String? read(String key);
  Future<void> write(String key, String? value);
}

class HiveSettingsStore implements SettingsStore {
  HiveSettingsStore(this._box);

  static const boxName = 'settings';
  final Box<String> _box;

  @override
  String? read(String key) => _box.get(key);

  @override
  Future<void> write(String key, String? value) => value == null ? _box.delete(key) : _box.put(key, value);
}

/// Implémentation en mémoire (tests, tests d'intégration).
class MemorySettingsStore implements SettingsStore {
  final _values = <String, String>{};

  @override
  String? read(String key) => _values[key];

  @override
  Future<void> write(String key, String? value) async {
    if (value == null) {
      _values.remove(key);
    } else {
      _values[key] = value;
    }
  }
}
