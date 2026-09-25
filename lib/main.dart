import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'app/config_error_app.dart';
import 'core/cache/hive_cache_store.dart';
import 'core/config/env.dart';
import 'core/core_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // isOptional : un .env absent donne le message explicite de Env.validate().
    await dotenv.load(fileName: '.env', isOptional: true);
    Env.validate();
  } catch (e) {
    runApp(ConfigErrorApp(message: configErrorMessage(e)));
    return;
  }

  await Hive.initFlutter();
  final cacheBox = await Hive.openBox<String>(HiveCacheStore.boxName);

  runApp(ProviderScope(
    overrides: [cacheStoreProvider.overrideWithValue(HiveCacheStore(cacheBox))],
    child: const WeatherApp(),
  ));
}
