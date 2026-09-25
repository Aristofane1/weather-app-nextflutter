import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

/// Message lisible d'une erreur de configuration (sans le préfixe « Bad state: »).
String configErrorMessage(Object error) => error is StateError ? error.message : '$error';

/// Écran affiché à la place de l'app quand `.env` est absent ou incomplet,
/// plutôt qu'un écran blanc.
class ConfigErrorApp extends StatelessWidget {
  const ConfigErrorApp({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Météo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Builder(
                  builder: (context) {
                    final theme = Theme.of(context);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.settings_suggest_outlined, size: 56, color: theme.colorScheme.error),
                        const SizedBox(height: 12),
                        Text('Configuration invalide', style: theme.textTheme.titleLarge),
                        const SizedBox(height: 8),
                        Text(message, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        const Text('Copiez .env.example en .env et renseignez les clés.', textAlign: TextAlign.center),
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
