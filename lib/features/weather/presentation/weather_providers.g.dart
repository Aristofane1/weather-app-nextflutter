// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(currentWeather)
final currentWeatherProvider = CurrentWeatherFamily._();

final class CurrentWeatherProvider
    extends
        $FunctionalProvider<
          AsyncValue<Result<CurrentWeather>>,
          Result<CurrentWeather>,
          Stream<Result<CurrentWeather>>
        >
    with
        $FutureModifier<Result<CurrentWeather>>,
        $StreamProvider<Result<CurrentWeather>> {
  CurrentWeatherProvider._({
    required CurrentWeatherFamily super.from,
    required (double, double) super.argument,
  }) : super(
         retry: null,
         name: r'currentWeatherProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$currentWeatherHash();

  @override
  String toString() {
    return r'currentWeatherProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<Result<CurrentWeather>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Result<CurrentWeather>> create(Ref ref) {
    final argument = this.argument as (double, double);
    return currentWeather(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentWeatherProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$currentWeatherHash() => r'79c5e9229e1eae18dd4c11242136078bd9fd2a12';

final class CurrentWeatherFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<Result<CurrentWeather>>,
          (double, double)
        > {
  CurrentWeatherFamily._()
    : super(
        retry: null,
        name: r'currentWeatherProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CurrentWeatherProvider call(double lat, double lon) =>
      CurrentWeatherProvider._(argument: (lat, lon), from: this);

  @override
  String toString() => r'currentWeatherProvider';
}

@ProviderFor(dailyForecast)
final dailyForecastProvider = DailyForecastFamily._();

final class DailyForecastProvider
    extends
        $FunctionalProvider<
          AsyncValue<Result<List<DailyForecast>>>,
          Result<List<DailyForecast>>,
          Stream<Result<List<DailyForecast>>>
        >
    with
        $FutureModifier<Result<List<DailyForecast>>>,
        $StreamProvider<Result<List<DailyForecast>>> {
  DailyForecastProvider._({
    required DailyForecastFamily super.from,
    required (double, double) super.argument,
  }) : super(
         retry: null,
         name: r'dailyForecastProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dailyForecastHash();

  @override
  String toString() {
    return r'dailyForecastProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $StreamProviderElement<Result<List<DailyForecast>>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Result<List<DailyForecast>>> create(Ref ref) {
    final argument = this.argument as (double, double);
    return dailyForecast(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is DailyForecastProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dailyForecastHash() => r'9cf9dc892ca21600b34caf44e1ab8186be8f5ec2';

final class DailyForecastFamily extends $Family
    with
        $FunctionalFamilyOverride<
          Stream<Result<List<DailyForecast>>>,
          (double, double)
        > {
  DailyForecastFamily._()
    : super(
        retry: null,
        name: r'dailyForecastProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  DailyForecastProvider call(double lat, double lon) =>
      DailyForecastProvider._(argument: (lat, lon), from: this);

  @override
  String toString() => r'dailyForecastProvider';
}
