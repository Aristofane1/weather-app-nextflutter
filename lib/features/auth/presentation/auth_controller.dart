import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/core_providers.dart';
import '../../../core/result/result.dart';
import '../data/auth_repository_impl.dart';
import '../domain/app_user.dart';

part 'auth_controller.g.dart';

/// État d'authentification global. `null` signifie « déconnecté ». Le routeur l'écoute.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AppUser?> build() async {
    // Session expirée : on efface les données locales avant de repasser « déconnecté ».
    final sub = ref.watch(sessionEventsProvider).onExpired.listen((_) async {
      await ref.read(authRepositoryProvider).clearLocalData();
      if (!ref.mounted) return;
      state = const AsyncData(null);
    });
    ref.onDispose(sub.cancel);
    return ref.watch(authRepositoryProvider).currentUser();
  }

  Future<Result<AppUser>> signIn(String email, String password) async {
    final result = await ref.read(authRepositoryProvider).signIn(email: email, password: password);
    if (result case Success(:final data)) state = AsyncData(data);
    return result;
  }

  Future<Result<AppUser?>> signUp(String email, String password) async {
    final result = await ref.read(authRepositoryProvider).signUp(email: email, password: password);
    if (result case Success(:final data?)) state = AsyncData(data);
    return result;
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData(null);
  }
}
