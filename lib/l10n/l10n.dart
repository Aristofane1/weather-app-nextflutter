import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

export 'app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  /// Code de la langue effective (`fr`, `en`), utile pour `DateFormat`.
  String get lang => Localizations.localeOf(this).languageCode;
}
