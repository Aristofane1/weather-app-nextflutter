// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favorites)
final favoritesProvider = FavoritesProvider._();

final class FavoritesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Result<List<City>>>,
          Result<List<City>>,
          Stream<Result<List<City>>>
        >
    with
        $FutureModifier<Result<List<City>>>,
        $StreamProvider<Result<List<City>>> {
  FavoritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesHash();

  @$internal
  @override
  $StreamProviderElement<Result<List<City>>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Result<List<City>>> create(Ref ref) {
    return favorites(ref);
  }
}

String _$favoritesHash() => r'd607b8adf73cb14d27c52ed7f276e880b6d97281';

@ProviderFor(citySearch)
final citySearchProvider = CitySearchFamily._();

final class CitySearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<Result<List<City>>>,
          Result<List<City>>,
          FutureOr<Result<List<City>>>
        >
    with
        $FutureModifier<Result<List<City>>>,
        $FutureProvider<Result<List<City>>> {
  CitySearchProvider._({
    required CitySearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'citySearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$citySearchHash();

  @override
  String toString() {
    return r'citySearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Result<List<City>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Result<List<City>>> create(Ref ref) {
    final argument = this.argument as String;
    return citySearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CitySearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$citySearchHash() => r'43f24fdb838c95e122c09648455b4af8928bbbcd';

final class CitySearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Result<List<City>>>, String> {
  CitySearchFamily._()
    : super(
        retry: null,
        name: r'citySearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CitySearchProvider call(String query) =>
      CitySearchProvider._(argument: query, from: this);

  @override
  String toString() => r'citySearchProvider';
}

/// Actions d'écriture sur les favoris. Elles rafraîchissent la liste en cas de succès.

@ProviderFor(FavoritesController)
final favoritesControllerProvider = FavoritesControllerProvider._();

/// Actions d'écriture sur les favoris. Elles rafraîchissent la liste en cas de succès.
final class FavoritesControllerProvider
    extends $NotifierProvider<FavoritesController, void> {
  /// Actions d'écriture sur les favoris. Elles rafraîchissent la liste en cas de succès.
  FavoritesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesControllerHash();

  @$internal
  @override
  FavoritesController create() => FavoritesController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$favoritesControllerHash() =>
    r'c0dd70147ba114669b719ed09c6a22e979386d7b';

/// Actions d'écriture sur les favoris. Elles rafraîchissent la liste en cas de succès.

abstract class _$FavoritesController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
