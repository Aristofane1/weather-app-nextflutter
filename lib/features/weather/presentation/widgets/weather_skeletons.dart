import 'package:flutter/material.dart';

import '../../../../core/widgets/skeleton.dart';

class CurrentWeatherSkeleton extends StatelessWidget {
  const CurrentWeatherSkeleton({super.key});

  @override
  Widget build(BuildContext context) => const Skeleton(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SkeletonBox(width: 96, height: 96, radius: 48),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonBox(width: 120, height: 40),
                      SizedBox(height: 8),
                      SkeletonBox(width: 160),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              SkeletonBox(height: 20),
            ],
          ),
        ),
      );
}

class ForecastSkeleton extends StatelessWidget {
  const ForecastSkeleton({super.key});

  @override
  Widget build(BuildContext context) => Skeleton(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              for (var i = 0; i < 5; i++)
                const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: SkeletonTile()),
            ],
          ),
        ),
      );
}
