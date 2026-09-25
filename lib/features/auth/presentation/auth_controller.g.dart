// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// État d'authentification global. `null` signifie « déconnecté ». Le routeur l'écoute.

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// État d'authentification global. `null` signifie « déconnecté ». Le routeur l'écoute.
final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, AppUser?> {
  /// État d'authentification global. `null` signifie « déconnecté ». Le routeur l'écoute.
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'5b1c5e699ad998e2a2d6c57d8a5d47917b752a98';

/// État d'authentification global. `null` signifie « déconnecté ». Le routeur l'écoute.

abstract class _$AuthController extends $AsyncNotifier<AppUser?> {
  FutureOr<AppUser?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppUser?>, AppUser?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppUser?>, AppUser?>,
              AsyncValue<AppUser?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
