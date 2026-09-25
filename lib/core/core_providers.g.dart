// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Surchargé dans `main()` avec la box Hive ouverte.

@ProviderFor(cacheStore)
final cacheStoreProvider = CacheStoreProvider._();

/// Surchargé dans `main()` avec la box Hive ouverte.

final class CacheStoreProvider
    extends $FunctionalProvider<CacheStore, CacheStore, CacheStore>
    with $Provider<CacheStore> {
  /// Surchargé dans `main()` avec la box Hive ouverte.
  CacheStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cacheStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cacheStoreHash();

  @$internal
  @override
  $ProviderElement<CacheStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CacheStore create(Ref ref) {
    return cacheStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CacheStore>(value),
    );
  }
}

String _$cacheStoreHash() => r'd68db7845970b06c77c2a45cd003925c6ba189cf';

/// Surchargé dans `main()` avec la box Hive `settings`.

@ProviderFor(settingsStore)
final settingsStoreProvider = SettingsStoreProvider._();

/// Surchargé dans `main()` avec la box Hive `settings`.

final class SettingsStoreProvider
    extends $FunctionalProvider<SettingsStore, SettingsStore, SettingsStore>
    with $Provider<SettingsStore> {
  /// Surchargé dans `main()` avec la box Hive `settings`.
  SettingsStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsStoreHash();

  @$internal
  @override
  $ProviderElement<SettingsStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsStore create(Ref ref) {
    return settingsStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsStore>(value),
    );
  }
}

String _$settingsStoreHash() => r'aaac048c2a794d36fdb891e3fcd056c0cf4e2b23';

/// Langue envoyée à OWM : choix de l'utilisateur, sinon langue de l'appareil (fr/en).

@ProviderFor(apiLanguage)
final apiLanguageProvider = ApiLanguageProvider._();

/// Langue envoyée à OWM : choix de l'utilisateur, sinon langue de l'appareil (fr/en).

final class ApiLanguageProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// Langue envoyée à OWM : choix de l'utilisateur, sinon langue de l'appareil (fr/en).
  ApiLanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiLanguageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiLanguageHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return apiLanguage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$apiLanguageHash() => r'4b1d316a5fd0636ca41fd1e06e1fb64ca66ec1cc';

@ProviderFor(networkInfo)
final networkInfoProvider = NetworkInfoProvider._();

final class NetworkInfoProvider
    extends $FunctionalProvider<NetworkInfo, NetworkInfo, NetworkInfo>
    with $Provider<NetworkInfo> {
  NetworkInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'networkInfoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$networkInfoHash();

  @$internal
  @override
  $ProviderElement<NetworkInfo> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NetworkInfo create(Ref ref) {
    return networkInfo(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NetworkInfo value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NetworkInfo>(value),
    );
  }
}

String _$networkInfoHash() => r'6af787a0e9047aa4cb687a850c445388afe194ab';

@ProviderFor(sessionStorage)
final sessionStorageProvider = SessionStorageProvider._();

final class SessionStorageProvider
    extends $FunctionalProvider<SessionStorage, SessionStorage, SessionStorage>
    with $Provider<SessionStorage> {
  SessionStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionStorageHash();

  @$internal
  @override
  $ProviderElement<SessionStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SessionStorage create(Ref ref) {
    return sessionStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionStorage>(value),
    );
  }
}

String _$sessionStorageHash() => r'cdda297699f32e9b70a06b624aed9af4196dd3cc';

@ProviderFor(sessionEvents)
final sessionEventsProvider = SessionEventsProvider._();

final class SessionEventsProvider
    extends $FunctionalProvider<SessionEvents, SessionEvents, SessionEvents>
    with $Provider<SessionEvents> {
  SessionEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionEventsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionEventsHash();

  @$internal
  @override
  $ProviderElement<SessionEvents> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SessionEvents create(Ref ref) {
    return sessionEvents(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionEvents value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionEvents>(value),
    );
  }
}

String _$sessionEventsHash() => r'e11d40f19d2b43c3e06c460fc54ac3882ba22132';

/// Supabase sans JWT : signup, login, refresh.

@ProviderFor(supabaseAuthDio)
final supabaseAuthDioProvider = SupabaseAuthDioProvider._();

/// Supabase sans JWT : signup, login, refresh.

final class SupabaseAuthDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Supabase sans JWT : signup, login, refresh.
  SupabaseAuthDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseAuthDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseAuthDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return supabaseAuthDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$supabaseAuthDioHash() => r'6ce5193e65fa542b1b99414f57e5ecd1de793dbf';

/// Supabase authentifié (PostgREST) : JWT injecté et refresh sur 401.

@ProviderFor(supabaseDio)
final supabaseDioProvider = SupabaseDioProvider._();

/// Supabase authentifié (PostgREST) : JWT injecté et refresh sur 401.

final class SupabaseDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Supabase authentifié (PostgREST) : JWT injecté et refresh sur 401.
  SupabaseDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return supabaseDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$supabaseDioHash() => r'b6479b883b5ba5ea5b54d0a158d6af4f66f6529c';

@ProviderFor(owmDio)
final owmDioProvider = OwmDioProvider._();

final class OwmDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  OwmDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'owmDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$owmDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return owmDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$owmDioHash() => r'95e52de8fa69fb3f890fd913264f6a2e2f20b3c7';

/// Cache disque des icônes météo. `null` = pas d'image réseau (tests) : icône de repli.

@ProviderFor(iconCacheManager)
final iconCacheManagerProvider = IconCacheManagerProvider._();

/// Cache disque des icônes météo. `null` = pas d'image réseau (tests) : icône de repli.

final class IconCacheManagerProvider
    extends
        $FunctionalProvider<
          BaseCacheManager?,
          BaseCacheManager?,
          BaseCacheManager?
        >
    with $Provider<BaseCacheManager?> {
  /// Cache disque des icônes météo. `null` = pas d'image réseau (tests) : icône de repli.
  IconCacheManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'iconCacheManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$iconCacheManagerHash();

  @$internal
  @override
  $ProviderElement<BaseCacheManager?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BaseCacheManager? create(Ref ref) {
    return iconCacheManager(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BaseCacheManager? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BaseCacheManager?>(value),
    );
  }
}

String _$iconCacheManagerHash() => r'dc675e7b4710f842f988d6ab3edec6b6be47af8e';
