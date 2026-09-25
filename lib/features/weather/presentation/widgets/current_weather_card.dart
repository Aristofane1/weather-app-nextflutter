import 'package:flutter/material.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/metric_tile.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/weather.dart';
import 'weather_icon.dart';

/// Météo actuelle : carte principale (icône, température, description, relevé)
/// puis une rangée de trois mesures (ressenti, humidité, vent).
class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({super.key, required this.weather});

  final CurrentWeather weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final l10n = context.l10n;
    final feelsLike = '${weather.feelsLike.round()}°';
    final humidity = '${weather.humidity} %';
    final wind = l10n.windSpeed((weather.windSpeed * 3.6).round());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              children: [
                WeatherIcon(code: weather.iconCode, size: 96),
                Semantics(
                  label: l10n.temperatureDegrees(weather.temperature.round()),
                  excludeSemantics: true,
                  child: Text(
                    '${weather.temperature.round()}°C',
                    style: text.displayLarge?.copyWith(fontWeight: FontWeight.w200, height: 1.1),
                  ),
                ),
                const SizedBox(height: 4),
                Text(capitalize(weather.description), style: text.titleMedium, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(
                  l10n.observedAt(formatDateTime(weather.date, context.lang)),
                  style: text.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // IntrinsicHeight : les trois tuiles gardent la même hauteur.
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: MetricTile(
                  icon: Icons.thermostat,
                  label: l10n.feelsLike,
                  value: feelsLike,
                  semanticsLabel: l10n.metricValue(l10n.feelsLike, feelsLike),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricTile(
                  icon: Icons.water_drop_outlined,
                  label: l10n.humidity,
                  value: humidity,
                  semanticsLabel: l10n.metricValue(l10n.humidity, humidity),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricTile(
                  icon: Icons.air,
                  label: l10n.wind,
                  value: wind,
                  semanticsLabel: l10n.metricValue(l10n.wind, wind),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
