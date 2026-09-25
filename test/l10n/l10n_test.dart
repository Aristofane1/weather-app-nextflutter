import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../helpers/localized_app.dart';

Set<String> _keys(String path) =>
    (jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>).keys.where((k) => !k.startsWith('@')).toSet();

void main() {
  test('fr and en ARB files define the same keys', () {
    expect(_keys('lib/l10n/app_fr.arb'), _keys('lib/l10n/app_en.arb'));
  });

  test('both languages resolve', () {
    expect(l10nFr.loginButton, 'Se connecter');
    expect(l10nEn.loginButton, 'Sign in');
    expect(l10nFr.errorServer(503), 'Erreur serveur (503)');
    expect(l10nEn.cityWeatherSemantics('Paris', 21, 'clear sky'), 'Paris, 21 degrees, clear sky');
  });

  test('degrees agree in number', () {
    expect(l10nFr.temperatureDegrees(1), '1 degré');
    expect(l10nFr.temperatureDegrees(21), '21 degrés');
    expect(l10nEn.temperatureDegrees(1), '1 degree');
  });
}
