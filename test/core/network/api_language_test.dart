import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/api_language.dart';

void main() {
  test('apiLanguageFor maps locales to supported API languages', () {
    expect(apiLanguageFor(const Locale('fr')), 'fr');
    expect(apiLanguageFor(const Locale('fr', 'CA')), 'fr');
    expect(apiLanguageFor(const Locale('en', 'US')), 'en');
    expect(apiLanguageFor(const Locale('de')), 'en');
  });
}
