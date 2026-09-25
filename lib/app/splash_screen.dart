import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: CircularProgressIndicator(semanticsLabel: context.l10n.loading)));
}
