import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get appTitle;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your cities\' weather, at a glance'**
  String get loginSubtitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get loginButton;

  /// No description provided for @goToRegister.
  ///
  /// In en, this message translates to:
  /// **'No account? Create one'**
  String get goToRegister;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your favorite cities, in sync'**
  String get registerSubtitle;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Create my account'**
  String get registerButton;

  /// No description provided for @goToLogin.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get goToLogin;

  /// No description provided for @accountCreatedConfirmEmail.
  ///
  /// In en, this message translates to:
  /// **'Account created! Confirm your email, then sign in.'**
  String get accountCreatedConfirmEmail;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsDontMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDontMatch;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'My cities'**
  String get homeTitle;

  /// No description provided for @profileTooltip.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTooltip;

  /// No description provided for @addCityFab.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addCityFab;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'No favorite cities yet'**
  String get noFavorites;

  /// No description provided for @addCityButton.
  ///
  /// In en, this message translates to:
  /// **'Add a city'**
  String get addCityButton;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search for a city…'**
  String get searchHint;

  /// No description provided for @searchPrompt.
  ///
  /// In en, this message translates to:
  /// **'Type a city name'**
  String get searchPrompt;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No city found for \"{query}\"'**
  String searchNoResults(String query);

  /// No description provided for @addCityToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add {city} to favorites'**
  String addCityToFavorites(String city);

  /// No description provided for @removeCityFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove {city} from favorites'**
  String removeCityFromFavorites(String city);

  /// No description provided for @cityAdded.
  ///
  /// In en, this message translates to:
  /// **'{city} added to favorites'**
  String cityAdded(String city);

  /// No description provided for @cityRemoved.
  ///
  /// In en, this message translates to:
  /// **'{city} removed from favorites'**
  String cityRemoved(String city);

  /// No description provided for @forecastTitle.
  ///
  /// In en, this message translates to:
  /// **'5-day forecast'**
  String get forecastTitle;

  /// No description provided for @feelsLike.
  ///
  /// In en, this message translates to:
  /// **'Feels like'**
  String get feelsLike;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @wind.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wind;

  /// No description provided for @metricValue.
  ///
  /// In en, this message translates to:
  /// **'{label}: {value}'**
  String metricValue(String label, String value);

  /// No description provided for @windSpeed.
  ///
  /// In en, this message translates to:
  /// **'{speed} km/h'**
  String windSpeed(int speed);

  /// No description provided for @observedAt.
  ///
  /// In en, this message translates to:
  /// **'Observed {time}'**
  String observedAt(String time);

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @signedIn.
  ///
  /// In en, this message translates to:
  /// **'Signed in'**
  String get signedIn;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get loading;

  /// No description provided for @configErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid configuration'**
  String get configErrorTitle;

  /// No description provided for @configErrorHint.
  ///
  /// In en, this message translates to:
  /// **'Copy .env.example to .env and fill in the keys.'**
  String get configErrorHint;

  /// No description provided for @configMissingKey.
  ///
  /// In en, this message translates to:
  /// **'Missing {key} variable in .env'**
  String configMissingKey(String key);

  /// No description provided for @temperatureDegrees.
  ///
  /// In en, this message translates to:
  /// **'{temp, plural, one{{temp} degree} other{{temp} degrees}}'**
  String temperatureDegrees(int temp);

  /// No description provided for @minMaxDegrees.
  ///
  /// In en, this message translates to:
  /// **'minimum {min, plural, one{{min} degree} other{{min} degrees}}, maximum {max, plural, one{{max} degree} other{{max} degrees}}'**
  String minMaxDegrees(int min, int max);

  /// No description provided for @cityWeatherSemantics.
  ///
  /// In en, this message translates to:
  /// **'{city}, {temp, plural, one{{temp} degree} other{{temp} degrees}}, {description}'**
  String cityWeatherSemantics(String city, int temp, String description);

  /// No description provided for @cityWeatherLoading.
  ///
  /// In en, this message translates to:
  /// **'{city}, weather loading'**
  String cityWeatherLoading(String city);

  /// No description provided for @cityWeatherUnavailable.
  ///
  /// In en, this message translates to:
  /// **'{city}, weather unavailable'**
  String cityWeatherUnavailable(String city);

  /// No description provided for @cityDetailHint.
  ///
  /// In en, this message translates to:
  /// **'Show details'**
  String get cityDetailHint;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorNetwork;

  /// No description provided for @errorTimeout.
  ///
  /// In en, this message translates to:
  /// **'The server is taking too long to respond'**
  String get errorTimeout;

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Session expired, please sign in again'**
  String get errorUnauthorized;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get errorInvalidCredentials;

  /// No description provided for @errorEmailAlreadyUsed.
  ///
  /// In en, this message translates to:
  /// **'This email is already in use'**
  String get errorEmailAlreadyUsed;

  /// No description provided for @errorEmailNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Email not confirmed: click the link you received by email before signing in'**
  String get errorEmailNotConfirmed;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'Resource not found'**
  String get errorNotFound;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Server error ({code})'**
  String errorServer(int code);

  /// No description provided for @errorConflict.
  ///
  /// In en, this message translates to:
  /// **'This item already exists'**
  String get errorConflict;

  /// No description provided for @errorOfflineAction.
  ///
  /// In en, this message translates to:
  /// **'Action unavailable offline'**
  String get errorOfflineAction;

  /// No description provided for @errorCache.
  ///
  /// In en, this message translates to:
  /// **'Local data unavailable'**
  String get errorCache;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get errorUnknown;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
