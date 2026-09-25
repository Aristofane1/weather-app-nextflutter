import 'package:flutter/material.dart';

import '../../../../core/utils/formatters.dart';
import '../../../../l10n/l10n.dart';
import '../../domain/weather.dart';
import 'temperature_range_bar.dart';
import 'weather_icon.dart';

/// Ligne de prévision : jour, icône, min°, barre min/max, max°.
/// [rangeMin]/[rangeMax] : amplitude globale des jours affichés, pour aligner les barres.
class DailyForecastTile extends StatelessWidget {
  const DailyForecastTile({super.key, required this.forecast, required this.rangeMin, required this.rangeMax});

  final DailyForecast forecast;
  final double rangeMin;
  final double rangeMax;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final min = forecast.tempMin.round();
    final max = forecast.tempMax.round();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              formatDay(forecast.day, locale: context.lang, todayLabel: context.l10n.today),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          // L'icône porte la description pour le lecteur d'écran (le texte n'est plus affiché dans la ligne).
          Semantics(
            label: capitalize(forecast.description),
            child: WeatherIcon(code: forecast.iconCode, size: 32),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Semantics(
              label: context.l10n.minMaxDegrees(min, max),
              excludeSemantics: true,
              child: Row(
                children: [
                  SizedBox(
                    width: 32,
                    child: Text(
                      '$min°',
                      textAlign: TextAlign.end,
                      style: text.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TemperatureRangeBar(
                      min: forecast.tempMin,
                      max: forecast.tempMax,
                      rangeMin: rangeMin,
                      rangeMax: rangeMax,
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 32,
                    child: Text('$max°', style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
