import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/settings/locale_controller.dart';
import 'package:weather_app/core/core_providers.dart';
import 'package:weather_app/core/network/session_events.dart';
import 'package:weather_app/core/settings/settings_store.dart';
import 'package:weather_app/features/auth/data/auth_repository_impl.dart';
import 'package:weather_app/features/auth/domain/app_user.dart';
import 'package:weather_app/features/auth/domain/auth_repository.dart';
import 'package:weather_app/features/auth/presentation/profile_screen.dart';
import 'package:weather_app/l10n/l10n.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  testWidgets('switching to English updates the UI and persists the choice', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    final repo = MockAuthRepository();
    when(() => repo.currentUser()).thenAnswer((_) async => const AppUser(id: 'u1', email: 'a@b.c'));
    final store = MemorySettingsStore();

    await tester.pumpWidget(ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(repo),
        sessionEventsProvider.overrideWithValue(SessionEvents()),
        settingsStoreProvider.overrideWithValue(store),
      ],
      child: Consumer(
        builder: (context, ref, _) => MaterialApp(
          locale: ref.watch(localeControllerProvider),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const ProfileScreen(),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Se déconnecter'), findsOneWidget);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    expect(find.text('Sign out'), findsOneWidget);
    expect(store.read('locale'), 'en');
  });
}
