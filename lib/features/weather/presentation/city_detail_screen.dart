import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/result_view.dart';
import '../../../l10n/l10n.dart';
import 'weather_providers.dart';
import 'widgets/current_weather_card.dart';
import 'widgets/daily_forecast_card.dart';
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
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            ResultView(
              value: ref.watch(current),
              skeleton: const CurrentWeatherSkeleton(),
              onRetry: () => ref.invalidate(current),
              builder: (_, weather) => CurrentWeatherCard(weather: weather),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 24, 4, 12),
              child: Text(context.l10n.forecastTitle, style: Theme.of(context).textTheme.titleMedium),
            ),
            ResultView(
              value: ref.watch(forecast),
              skeleton: const ForecastSkeleton(),
              onRetry: () => ref.invalidate(forecast),
              builder: (_, days) => DailyForecastCard(days: days),
            ),
          ],
        ),
      ),
    );
  }
}
