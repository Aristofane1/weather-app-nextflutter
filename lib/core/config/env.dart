import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Variable obligatoire absente ou vide dans `.env` (message traduit par `ConfigErrorApp`).
class MissingEnvKey implements Exception {
  const MissingEnvKey(this.key);

  final String key;

  @override
  String toString() => 'MissingEnvKey($key)';
}

/// Accès typé aux variables du fichier `.env` (chargé dans `main`).
abstract final class Env {
  static String get supabaseUrl => _require('SUPABASE_URL');
  static String get supabaseAnonKey => _require('SUPABASE_ANON_KEY');
  static String get owmApiKey => _require('OWM_API_KEY');

  /// Échoue au démarrage plutôt qu'au premier appel réseau.
  static void validate() {
    supabaseUrl;
    supabaseAnonKey;
    owmApiKey;
  }

  static String _require(String key) {
    final value = dotenv.maybeGet(key);
    if (value == null || value.isEmpty) {
      throw MissingEnvKey(key);
    }
    return value;
  }
}
