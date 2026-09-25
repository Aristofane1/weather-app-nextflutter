import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/result_view.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/snackbars.dart';
import '../domain/city.dart';
import 'cities_providers.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;
  String _query = '';

  /// Villes dont l'ajout/retrait est en cours : évite les doubles requêtes (double tap).
  final _busy = <String>{};

  static String _key(City city) => '${city.lat},${city.lon}';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), () => setState(() => _query = value.trim()));
  }

  Future<void> _toggle(City city, City? favorite) async {
    final key = _key(city);
    if (!_busy.add(key)) return;
    setState(() {});
    final controller = ref.read(favoritesControllerProvider.notifier);
    final failure = favorite == null ? await controller.add(city) : await controller.remove(favorite);
    if (!mounted) return;
    setState(() => _busy.remove(key));
    if (failure != null) {
      showErrorSnackBar(context, failure.message);
    } else {
      showInfoSnackBar(context, favorite == null ? '${city.name} ajoutée aux favoris' : '${city.name} retirée des favoris');
    }
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoritesProvider).value?.dataOrNull ?? const <City>[];

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: _onChanged,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(hintText: 'Rechercher une ville…', border: InputBorder.none),
        ),
      ),
      body: _query.isEmpty
          ? const EmptyView(icon: Icons.travel_explore, message: "Tapez le nom d'une ville")
          : ResultView(
              value: ref.watch(citySearchProvider(_query)),
              skeleton: const SkeletonList(itemCount: 4),
              onRetry: () => ref.invalidate(citySearchProvider(_query)),
              builder: (context, cities) => cities.isEmpty
                  ? EmptyView(icon: Icons.search_off, message: 'Aucune ville trouvée pour « $_query »')
                  : ListView.builder(
                      itemCount: cities.length,
                      itemBuilder: (_, i) {
                        final city = cities[i];
                        final favorite = favorites.where(city.sameLocation).firstOrNull;
                        final busy = _busy.contains(_key(city));
                        return ListTile(
                          leading: const Icon(Icons.location_city),
                          title: Text(city.name),
                          subtitle: Text(city.subtitle),
                          // Pendant l'action, le bouton est désactivé et le GestureDetector
                          // absorbe le tap pour qu'il n'ouvre pas le détail (onTap du ListTile).
                          trailing: GestureDetector(
                            onTap: busy ? () {} : null,
                            child: IconButton(
                              tooltip: favorite == null ? 'Ajouter aux favoris' : 'Retirer des favoris',
                              icon: Icon(favorite == null ? Icons.star_border : Icons.star),
                              onPressed: busy ? null : () => _toggle(city, favorite),
                            ),
                          ),
                          onTap: () => context.push(Routes.cityLocation(city)),
                        );
                      },
                    ),
            ),
    );
  }
}
