import 'package:flutter/material.dart';

/// Petite tuile de mesure : icône, libellé et valeur, lue en une seule annonce.
class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.semanticsLabel,
  });

  final IconData icon;
  final String label;
  final String value;

  /// Annonce complète (ex. « Ressenti : 20° »).
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              Icon(icon, size: 24, color: theme.colorScheme.primary),
              const SizedBox(height: 8),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(value, maxLines: 1, style: theme.textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}
