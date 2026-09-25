import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/error/failure_l10n.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/result_view.dart';
import '../../../core/widgets/skeleton.dart';
import '../../../core/widgets/snackbars.dart';
import '../../../l10n/l10n.dart';
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

  /// Champ de recherche en pilule, sans contour.
  static final _pill = OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: BorderSide.none);

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
      showErrorSnackBar(context, failure.message(context.l10n));
    } else {
      showInfoSnackBar(
        context,
        favorite == null ? context.l10n.cityAdded(city.name) : context.l10n.cityRemoved(city.name),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final favorites = ref.watch(favoritesProvider).value?.dataOrNull ?? const <City>[];

    return Scaffold(
      appBar: AppBar(
        // Collé au bouton retour s'il existe, sinon aligné sur la marge de 16.
        titleSpacing: (ModalRoute.of(context)?.canPop ?? false) ? 0 : 16,
        title: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: TextField(
            controller: _controller,
            autofocus: true,
            onChanged: _onChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: l10n.searchHint,
              prefixIcon: const Icon(Icons.search),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              // Champ blanc sur le fond gris de l'AppBar (tonal en thème sombre).
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              border: _pill,
              enabledBorder: _pill,
              focusedBorder: _pill,
            ),
          ),
        ),
      ),
      body: _query.isEmpty
          ? EmptyView(icon: Icons.travel_explore, message: l10n.searchPrompt)
          : ResultView(
              value: ref.watch(citySearchProvider(_query)),
              skeleton: const SkeletonList(itemCount: 4),
              onRetry: () => ref.invalidate(citySearchProvider(_query)),
              builder: (context, cities) => cities.isEmpty
                  ? EmptyView(icon: Icons.search_off, message: l10n.searchNoResults(_query))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: cities.length,
                      itemBuilder: (_, i) {
                        final city = cities[i];
                        final favorite = favorites.where(city.sameLocation).firstOrNull;
                        final busy = _busy.contains(_key(city));
                        return ListTile(
                          // Drapeau décoratif : le pays est déjà lu dans le sous-titre.
                          leading: ExcludeSemantics(
                            child: SizedBox.square(
                              dimension: 40,
                              child: Center(
                                child: Text(countryFlag(city.country), style: const TextStyle(fontSize: 26)),
                              ),
                            ),
                          ),
                          title: Text(city.name),
                          subtitle: Text(city.subtitle),
                          // Pendant l'action, le bouton est désactivé et le GestureDetector
                          // absorbe le tap pour qu'il n'ouvre pas le détail (onTap du ListTile).
                          trailing: GestureDetector(
                            onTap: busy ? () {} : null,
                            excludeFromSemantics: true,
                            // MergeSemantics : le bouton et son état "toggled" ne forment
                            // qu'une seule annonce (sinon deux nœuds sémantiques distincts).
                            child: MergeSemantics(
                              child: Semantics(
                                toggled: favorite != null,
                                child: IconButton(
                                  tooltip: favorite == null
                                      ? l10n.addCityToFavorites(city.name)
                                      : l10n.removeCityFromFavorites(city.name),
                                  icon: Icon(favorite == null ? Icons.star_border : Icons.star),
                                  onPressed: busy ? null : () => _toggle(city, favorite),
                                ),
                              ),
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
