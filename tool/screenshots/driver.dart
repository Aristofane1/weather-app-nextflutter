import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

/// Pilote côté hôte : écrit chaque capture reçue de `tour.dart` dans `screenshots/`.
Future<void> main() => integrationDriver(
      onScreenshot: (name, bytes, [args]) async {
        await File('screenshots/$name.png').writeAsBytes(bytes);
        return true;
      },
    );
