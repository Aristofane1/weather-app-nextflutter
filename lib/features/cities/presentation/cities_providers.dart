import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/error/failure.dart';
import '../../../core/result/result.dart';
import '../data/cities_repository_impl.dart';
import '../domain/city.dart';

part 'cities_providers.g.dart';

@riverpod
Stream<Result<List<City>>> favorites(Ref ref) => ref.watch(citiesRepositoryProvider).watchFavorites();

@riverpod
Future<Result<List<City>>> citySearch(Ref ref, String query) => ref.watch(citiesRepositoryProvider).search(query);

/// Actions d'écriture sur les favoris. Elles rafraîchissent la liste en cas de succès.
@Riverpod(keepAlive: true)
class FavoritesController extends _$FavoritesController {
  @override
  void build() {}

  Future<Failure?> add(City city) async {
    final result = await ref.read(citiesRepositoryProvider).addFavorite(city);
    if (result is Success) ref.invalidate(favoritesProvider);
    return result.failureOrNull;
  }

  Future<Failure?> remove(City city) async {
    final result = await ref.read(citiesRepositoryProvider).removeFavorite(city);
    if (result is Success) ref.invalidate(favoritesProvider);
    return result.failureOrNull;
  }
}
