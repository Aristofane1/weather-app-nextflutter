import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../domain/weather.dart';
import 'daily_forecast_tile.dart';

/// Les prévisions dans une seule carte ; les barres min/max partagent l'amplitude des jours affichés.
class DailyForecastCard extends StatelessWidget {
  const DailyForecastCard({super.key, required this.days});

  final List<DailyForecast> days;

  @override
  Widget build(BuildContext context) {
    if (days.isEmpty) return const SizedBox.shrink();
    final rangeMin = days.map((d) => d.tempMin).reduce(math.min);
    final rangeMax = days.map((d) => d.tempMax).reduce(math.max);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            for (final (i, day) in days.indexed) ...[
              if (i > 0) const Divider(indent: 16, endIndent: 16),
              DailyForecastTile(forecast: day, rangeMin: rangeMin, rangeMax: rangeMax),
            ],
          ],
        ),
      ),
    );
  }
}
