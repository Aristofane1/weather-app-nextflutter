import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/error/failure_l10n.dart';

import '../../helpers/localized_app.dart';

const _all = <Failure>[
  Failure.network(),
  Failure.timeout(),
  Failure.unauthorized(),
  Failure.invalidCredentials(),
  Failure.emailAlreadyUsed(),
  Failure.emailNotConfirmed(),
  Failure.notFound(),
  Failure.server(500),
  Failure.conflict(),
  Failure.offlineAction(),
  Failure.cache(),
  Failure.unknown(),
];

void main() {
  test('every failure has a non-empty message in fr and en', () {
    for (final f in _all) {
      expect(f.message(l10nFr), isNotEmpty, reason: '$f fr');
      expect(f.message(l10nEn), isNotEmpty, reason: '$f en');
    }
  });

  test('messages are localized', () {
    expect(const Failure.network().message(l10nFr), 'Pas de connexion internet');
    expect(const Failure.network().message(l10nEn), 'No internet connection');
    expect(const Failure.server(503).message(l10nEn), 'Server error (503)');
  });
}
