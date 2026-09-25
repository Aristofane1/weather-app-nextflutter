import 'package:weather_app/core/cache/cache_store.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/result/result.dart';
import 'package:weather_app/features/auth/domain/app_user.dart';
import 'package:weather_app/features/auth/domain/auth_repository.dart';
import 'package:weather_app/features/cities/domain/cities_repository.dart';
import 'package:weather_app/features/cities/domain/city.dart';
import 'package:weather_app/features/weather/domain/weather.dart';
import 'package:weather_app/features/weather/domain/weather_repository.dart';

/// Auth en mémoire : un seul compte valide.
class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({bool signedIn = false}) : _user = signedIn ? _account : null;

  static const email = 'test@meteo.app';
  static const password = 'password123';
  static const _account = AppUser(id: 'u1', email: email);

  AppUser? _user;

  @override
  Future<Result<AppUser>> signIn({required String email, required String password}) async {
    if (email.trim() == FakeAuthRepository.email && password == FakeAuthRepository.password) {
      _user = _account;
      return const Success(_account);
    }
    return const Failed(Failure.invalidCredentials());
  }

  @override
  Future<Result<AppUser?>> signUp({required String email, required String password}) async {
    _user = _account;
    return const Success(_account);
  }

  @override
  Future<void> signOut() async => _user = null;

  @override
  Future<AppUser?> currentUser() async => _user;

  @override
  Future<void> clearLocalData() async {}
}

/// Favoris en mémoire et recherche sur un petit catalogue.
class FakeCitiesRepository implements CitiesRepository {
  FakeCitiesRepository({List<City> favorites = const []}) : _favorites = [...favorites];

  static const catalog = [
    City(name: 'Paris', country: 'FR', state: 'Ile-de-France', lat: 48.8566, lon: 2.3522),
    City(name: 'Lyon', country: 'FR', lat: 45.764, lon: 4.8357),
    City(name: 'Marseille', country: 'FR', lat: 43.2965, lon: 5.3698),
  ];

  final List<City> _favorites;
  var _nextId = 1000;

  @override
  Stream<Result<List<City>>> watchFavorites() => Stream.value(Success(List.unmodifiable(_favorites)));

  @override
  Future<Result<List<City>>> search(String query) async {
    final q = query.trim().toLowerCase();
    return Success(catalog.where((c) => c.name.toLowerCase().startsWith(q)).toList());
  }

  @override
  Future<Result<City>> addFavorite(City city) async {
    final saved = city.copyWith(id: _nextId++);
    _favorites.add(saved);
    return Success(saved);
  }

  @override
  Future<Result<void>> removeFavorite(City city) async {
    _favorites.removeWhere((f) => f.id == city.id);
    return const Success<void>(null);
  }
}

/// Météo déterministe : 21 °C, ciel dégagé, 5 jours de prévisions.
class FakeWeatherRepository implements WeatherRepository {
  @override
  Stream<Result<CurrentWeather>> watchCurrent({required double lat, required double lon}) => Stream.value(Success(
        CurrentWeather(
          cityName: 'Test',
          temperature: 21,
          feelsLike: 20,
          humidity: 50,
          windSpeed: 3,
          description: 'ciel dégagé',
          iconCode: '01d',
          date: DateTime(2026, 9, 25, 12),
        ),
      ));

  @override
  Stream<Result<List<ForecastEntry>>> watchForecast({required double lat, required double lon}) {
    final start = DateTime(2026, 9, 25, 12);
    return Stream.value(Success([
      for (var i = 0; i < 5; i++)
        ForecastEntry(
          date: start.add(Duration(days: i)),
          temperature: 20.0 + i,
          tempMin: 15.0 + i,
          tempMax: 24.0 + i,
          description: 'ciel dégagé',
          iconCode: '01d',
        ),
    ]));
  }
}

class MemoryCacheStore implements CacheStore {
  final _entries = <String, CacheEntry>{};

  @override
  Future<CacheEntry?> read(String key) async => _entries[key];

  @override
  Future<void> write(String key, Object json) async => _entries[key] = CacheEntry(json: json, cachedAt: DateTime.now());

  @override
  Future<void> delete(String key) async => _entries.remove(key);

  @override
  Future<void> clear() async => _entries.clear();
}
