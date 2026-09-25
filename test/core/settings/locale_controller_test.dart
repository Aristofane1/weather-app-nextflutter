import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/settings/locale_controller.dart';
import 'package:weather_app/core/core_providers.dart';
import 'package:weather_app/core/settings/settings_store.dart';

void main() {
  test('defaults to system, persists the chosen locale and reloads it', () async {
    final store = MemorySettingsStore();
    final first = ProviderContainer(overrides: [settingsStoreProvider.overrideWithValue(store)]);
    addTearDown(first.dispose);

    expect(first.read(localeControllerProvider), isNull);
    await first.read(localeControllerProvider.notifier).setLocale(const Locale('en'));
    expect(first.read(localeControllerProvider), const Locale('en'));

    final second = ProviderContainer(overrides: [settingsStoreProvider.overrideWithValue(store)]);
    addTearDown(second.dispose);
    expect(second.read(localeControllerProvider), const Locale('en'));

    await second.read(localeControllerProvider.notifier).setLocale(null);
    expect(store.read('locale'), isNull);
  });
}
