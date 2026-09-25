import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/core/core_providers.dart';
import 'package:weather_app/core/network/session_events.dart';
import 'package:weather_app/features/auth/data/auth_repository_impl.dart';
import 'package:weather_app/features/auth/domain/app_user.dart';
import 'package:weather_app/features/auth/domain/auth_repository.dart';
import 'package:weather_app/features/auth/presentation/auth_controller.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  test('session expired clears local data and logs out', () async {
    final repo = MockAuthRepository();
    final events = SessionEvents();
    when(() => repo.currentUser()).thenAnswer((_) async => const AppUser(id: 'u1', email: 'a@b.c'));
    when(() => repo.clearLocalData()).thenAnswer((_) async {});

    final container = ProviderContainer(overrides: [
      authRepositoryProvider.overrideWithValue(repo),
      sessionEventsProvider.overrideWithValue(events),
    ]);
    addTearDown(container.dispose);

    expect(await container.read(authControllerProvider.future), isNotNull);
    events.expired();
    await pumpEventQueue();

    verify(() => repo.clearLocalData()).called(1);
    expect(container.read(authControllerProvider).value, isNull);
  });
}
