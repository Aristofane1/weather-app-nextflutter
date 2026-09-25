import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'support/app_harness.dart';
import 'support/fakes.dart';

/// Remplace `tester.pageBack()` : celui-ci cherche le tooltip anglais « Back »
/// (jamais localisé) puis, à défaut, un `CupertinoNavigationBarBackButton`.
/// L'app est en français et utilise l'`AppBar` Material par défaut (`BackButton`),
/// donc aucun des deux candidats ne matche : on retrouve le bouton par son type.
Future<void> _pageBack(WidgetTester tester) async {
  await tester.tap(find.byType(BackButton));
  await tester.pumpAndSettle();
}

void main() {
  // Contrairement à un test widget (`flutter_test` seul, rendu simulé en mémoire),
  // ce binding pilote une vraie app compilée dans un moteur Flutter réel
  // (`flutter-tester` en local, un appareil/émulateur en CI) : vrais frames, vrai
  // rendu ; les gestes (tap, saisie…) sont simulés mais passent par le vrai moteur
  // et le vrai pipeline de gestes (pas d'écran tactile sur `flutter-tester`).
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('connexion, ajout de Paris, détail puis déconnexion', (tester) async {
    // Le harness monte la vraie app (routeur go_router, écrans, providers Riverpod)
    // sur des repositories factices (`FakeAuthRepository`, etc.), avec un stockage
    // local (cache, réglages) en mémoire et les images réseau désactivées : le test
    // reste déterministe et ne dépend ni du réseau ni de clés API, tout en exerçant
    // le vrai code de navigation, d'état et d'UI.
    await pumpWeatherApp(tester);
    expect(find.text('Connexion'), findsOneWidget);

    // 1. Connexion
    await tester.enterText(find.byKey(const Key('login_email')), FakeAuthRepository.email);
    await tester.enterText(find.byKey(const Key('login_password')), FakeAuthRepository.password);
    await tester.tap(find.text('Se connecter'));
    // `pumpAndSettle` rejoue les frames jusqu'à ce qu'il n'y ait plus aucune
    // animation ni frame planifiée (transition de route, indicateur de chargement…) :
    // on attend que l'écran soit stable avant de l'inspecter.
    await tester.pumpAndSettle();
    expect(find.text('Aucune ville favorite pour le moment'), findsOneWidget);

    // 2. Ajout d'une ville
    await tester.tap(find.text('Ajouter'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Par');
    // La recherche est différée (debounce) de 500 ms avant de partir : un simple
    // `pumpAndSettle` ne suffit pas tant que ce délai n'est pas écoulé, d'où ce
    // `pump` explicite.
    await tester.pump(const Duration(milliseconds: 500)); // debounce de la recherche
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Ajouter Paris aux favoris'));
    await tester.pumpAndSettle();
    expect(find.text('Paris ajoutée aux favoris'), findsOneWidget);

    // 3. Retour à la liste des favoris
    await _pageBack(tester);
    expect(find.text('Paris'), findsOneWidget);
    expect(find.text('21°'), findsOneWidget);

    // 4. Détail de la ville
    await tester.tap(find.text('Paris'));
    await tester.pumpAndSettle();
    expect(find.text('Prévisions sur 5 jours'), findsOneWidget);
    expect(find.text('21°C'), findsOneWidget);

    // 5. Déconnexion
    await _pageBack(tester);
    await tester.tap(find.byTooltip('Profil'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Se déconnecter'));
    await tester.pumpAndSettle();
    expect(find.text('Connexion'), findsOneWidget);
  });
}
