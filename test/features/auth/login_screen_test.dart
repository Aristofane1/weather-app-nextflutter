import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/core_providers.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/network/session_events.dart';
import 'package:weather_app/core/result/result.dart';
import 'package:weather_app/features/auth/data/auth_repository_impl.dart';
import 'package:weather_app/features/auth/domain/app_user.dart';
import 'package:weather_app/features/auth/domain/auth_repository.dart';
import 'package:weather_app/features/auth/presentation/login_screen.dart';

import '../../helpers/localized_app.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repo;

  setUp(() {
    repo = MockAuthRepository();
    when(() => repo.currentUser()).thenAnswer((_) async => null);
  });

  Future<void> pumpLogin(WidgetTester tester) => tester.pumpWidget(ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repo),
          sessionEventsProvider.overrideWithValue(SessionEvents()),
        ],
        child: localizedApp(home: const LoginScreen()),
      ));

  testWidgets('invalid form shows errors and does not call API', (tester) async {
    await pumpLogin(tester);
    await tester.enterText(find.byKey(const Key('login_email')), 'abc');
    await tester.tap(find.text('Se connecter'));
    await tester.pump();

    expect(find.text('Email invalide'), findsOneWidget);
    expect(find.text('Mot de passe requis'), findsOneWidget);
    verifyNever(() => repo.signIn(email: any(named: 'email'), password: any(named: 'password')));
  });

  testWidgets('wrong credentials shows french error message', (tester) async {
    when(() => repo.signIn(email: 'a@b.c', password: 'bad'))
        .thenAnswer((_) async => const Failed<AppUser>(Failure.invalidCredentials()));

    await pumpLogin(tester);
    await tester.enterText(find.byKey(const Key('login_email')), 'a@b.c');
    await tester.enterText(find.byKey(const Key('login_password')), 'bad');
    await tester.tap(find.text('Se connecter'));
    await tester.pumpAndSettle();

    expect(find.text('Email ou mot de passe incorrect'), findsOneWidget);
  });

  testWidgets('shows english validation errors', (tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        sessionEventsProvider.overrideWithValue(SessionEvents()),
      ],
      child: localizedApp(home: const LoginScreen(), locale: const Locale('en')),
    ));
    await tester.enterText(find.byKey(const Key('login_email')), 'abc');
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pump();

    expect(find.text('Invalid email'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });
}
