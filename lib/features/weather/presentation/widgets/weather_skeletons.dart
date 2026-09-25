import 'package:flutter/material.dart';

import '../../../../core/widgets/skeleton.dart';

/// Reprend la mise en page de `CurrentWeatherCard` : carte principale + trois mesures.
class CurrentWeatherSkeleton extends StatelessWidget {
  const CurrentWeatherSkeleton({super.key});

  @override
  Widget build(BuildContext context) => const Skeleton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SkeletonBox(height: 236, radius: 16),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: SkeletonBox(height: 100, radius: 16)),
                SizedBox(width: 12),
                Expanded(child: SkeletonBox(height: 100, radius: 16)),
                SizedBox(width: 12),
                Expanded(child: SkeletonBox(height: 100, radius: 16)),
              ],
            ),
          ],
        ),
      );
}

/// Reprend la mise en page de `DailyForecastCard` : cinq lignes dans une carte.
class ForecastSkeleton extends StatelessWidget {
  const ForecastSkeleton({super.key});

  @override
  Widget build(BuildContext context) => Card(
        child: Skeleton(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                for (var i = 0; i < 5; i++)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        SkeletonBox(width: 96),
                        Spacer(),
                        SkeletonBox(width: 32, height: 32, radius: 16),
                        SizedBox(width: 16),
                        SkeletonBox(width: 120, height: 8, radius: 4),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}
