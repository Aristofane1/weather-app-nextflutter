import 'dart:ui';

/// Langue envoyée à OWM (paramètre `lang`) : `fr` pour le français, sinon `en`.
String apiLanguageFor(Locale locale) => locale.languageCode == 'fr' ? 'fr' : 'en';
