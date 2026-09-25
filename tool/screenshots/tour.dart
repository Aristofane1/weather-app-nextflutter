// Tournée de captures pour le README : vraie app, vraies API (.env), vrai compte.
// Hors de `test/` et `integration_test/` : jamais lancé par la CI.
//
// flutter drive --driver=tool/screenshots/driver.dart --target=tool/screenshots/tour.dart \
//   -d emulator-5554 --dart-define=DEMO_EMAIL=... --dart-define=DEMO_PASSWORD=...
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:weather_app/features/cities/presentation/widgets/city_weather_tile.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_icon.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_skeletons.dart';
import 'package:weather_app/main.dart' as app;

const _email = String.fromEnvironment('DEMO_EMAIL');
const _password = String.fromEnvironment('DEMO_PASSWORD');
const _cities = ['Paris', 'Lyon', 'Marseille'];

/// Température affichée sur une tuile de l'accueil (ex. « 18° »).
final _tileTemperature = RegExp(r'^-?\d+°$');

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('captures README', timeout: const Timeout(Duration(minutes: 6)), (tester) async {
    expect(_email, isNotEmpty, reason: 'Passer --dart-define=DEMO_EMAIL=…');
    expect(_password, isNotEmpty, reason: 'Passer --dart-define=DEMO_PASSWORD=…');

    app.main();
    await _waitFor(
      tester,
      () => _exists(find.byKey(const Key('login_email'))) || _exists(find.byTooltip('Profil')),
      'écran de connexion ou accueil',
    );

    // Session déjà ouverte (réinstallation sans effacement) : on se déconnecte d'abord.
    if (!_exists(find.byKey(const Key('login_email')))) {
      await _tap(tester, find.byTooltip('Profil'));
      await _tap(tester, find.text('Se déconnecter'));
      await _waitFor(tester, () => _exists(find.byKey(const Key('login_email'))), 'écran de connexion');
    }

    await binding.convertFlutterSurfaceToImage();
    await _settle(tester);
    await _shot(binding, tester, 'login');

    // Connexion
    await tester.enterText(find.byKey(const Key('login_email')), _email);
    await tester.enterText(find.byKey(const Key('login_password')), _password);
    await _tap(tester, find.text('Se connecter'));
    await _waitForHome(tester);

    // Favoris Paris, Lyon, Marseille (dans cet ordre) s'ils manquent.
    for (final city in _cities) {
      if (_exists(find.descendant(of: find.byType(CityWeatherTile), matching: find.text(city)))) continue;
      await _tap(tester, find.byType(FloatingActionButton));
      await _search(tester, city);
      final tile = _frenchResult(city);
      await _tap(tester, find.descendant(of: tile, matching: find.byType(IconButton)));
      await _waitFor(tester, () => _exists(find.byTooltip('Retirer $city des favoris')), 'ajout de $city');
      await _back(tester);
      await _waitForHome(tester);
    }
    _clearSnackBars(tester);

    await _waitFor(tester, () {
      final tiles = find.byType(CityWeatherTile).evaluate().length;
      final temps = find.textContaining(_tileTemperature).evaluate().length;
      return tiles >= _cities.length && temps == tiles && _iconsLoaded();
    }, 'météo et icônes des favoris');
    await _shot(binding, tester, 'home');

    // Recherche
    await _tap(tester, find.byType(FloatingActionButton));
    await _search(tester, 'Lyon');
    FocusManager.instance.primaryFocus?.unfocus();
    await _settle(tester);
    await _shot(binding, tester, 'search');
    await _back(tester);
    await _waitForHome(tester);

    // Détail de Paris
    await _tap(tester, find.descendant(of: find.byType(CityWeatherTile), matching: find.text('Paris')));
    await _waitFor(
      tester,
      () =>
          _exists(find.text('Prévisions sur 5 jours')) &&
          !_exists(find.byType(CurrentWeatherSkeleton)) &&
          !_exists(find.byType(ForecastSkeleton)) &&
          _iconsLoaded(),
      'détail de Paris',
    );
    await _shot(binding, tester, 'detail');
    await _back(tester);
    await _waitForHome(tester);

    // Profil
    await _tap(tester, find.byTooltip('Profil'));
    await _waitFor(tester, () => _exists(find.text(_email)), 'profil');
    await _shot(binding, tester, 'profile');
  });
}

bool _exists(Finder finder) => finder.evaluate().isNotEmpty;

/// Pompe des frames en temps réel jusqu'à [condition], borné par [timeout].
Future<void> _waitFor(
  WidgetTester tester,
  bool Function() condition,
  String what, {
  Duration timeout = const Duration(seconds: 45),
}) async {
  debugPrint('TOUR: attente de $what');
  final deadline = DateTime.now().add(timeout);
  while (!condition()) {
    if (DateTime.now().isAfter(deadline)) throw TestFailure('Délai dépassé : $what');
    await Future<void>.delayed(const Duration(milliseconds: 200));
    await tester.pump();
  }
}

/// Laisse finir transitions et fondus (sans `pumpAndSettle`, qui bouclerait sur un indicateur).
Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await tester.pump();
  }
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await _waitFor(tester, () => _exists(finder), 'élément $finder');
  await tester.tap(finder.first);
  await _settle(tester);
}

Future<void> _back(WidgetTester tester) => _tap(tester, find.byType(BackButton));

Future<void> _shot(IntegrationTestWidgetsFlutterBinding binding, WidgetTester tester, String name) async {
  await _settle(tester);
  await binding.takeScreenshot(name);
  debugPrint('TOUR: capture $name');
}

Future<void> _waitForHome(WidgetTester tester) => _waitFor(
      tester,
      () =>
          _exists(find.byTooltip('Profil')) &&
          (_exists(find.byType(CityWeatherTile)) || _exists(find.text('Aucune ville favorite pour le moment'))),
      'accueil',
    );

/// Saisit [query] et attend que le résultat français s'affiche.
Future<void> _search(WidgetTester tester, String query) async {
  await _waitFor(tester, () => _exists(find.byType(TextField)), 'champ de recherche');
  await tester.enterText(find.byType(TextField), query);
  await _waitFor(tester, () => _exists(_frenchResult(query)), 'résultats pour $query');
  await _settle(tester);
}

/// Ligne de résultat « [city] … FR ».
Finder _frenchResult(String city) => find.byWidgetPredicate(
      (w) =>
          w is ListTile &&
          w.title is Text &&
          (w.title as Text).data == city &&
          w.subtitle is Text &&
          ((w.subtitle as Text).data ?? '').endsWith('FR'),
    );

/// Toutes les icônes OWM visibles sont décodées (pas de placeholder ni de repli).
bool _iconsLoaded() {
  final icons = find.byType(WeatherIcon).evaluate().toList();
  if (icons.isEmpty) return false;
  return icons.every((icon) {
    if ((icon.widget as WeatherIcon).code == null) return false;
    final images = find.descendant(of: find.byElementPredicate((e) => e == icon), matching: find.byType(RawImage));
    return images.evaluate().any((e) => (e.widget as RawImage).image != null);
  });
}

void _clearSnackBars(WidgetTester tester) {
  for (final state in tester.stateList<ScaffoldMessengerState>(find.byType(ScaffoldMessenger))) {
    state.clearSnackBars();
  }
}
