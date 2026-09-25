import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/domain/app_user.dart';
import '../features/auth/presentation/auth_controller.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/profile_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/cities/presentation/home_screen.dart';
import '../features/cities/presentation/search_screen.dart';
import '../features/weather/presentation/city_detail_screen.dart';
import 'routes.dart';
import 'splash_screen.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // Pont Riverpod → go_router : chaque changement d'auth relance `redirect`.
  final auth = ValueNotifier<AsyncValue<AppUser?>>(const AsyncLoading());
  ref.listen(authControllerProvider, (_, next) => auth.value = next, fireImmediately: true);

  final router = GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: auth,
    redirect: (context, state) {
      final value = auth.value;
      if (value.isLoading && !value.hasValue) return Routes.splash;
      final loggedIn = value.value != null;
      final location = state.matchedLocation;
      final onAuthPage = location == Routes.login || location == Routes.register;
      if (!loggedIn) return onAuthPage ? null : Routes.login;
      if (onAuthPage || location == Routes.splash) return Routes.home;
      return null;
    },
    routes: [
      GoRoute(path: Routes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: Routes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(path: Routes.register, builder: (_, _) => const RegisterScreen()),
      GoRoute(path: Routes.home, builder: (_, _) => const HomeScreen()),
      GoRoute(path: Routes.search, builder: (_, _) => const SearchScreen()),
      GoRoute(path: Routes.profile, builder: (_, _) => const ProfileScreen()),
      GoRoute(
        path: Routes.city,
        // URL malformée (lien profond, saisie manuelle) : retour à l'accueil plutôt qu'un crash.
        redirect: (_, state) => _coord(state.uri, 'lat') == null || _coord(state.uri, 'lon') == null ? Routes.home : null,
        builder: (_, state) => CityDetailScreen(
          lat: _coord(state.uri, 'lat')!,
          lon: _coord(state.uri, 'lon')!,
          name: state.uri.queryParameters['name'] ?? '',
        ),
      ),
    ],
  );

  ref.onDispose(() {
    router.dispose();
    auth.dispose();
  });
  return router;
}

double? _coord(Uri uri, String key) => double.tryParse(uri.queryParameters[key] ?? '');
