import 'package:flutter/material.dart';

import '../core/config/env.dart';
import '../core/theme/app_theme.dart';
import '../l10n/l10n.dart';

/// Écran affiché à la place de l'app quand `.env` est absent ou incomplet,
/// plutôt qu'un écran blanc.
class ConfigErrorApp extends StatelessWidget {
  const ConfigErrorApp({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) => MaterialApp(
        onGenerateTitle: (context) => context.l10n.appTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Builder(
                  builder: (context) {
                    final theme = Theme.of(context);
                    // Clé manquante : message traduit ; autre erreur : texte brut.
                    final detail = error is MissingEnvKey
                        ? context.l10n.configMissingKey((error as MissingEnvKey).key)
                        : '$error';
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.settings_suggest_outlined, size: 56, color: theme.colorScheme.error),
                        const SizedBox(height: 12),
                        Text(context.l10n.configErrorTitle, style: theme.textTheme.titleLarge),
                        const SizedBox(height: 8),
                        Text(detail, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        Text(context.l10n.configErrorHint, textAlign: TextAlign.center),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
}
