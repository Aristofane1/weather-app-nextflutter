import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'app/config_error_app.dart';
import 'core/cache/hive_cache_store.dart';
import 'core/config/env.dart';
import 'core/core_providers.dart';
import 'core/settings/settings_store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  // Edge-to-edge : barres système transparentes, le contenu gère ses marges (SafeArea/AppBar).
  // Style par défaut clair ; chaque AppBar (ou AnnotatedRegion) l'adapte ensuite au thème.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
  ));
  try {
    // isOptional : un .env absent donne le message explicite de Env.validate().
    await dotenv.load(fileName: '.env', isOptional: true);
    Env.validate();
  } catch (e) {
    runApp(ConfigErrorApp(error: e));
    return;
  }

  await Hive.initFlutter();
  final cacheBox = await Hive.openBox<String>(HiveCacheStore.boxName);
  final settingsBox = await Hive.openBox<String>(HiveSettingsStore.boxName);

  runApp(ProviderScope(
    overrides: [
      cacheStoreProvider.overrideWithValue(HiveCacheStore(cacheBox)),
      settingsStoreProvider.overrideWithValue(HiveSettingsStore(settingsBox)),
    ],
    child: const WeatherApp(),
  ));
}
