import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/routes.dart';
import '../../../../core/result/result.dart';
import '../../../../core/widgets/skeleton.dart';
import '../../../../core/utils/formatters.dart';
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

    return Card(
      child: ListTile(
        leading: WeatherIcon(code: weather?.iconCode),
        title: Text(city.name),
        subtitle: Text(weather == null ? city.subtitle : capitalize(weather.description)),
        trailing: switch (result) {
          Success(:final data) => Text(
              '${data.temperature.round()}°',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          Failed() => const Icon(Icons.cloud_off_rounded),
          null => const Skeleton(child: SkeletonBox(width: 48, height: 24)),
        },
        onTap: () => context.push(Routes.cityLocation(city)),
      ),
    );
  }
}
