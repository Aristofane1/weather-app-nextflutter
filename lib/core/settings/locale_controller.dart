import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core_providers.dart';

part 'locale_controller.g.dart';

/// Langue choisie dans Profil. `null` = langue de l'appareil.
@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  static const _key = 'locale';

  @override
  Locale? build() {
    final code = ref.watch(settingsStoreProvider).read(_key);
    return code == null ? null : Locale(code);
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    await ref.read(settingsStoreProvider).write(_key, locale?.languageCode);
  }
}
