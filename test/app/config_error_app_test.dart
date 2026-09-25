import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/app/config_error_app.dart';
import 'package:weather_app/core/config/env.dart';

void main() {
  test('Env.validate fails with the missing key when keys are missing', () {
    dotenv.loadFromString(envString: '', isOptional: true);
    expect(
      Env.validate,
      throwsA(isA<MissingEnvKey>().having((e) => e.key, 'key', 'SUPABASE_URL')),
    );
  });

  testWidgets('ConfigErrorApp explains the configuration problem', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('fr')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(const ConfigErrorApp(error: MissingEnvKey('OWM_API_KEY')));

    expect(find.text('Configuration invalide'), findsOneWidget);
    expect(find.text('Variable OWM_API_KEY manquante dans .env'), findsOneWidget);
    expect(find.text('Copiez .env.example en .env et renseignez les clés.'), findsOneWidget);
  });

  testWidgets('shows english texts on an english device', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('en')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(const ConfigErrorApp(error: MissingEnvKey('OWM_API_KEY')));

    expect(find.text('Invalid configuration'), findsOneWidget);
    expect(find.text('Missing OWM_API_KEY variable in .env'), findsOneWidget);
    expect(find.text('Copy .env.example to .env and fill in the keys.'), findsOneWidget);
  });
}
