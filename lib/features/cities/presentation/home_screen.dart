import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/result_view.dart';
import '../../../core/widgets/scrollable_fill.dart';
import '../../../core/widgets/skeleton.dart';
import '../../weather/presentation/weather_providers.dart';
import 'cities_providers.dart';
import 'widgets/city_weather_tile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes villes'),
        actions: [
          IconButton(
            tooltip: 'Profil',
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push(Routes.profile),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.search),
        icon: const Icon(Icons.add_location_alt_outlined),
        label: const Text('Ajouter'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(currentWeatherProvider);
          ref.invalidate(favoritesProvider);
          await ref.read(favoritesProvider.future);
        },
        child: ResultView(
          value: ref.watch(favoritesProvider),
          skeleton: const SkeletonList(),
          onRetry: () => ref.invalidate(favoritesProvider),
          // États vide et erreur défilables : le pull-to-refresh y reste possible.
          scrollableError: true,
          builder: (context, cities) => cities.isEmpty
              ? ScrollableFill(
                  child: EmptyView(
                    icon: Icons.location_city_outlined,
                    message: 'Aucune ville favorite pour le moment',
                    action: FilledButton(
                      onPressed: () => context.push(Routes.search),
                      child: const Text('Ajouter une ville'),
                    ),
                  ),
                )
              : ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                  itemCount: cities.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (_, i) => CityWeatherTile(city: cities[i]),
                ),
        ),
      ),
    );
  }
}
