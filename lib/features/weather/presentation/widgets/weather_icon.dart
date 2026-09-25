import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core_providers.dart';

/// Icône OWM, mise en cache sur disque et décodée à la taille affichée.
/// Décorative : la description est toujours lue à côté.
class WeatherIcon extends ConsumerWidget {
  const WeatherIcon({super.key, required this.code, this.size = 48});

  final String? code;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cacheManager = ref.watch(iconCacheManagerProvider);
    final fallback = SizedBox.square(dimension: size, child: Icon(Icons.cloud_outlined, size: size * 0.7));
    if (code == null) return SizedBox.square(dimension: size);
    if (cacheManager == null) return ExcludeSemantics(child: fallback);

    final pixels = (size * MediaQuery.devicePixelRatioOf(context)).round();
    return ExcludeSemantics(
      child: CachedNetworkImage(
        imageUrl: 'https://openweathermap.org/img/wn/$code@2x.png',
        cacheManager: cacheManager,
        width: size,
        height: size,
        memCacheWidth: pixels,
        memCacheHeight: pixels,
        fadeInDuration: const Duration(milliseconds: 150),
        placeholder: (_, _) => SizedBox.square(dimension: size),
        errorWidget: (_, _, _) => fallback,
      ),
    );
  }
}
