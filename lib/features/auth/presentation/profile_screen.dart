import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/settings/locale_controller.dart';
import '../../../core/widgets/section_card.dart';
import '../../../l10n/l10n.dart';
import 'auth_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final email = ref.watch(authControllerProvider.select((s) => s.value?.email)) ?? '';
    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          SectionCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: scheme.primaryContainer,
                  foregroundColor: scheme.onPrimaryContainer,
                  child: Text(
                    email.isEmpty ? '?' : email[0].toUpperCase(),
                    style: theme.textTheme.headlineMedium?.copyWith(color: scheme.onPrimaryContainer),
                  ),
                ),
                const SizedBox(height: 16),
                Text(email, style: theme.textTheme.titleMedium, textAlign: TextAlign.center),
                const SizedBox(height: 4),
                Text(
                  l10n.signedIn,
                  style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionCard(
            title: l10n.languageLabel,
            child: SegmentedButton<String>(
              showSelectedIcon: false,
              segments: [
                ButtonSegment(value: 'system', label: Text(l10n.languageSystem)),
                // Chaque langue est nommée dans sa propre langue.
                const ButtonSegment(value: 'fr', label: Text('Français')),
                const ButtonSegment(value: 'en', label: Text('English')),
              ],
              selected: {ref.watch(localeControllerProvider)?.languageCode ?? 'system'},
              onSelectionChanged: (selection) {
                final code = selection.single;
                ref.read(localeControllerProvider.notifier).setLocale(code == 'system' ? null : Locale(code));
              },
            ),
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: scheme.error,
              side: BorderSide(color: scheme.error.withValues(alpha: 0.5)),
            ),
            onPressed: () => ref.read(authControllerProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
            label: Text(l10n.signOut),
          ),
        ],
      ),
    );
  }
}
