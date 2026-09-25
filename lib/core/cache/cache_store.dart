class CacheEntry {
  const CacheEntry({required this.json, required this.cachedAt});

  /// JSON brut tel que renvoyé par l'API.
  final Object json;
  final DateTime cachedAt;
}

/// Cache clé/valeur de réponses JSON. Implémentation : [HiveCacheStore].
abstract interface class CacheStore {
  Future<CacheEntry?> read(String key);
  Future<void> write(String key, Object json);
  Future<void> delete(String key);
  Future<void> clear();
}
