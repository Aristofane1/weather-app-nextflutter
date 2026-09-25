import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:weather_app/core/core_providers.dart';
import 'package:weather_app/core/settings/settings_store.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/l10n/l10n.dart';

/// Surcharges communes aux tests widget : pas d'image réseau, préférences en mémoire
/// (les providers météo lisent la langue choisie).
List<Override> get testOverrides => [
      iconCacheManagerProvider.overrideWithValue(null),
      settingsStoreProvider.overrideWithValue(MemorySettingsStore()),
    ];

/// MaterialApp minimal avec les traductions et le thème de l'app, en français par défaut.
Widget localizedApp({
  required Widget home,
  Locale locale = const Locale('fr'),
  ThemeMode themeMode = ThemeMode.light,
}) =>
    MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home,
    );

AppLocalizations get l10nFr => lookupAppLocalizations(const Locale('fr'));
AppLocalizations get l10nEn => lookupAppLocalizations(const Locale('en'));
