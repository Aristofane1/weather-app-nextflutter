import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/core_providers.dart';
import 'package:weather_app/core/network/session_events.dart';
import 'package:weather_app/core/result/result.dart';
import 'package:weather_app/features/auth/data/auth_repository_impl.dart';
import 'package:weather_app/features/auth/domain/app_user.dart';
import 'package:weather_app/features/auth/domain/auth_repository.dart';
import 'package:weather_app/features/auth/presentation/login_screen.dart';
import 'package:weather_app/features/auth/presentation/profile_screen.dart';
import 'package:weather_app/features/cities/data/cities_repository_impl.dart';
import 'package:weather_app/features/cities/domain/cities_repository.dart';
import 'package:weather_app/features/cities/domain/city.dart';
import 'package:weather_app/features/cities/presentation/home_screen.dart';
import 'package:weather_app/features/cities/presentation/search_screen.dart';
import 'package:weather_app/features/weather/data/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/weather.dart';
import 'package:weather_app/features/weather/domain/weather_repository.dart';

import '../helpers/localized_app.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockCitiesRepository extends Mock implements CitiesRepository {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

const _paris = City(id: 1, name: 'Paris', country: 'FR', lat: 48.85, lon: 2.35);

Future<void> _expectGuidelines(WidgetTester tester) async {
  await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
  await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  await expectLater(tester, meetsGuideline(textContrastGuideline));
}

void main() {
  late MockAuthRepository auth;
  late MockCitiesRepository cities;
  late MockWeatherRepository weather;

  setUpAll(() => initializeDateFormatting());

  setUp(() {
    auth = MockAuthRepository();
    cities = MockCitiesRepository();
    weather = MockWeatherRepository();
    when(() => auth.currentUser()).thenAnswer((_) async => const AppUser(id: 'u1', email: 'a@b.c'));
    when(() => cities.watchFavorites()).thenAnswer((_) => Stream.value(const Success([_paris])));
    when(() => cities.search(any())).thenAnswer((_) async => const Success([_paris]));
    when(() => weather.watchCurrent(lat: any(named: 'lat'), lon: any(named: 'lon'))).thenAnswer(
      (_) => Stream.value(Success(CurrentWeather(
        cityName: 'Paris',
        temperature: 21.4,
        feelsLike: 20,
        humidity: 50,
        windSpeed: 3,
        description: 'ciel dégagé',
        iconCode: '01d',
        date: DateTime(2026, 9, 25, 12),
      ))),
    );
  });

  Widget app(Widget home, {ThemeMode themeMode = ThemeMode.light}) => ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(auth),
          citiesRepositoryProvider.overrideWithValue(cities),
          weatherRepositoryProvider.overrideWithValue(weather),
          sessionEventsProvider.overrideWithValue(SessionEvents()),
          ...testOverrides,
        ],
        child: localizedApp(home: home, themeMode: themeMode),
      );

  testWidgets('login screen meets accessibility guidelines', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(app(const LoginScreen()));
    await tester.pumpAndSettle();
    await _expectGuidelines(tester);
    handle.dispose();
  });

  testWidgets('home screen meets guidelines and reads each city in one sentence', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(app(const HomeScreen()));
    await tester.pump();
    await tester.pump();
    expect(find.bySemanticsLabel('Paris, 21 degrés, ciel dégagé'), findsOneWidget);
    await _expectGuidelines(tester);
    handle.dispose();
  });

  testWidgets('search results expose a toggled favorite button', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(app(const SearchScreen()));
    await tester.enterText(find.byType(TextField), 'Par');
    await tester.pump(const Duration(milliseconds: 450));
    await tester.pump();
    expect(
      tester.getSemantics(find.byTooltip('Retirer Paris des favoris')),
      matchesSemantics(
        isButton: true,
        hasToggledState: true,
        isToggled: true,
        isEnabled: true,
        hasEnabledState: true,
        hasTapAction: true,
        // Drapeau secondaire : l'IconButton sous-jacent reste focusable au clavier.
        isFocusable: true,
        hasFocusAction: true,
        tooltip: 'Retirer Paris des favoris',
      ),
    );
    await _expectGuidelines(tester);
    handle.dispose();
  });

  testWidgets('profile screen meets accessibility guidelines', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(app(const ProfileScreen()));
    await tester.pumpAndSettle();
    await _expectGuidelines(tester);
    handle.dispose();
  });

  testWidgets('home screen with data keeps text contrast in the dark theme', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(app(const HomeScreen(), themeMode: ThemeMode.dark));
    await tester.pump();
    await tester.pump();
    expect(find.text('21°'), findsOneWidget);
    expect(Theme.of(tester.element(find.text('21°'))).brightness, Brightness.dark);
    await expectLater(tester, meetsGuideline(textContrastGuideline));
    handle.dispose();
  });
}
