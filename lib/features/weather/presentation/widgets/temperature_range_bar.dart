import 'package:flutter/material.dart';

/// Barre horizontale min/max d'une journée, positionnée dans l'amplitude
/// globale des prévisions ([rangeMin]..[rangeMax]). Décorative : les valeurs sont lues à côté.
class TemperatureRangeBar extends StatelessWidget {
  const TemperatureRangeBar({
    super.key,
    required this.min,
    required this.max,
    required this.rangeMin,
    required this.rangeMax,
  });

  final double min;
  final double max;
  final double rangeMin;
  final double rangeMax;

  static const fillKey = Key('temperature_range_fill');

  /// Positions relatives (0..1) du début et de la fin de la barre.
  static ({double start, double end}) fractions({
    required double min,
    required double max,
    required double rangeMin,
    required double rangeMax,
  }) {
    final span = rangeMax - rangeMin;
    if (span <= 0) return (start: 0.0, end: 1.0);
    return (
      start: ((min - rangeMin) / span).clamp(0.0, 1.0),
      end: ((max - rangeMin) / span).clamp(0.0, 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final f = fractions(min: min, max: max, rangeMin: rangeMin, rangeMax: rangeMax);
    return SizedBox(
      height: 6,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          return Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Positioned(
                key: fillKey,
                left: f.start * width,
                right: (1 - f.end) * width,
                top: 0,
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(3)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
