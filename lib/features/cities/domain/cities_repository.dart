import '../../../core/result/result.dart';
import 'city.dart';

abstract interface class CitiesRepository {
  /// Favoris de l'utilisateur connecté (offline-first).
  Stream<Result<List<City>>> watchFavorites();

  /// Recherche par nom (geocoding OWM), sans cache.
  Future<Result<List<City>>> search(String query);

  Future<Result<City>> addFavorite(City city);

  Future<Result<void>> removeFavorite(City city);
}
