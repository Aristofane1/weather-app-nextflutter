import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/result/result.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../l10n/l10n.dart';
import '../../../weather/presentation/weather_providers.dart';
import '../../../weather/presentation/widgets/weather_icon.dart';
import '../../domain/city.dart';

class CityWeatherTile extends ConsumerWidget {
  const CityWeatherTile({super.key, required this.city});

  final City city;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(currentWeatherProvider(city.lat, city.lon)).value;
    final weather = result?.dataOrNull;
    final l10n = context.l10n;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final label = switch (result) {
      Success(:final data) => l10n.cityWeatherSemantics(city.name, data.temperature.round(), data.description),
      Failed() => l10n.cityWeatherUnavailable(city.name),
      null => l10n.cityWeatherLoading(city.name),
    };
    void open() => context.push(Routes.cityLocation(city));

    return Semantics(
      label: label,
      hint: l10n.cityDetailHint,
      button: true,
      onTap: open,
      // Une seule annonce pour toute la tuile (icône, nom, description, température).
      excludeSemantics: true,
      child: Card(
        child: InkWell(
          onTap: open,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                WeatherIcon(code: weather?.iconCode),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(city.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: text.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        weather == null ? city.subtitle : capitalize(weather.description),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                switch (result) {
                  Success(:final data) => Text(
                      '${data.temperature.round()}°',
                      style: text.headlineMedium?.copyWith(fontWeight: FontWeight.w300),
                    ),
                  Failed() => Icon(Icons.cloud_off_rounded, color: scheme.onSurfaceVariant),
                  null => const Skeleton(child: SkeletonBox(width: 48, height: 28)),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
