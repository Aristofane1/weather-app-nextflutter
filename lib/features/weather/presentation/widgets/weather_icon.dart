import 'package:flutter/material.dart';

/// Icône OWM. Hors ligne (image non chargée), une icône Material la remplace.
class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key, required this.code, this.size = 48});

  final String? code;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (code == null) return SizedBox.square(dimension: size);
    return Image.network(
      'https://openweathermap.org/img/wn/$code@2x.png',
      width: size,
      height: size,
      errorBuilder: (_, _, _) => Icon(Icons.cloud_outlined, size: size * 0.7),
    );
  }
}
