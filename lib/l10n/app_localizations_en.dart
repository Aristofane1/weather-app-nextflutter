// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Weather';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle => 'Your cities\' weather, at a glance';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Sign in';

  @override
  String get goToRegister => 'No account? Create one';

  @override
  String get registerTitle => 'Create an account';

  @override
  String get registerSubtitle => 'Your favorite cities, in sync';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get registerButton => 'Create my account';

  @override
  String get goToLogin => 'Already have an account? Sign in';

  @override
  String get accountCreatedConfirmEmail =>
      'Account created! Confirm your email, then sign in.';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Invalid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'At least 6 characters';

  @override
  String get passwordsDontMatch => 'Passwords do not match';

  @override
  String get homeTitle => 'My cities';

  @override
  String get profileTooltip => 'Profile';

  @override
  String get addCityFab => 'Add';

  @override
  String get noFavorites => 'No favorite cities yet';

  @override
  String get addCityButton => 'Add a city';

  @override
  String get searchHint => 'Search for a city…';

  @override
  String get searchPrompt => 'Type a city name';

  @override
  String searchNoResults(String query) {
    return 'No city found for \"$query\"';
  }

  @override
  String addCityToFavorites(String city) {
    return 'Add $city to favorites';
  }

  @override
  String removeCityFromFavorites(String city) {
    return 'Remove $city from favorites';
  }

  @override
  String cityAdded(String city) {
    return '$city added to favorites';
  }

  @override
  String cityRemoved(String city) {
    return '$city removed from favorites';
  }

  @override
  String get forecastTitle => '5-day forecast';

  @override
  String get feelsLike => 'Feels like';

  @override
  String get humidity => 'Humidity';

  @override
  String get wind => 'Wind';

  @override
  String metricValue(String label, String value) {
    return '$label: $value';
  }

  @override
  String windSpeed(int speed) {
    return '$speed km/h';
  }

  @override
  String observedAt(String time) {
    return 'Observed $time';
  }

  @override
  String get today => 'Today';

  @override
  String get profileTitle => 'Profile';

  @override
  String get signedIn => 'Signed in';

  @override
  String get signOut => 'Sign out';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading…';

  @override
  String get configErrorTitle => 'Invalid configuration';

  @override
  String get configErrorHint =>
      'Copy .env.example to .env and fill in the keys.';

  @override
  String configMissingKey(String key) {
    return 'Missing $key variable in .env';
  }

  @override
  String temperatureDegrees(int temp) {
    String _temp0 = intl.Intl.pluralLogic(
      temp,
      locale: localeName,
      other: '$temp degrees',
      one: '$temp degree',
    );
    return '$_temp0';
  }

  @override
  String minMaxDegrees(int min, int max) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min degrees',
      one: '$min degree',
    );
    String _temp1 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: '$max degrees',
      one: '$max degree',
    );
    return 'minimum $_temp0, maximum $_temp1';
  }

  @override
  String cityWeatherSemantics(String city, int temp, String description) {
    String _temp0 = intl.Intl.pluralLogic(
      temp,
      locale: localeName,
      other: '$temp degrees',
      one: '$temp degree',
    );
    return '$city, $_temp0, $description';
  }

  @override
  String cityWeatherLoading(String city) {
    return '$city, weather loading';
  }

  @override
  String cityWeatherUnavailable(String city) {
    return '$city, weather unavailable';
  }

  @override
  String get cityDetailHint => 'Show details';

  @override
  String get errorNetwork => 'No internet connection';

  @override
  String get errorTimeout => 'The server is taking too long to respond';

  @override
  String get errorUnauthorized => 'Session expired, please sign in again';

  @override
  String get errorInvalidCredentials => 'Incorrect email or password';

  @override
  String get errorEmailAlreadyUsed => 'This email is already in use';

  @override
  String get errorEmailNotConfirmed =>
      'Email not confirmed: click the link you received by email before signing in';

  @override
  String get errorNotFound => 'Resource not found';

  @override
  String errorServer(int code) {
    return 'Server error ($code)';
  }

  @override
  String get errorConflict => 'This item already exists';

  @override
  String get errorOfflineAction => 'Action unavailable offline';

  @override
  String get errorCache => 'Local data unavailable';

  @override
  String get errorUnknown => 'An unexpected error occurred';
}
