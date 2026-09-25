import '../features/cities/domain/city.dart';

abstract final class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const home = '/';
  static const search = '/search';
  static const profile = '/profile';
  static const city = '/city';

  static String cityLocation(City c) => Uri(
        path: city,
        queryParameters: {'lat': '${c.lat}', 'lon': '${c.lon}', 'name': c.name},
      ).toString();
}
