import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'cache/cache_store.dart';
import 'config/env.dart';
import 'network/api_language.dart';
import 'network/auth_interceptor.dart';
import 'network/network_info.dart';
import 'network/owm_interceptor.dart';
import 'network/session_events.dart';
import 'network/supabase_session_api.dart';
import 'settings/locale_controller.dart';
import 'settings/settings_store.dart';
import 'storage/session_storage.dart';

part 'core_providers.g.dart';

/// Surchargé dans `main()` avec la box Hive ouverte.
@Riverpod(keepAlive: true)
CacheStore cacheStore(Ref ref) =>
    throw UnimplementedError('cacheStoreProvider doit être surchargé dans main()');

/// Surchargé dans `main()` avec la box Hive `settings`.
@Riverpod(keepAlive: true)
SettingsStore settingsStore(Ref ref) =>
    throw UnimplementedError('settingsStoreProvider doit être surchargé dans main()');

/// Langue envoyée à OWM : choix de l'utilisateur, sinon langue de l'appareil (fr/en).
@Riverpod(keepAlive: true)
String apiLanguage(Ref ref) =>
    apiLanguageFor(ref.watch(localeControllerProvider) ?? PlatformDispatcher.instance.locale);

@Riverpod(keepAlive: true)
NetworkInfo networkInfo(Ref ref) => ConnectivityNetworkInfo();

@Riverpod(keepAlive: true)
SessionStorage sessionStorage(Ref ref) => SecureSessionStorage();

@Riverpod(keepAlive: true)
SessionEvents sessionEvents(Ref ref) {
  final events = SessionEvents();
  ref.onDispose(events.dispose);
  return events;
}

BaseOptions _options(String baseUrl, {Map<String, dynamic>? headers}) => BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
    );

/// Supabase sans JWT : signup, login, refresh.
@Riverpod(keepAlive: true)
Dio supabaseAuthDio(Ref ref) => Dio(_options(Env.supabaseUrl, headers: {'apikey': Env.supabaseAnonKey}));

/// Supabase authentifié (PostgREST) : JWT injecté et refresh sur 401.
@Riverpod(keepAlive: true)
Dio supabaseDio(Ref ref) {
  final dio = Dio(_options(Env.supabaseUrl, headers: {'apikey': Env.supabaseAnonKey}));
  final authDio = ref.watch(supabaseAuthDioProvider);
  final retryDio = Dio(_options(Env.supabaseUrl, headers: {'apikey': Env.supabaseAnonKey}));
  dio.interceptors.add(AuthInterceptor(
    retryDio: retryDio,
    storage: ref.watch(sessionStorageProvider),
    refresh: (token) => refreshSupabaseSession(authDio, token),
    onSessionExpired: ref.watch(sessionEventsProvider).expired,
  ));
  return dio;
}

@Riverpod(keepAlive: true)
Dio owmDio(Ref ref) => Dio(_options('https://api.openweathermap.org'))
  // Lu à chaque requête (pas de watch) : l'instance Dio reste stable.
  ..interceptors.add(OwmInterceptor(Env.owmApiKey, language: () => ref.read(apiLanguageProvider)));

/// Cache disque des icônes météo. `null` = pas d'image réseau (tests) : icône de repli.
@Riverpod(keepAlive: true)
BaseCacheManager? iconCacheManager(Ref ref) => DefaultCacheManager();
