import 'package:flutter/material.dart';

/// Carte blanche arrondie avec un titre de section facultatif.
class SectionCard extends StatelessWidget {
  const SectionCard({super.key, this.title, required this.child, this.padding = const EdgeInsets.all(16)});

  final String? title;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: padding,
        child: title == null
            ? child
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title!,
                    style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 12),
                  child,
                ],
              ),
      ),
    );
  }
}
