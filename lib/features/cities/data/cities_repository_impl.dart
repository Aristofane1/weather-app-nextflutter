import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/core_providers.dart';
import '../../../core/error/failure.dart';
import '../../../core/repository/base_repository.dart';
import '../../../core/result/result.dart';
import '../domain/cities_repository.dart';
import '../domain/city.dart';
import 'cities_remote_data_source.dart';
import 'dtos/city_dto.dart';

part 'cities_repository_impl.g.dart';

class CitiesRepositoryImpl extends BaseRepository implements CitiesRepository {
  CitiesRepositoryImpl({required this.remote, required super.cache, required super.networkInfo});

  /// Pas d'userId dans la clé : le cache est vidé au logout.
  static const favoritesKey = 'cities:favorites';

  final CitiesRemoteDataSource remote;

  @override
  Stream<Result<List<City>>> watchFavorites() =>
      offlineFirst(cacheKey: favoritesKey, fetch: remote.fetchFavorites, parse: _parseCities);

  @override
  Future<Result<List<City>>> search(String query) async {
    final q = query.trim();
    if (q.isEmpty) return const Success(<City>[]);
    return guard(() async => _parseCities(await remote.search(q)));
  }

  @override
  Future<Result<City>> addFavorite(City city) => guard(
        () async {
          final row = await remote.addFavorite(city.copyWith(id: null).toDto().toJson());
          return CityDto.fromJson(row).toEntity();
        },
        offlineFailure: const Failure.offlineAction(),
      );

  @override
  Future<Result<void>> removeFavorite(City city) => guard(
        () async {
          final id = city.id;
          if (id == null) throw const Failure.notFound();
          await remote.removeFavorite(id);
        },
        offlineFailure: const Failure.offlineAction(),
      );

  static List<City> _parseCities(Object json) => [
        for (final item in json as List) CityDto.fromJson(item as Map<String, dynamic>).toEntity(),
      ];
}

@Riverpod(keepAlive: true)
CitiesRepository citiesRepository(Ref ref) => CitiesRepositoryImpl(
      remote: CitiesRemoteDataSource(owm: ref.watch(owmDioProvider), supabase: ref.watch(supabaseDioProvider)),
      cache: ref.watch(cacheStoreProvider),
      networkInfo: ref.watch(networkInfoProvider),
    );
