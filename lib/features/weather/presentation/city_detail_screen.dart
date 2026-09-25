import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/result_view.dart';
import 'weather_providers.dart';
import 'widgets/current_weather_card.dart';
import 'widgets/daily_forecast_tile.dart';
import 'widgets/weather_skeletons.dart';

class CityDetailScreen extends ConsumerWidget {
  const CityDetailScreen({super.key, required this.lat, required this.lon, required this.name});

  final double lat;
  final double lon;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = currentWeatherProvider(lat, lon);
    final forecast = dailyForecastProvider(lat, lon);

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(current);
          ref.invalidate(forecast);
          await ref.read(current.future);
        },
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            ResultView(
              value: ref.watch(current),
              skeleton: const CurrentWeatherSkeleton(),
              onRetry: () => ref.invalidate(current),
              builder: (_, weather) => CurrentWeatherCard(weather: weather),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('Prévisions sur 5 jours', style: Theme.of(context).textTheme.titleMedium),
            ),
            ResultView(
              value: ref.watch(forecast),
              skeleton: const ForecastSkeleton(),
              onRetry: () => ref.invalidate(forecast),
              builder: (_, days) => Column(
                children: [for (final day in days) DailyForecastTile(forecast: day)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
