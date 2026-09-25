import 'package:flutter/material.dart';

import '../../../../core/utils/formatters.dart';
import '../../domain/weather.dart';
import 'weather_icon.dart';

class DailyForecastTile extends StatelessWidget {
  const DailyForecastTile({super.key, required this.forecast});

  final DailyForecast forecast;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: WeatherIcon(code: forecast.iconCode, size: 40),
        title: Text(formatDay(forecast.day)),
        subtitle: Text(capitalize(forecast.description)),
        trailing: Text(
          '${forecast.tempMin.round()}° / ${forecast.tempMax.round()}°',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
}
