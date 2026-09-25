// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Météo';

  @override
  String get loginTitle => 'Connexion';

  @override
  String get loginSubtitle => 'Retrouvez la météo de vos villes';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get goToRegister => 'Pas de compte ? Créer un compte';

  @override
  String get registerTitle => 'Créer un compte';

  @override
  String get registerSubtitle => 'Vos villes favorites, synchronisées';

  @override
  String get confirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get registerButton => 'Créer mon compte';

  @override
  String get goToLogin => 'Déjà un compte ? Se connecter';

  @override
  String get accountCreatedConfirmEmail =>
      'Compte créé ! Confirmez votre email puis connectez-vous.';

  @override
  String get emailRequired => 'Email requis';

  @override
  String get emailInvalid => 'Email invalide';

  @override
  String get passwordRequired => 'Mot de passe requis';

  @override
  String get passwordTooShort => '6 caractères minimum';

  @override
  String get passwordsDontMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get homeTitle => 'Mes villes';

  @override
  String get profileTooltip => 'Profil';

  @override
  String get addCityFab => 'Ajouter';

  @override
  String get noFavorites => 'Aucune ville favorite pour le moment';

  @override
  String get addCityButton => 'Ajouter une ville';

  @override
  String get searchHint => 'Rechercher une ville…';

  @override
  String get searchPrompt => 'Tapez le nom d\'une ville';

  @override
  String searchNoResults(String query) {
    return 'Aucune ville trouvée pour « $query »';
  }

  @override
  String addCityToFavorites(String city) {
    return 'Ajouter $city aux favoris';
  }

  @override
  String removeCityFromFavorites(String city) {
    return 'Retirer $city des favoris';
  }

  @override
  String cityAdded(String city) {
    return '$city ajoutée aux favoris';
  }

  @override
  String cityRemoved(String city) {
    return '$city retirée des favoris';
  }

  @override
  String get forecastTitle => 'Prévisions sur 5 jours';

  @override
  String get feelsLike => 'Ressenti';

  @override
  String get humidity => 'Humidité';

  @override
  String get wind => 'Vent';

  @override
  String metricValue(String label, String value) {
    return '$label : $value';
  }

  @override
  String windSpeed(int speed) {
    return '$speed km/h';
  }

  @override
  String observedAt(String time) {
    return 'Relevé du $time';
  }

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get profileTitle => 'Profil';

  @override
  String get signedIn => 'Connecté';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get languageLabel => 'Langue';

  @override
  String get languageSystem => 'Système';

  @override
  String get retry => 'Réessayer';

  @override
  String get loading => 'Chargement…';

  @override
  String get configErrorTitle => 'Configuration invalide';

  @override
  String get configErrorHint =>
      'Copiez .env.example en .env et renseignez les clés.';

  @override
  String configMissingKey(String key) {
    return 'Variable $key manquante dans .env';
  }

  @override
  String temperatureDegrees(int temp) {
    String _temp0 = intl.Intl.pluralLogic(
      temp,
      locale: localeName,
      other: '$temp degrés',
      one: '$temp degré',
    );
    return '$_temp0';
  }

  @override
  String minMaxDegrees(int min, int max) {
    String _temp0 = intl.Intl.pluralLogic(
      min,
      locale: localeName,
      other: '$min degrés',
      one: '$min degré',
    );
    String _temp1 = intl.Intl.pluralLogic(
      max,
      locale: localeName,
      other: '$max degrés',
      one: '$max degré',
    );
    return 'minimum $_temp0, maximum $_temp1';
  }

  @override
  String cityWeatherSemantics(String city, int temp, String description) {
    String _temp0 = intl.Intl.pluralLogic(
      temp,
      locale: localeName,
      other: '$temp degrés',
      one: '$temp degré',
    );
    return '$city, $_temp0, $description';
  }

  @override
  String cityWeatherLoading(String city) {
    return '$city, météo en cours de chargement';
  }

  @override
  String cityWeatherUnavailable(String city) {
    return '$city, météo indisponible';
  }

  @override
  String get cityDetailHint => 'Voir le détail';

  @override
  String get errorNetwork => 'Pas de connexion internet';

  @override
  String get errorTimeout => 'Le serveur met trop de temps à répondre';

  @override
  String get errorUnauthorized => 'Session expirée, reconnectez-vous';

  @override
  String get errorInvalidCredentials => 'Email ou mot de passe incorrect';

  @override
  String get errorEmailAlreadyUsed => 'Cet email est déjà utilisé';

  @override
  String get errorEmailNotConfirmed =>
      'Email non confirmé : cliquez sur le lien reçu par email avant de vous connecter';

  @override
  String get errorNotFound => 'Ressource introuvable';

  @override
  String errorServer(int code) {
    return 'Erreur serveur ($code)';
  }

  @override
  String get errorConflict => 'Cet élément existe déjà';

  @override
  String get errorOfflineAction => 'Action impossible hors ligne';

  @override
  String get errorCache => 'Données locales indisponibles';

  @override
  String get errorUnknown => 'Une erreur inattendue est survenue';
}
