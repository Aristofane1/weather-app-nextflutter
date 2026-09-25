import 'package:flutter/material.dart';

import '../../../../core/utils/formatters.dart';
import '../../domain/weather.dart';
import 'weather_icon.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({super.key, required this.weather});

  final CurrentWeather weather;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                WeatherIcon(code: weather.iconCode, size: 96),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${weather.temperature.round()}°C', style: text.displaySmall),
                      Text(capitalize(weather.description), style: text.titleMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 24,
              runSpacing: 12,
              children: [
                _Metric(icon: Icons.thermostat, label: 'Ressenti', value: '${weather.feelsLike.round()}°'),
                _Metric(icon: Icons.water_drop_outlined, label: 'Humidité', value: '${weather.humidity} %'),
                _Metric(icon: Icons.air, label: 'Vent', value: '${(weather.windSpeed * 3.6).round()} km/h'),
              ],
            ),
            const SizedBox(height: 12),
            Text('Relevé du ${formatDateTime(weather.date)}', style: text.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 6),
          Text('$label : $value'),
        ],
      );
}
