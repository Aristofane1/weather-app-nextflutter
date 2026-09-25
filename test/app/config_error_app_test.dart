import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/app/config_error_app.dart';
import 'package:weather_app/core/config/env.dart';

void main() {
  test('Env.validate fails with a readable message when keys are missing', () {
    dotenv.loadFromString(envString: '', isOptional: true);
    Object? error;
    try {
      Env.validate();
    } catch (e) {
      error = e;
    }
    expect(configErrorMessage(error!), 'Variable SUPABASE_URL manquante dans .env (voir .env.example)');
  });

  testWidgets('ConfigErrorApp explains the configuration problem', (tester) async {
    await tester.pumpWidget(const ConfigErrorApp(message: 'Variable OWM_API_KEY manquante'));

    expect(find.text('Configuration invalide'), findsOneWidget);
    expect(find.text('Variable OWM_API_KEY manquante'), findsOneWidget);
    expect(find.text('Copiez .env.example en .env et renseignez les clés.'), findsOneWidget);
  });
}
