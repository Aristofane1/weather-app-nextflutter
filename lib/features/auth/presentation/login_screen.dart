import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/result/result.dart';
import '../../../core/widgets/snackbars.dart';
import 'auth_controller.dart';
import 'validators.dart';
import 'widgets/auth_form_scaffold.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final result = await ref.read(authControllerProvider.notifier).signIn(_email.text, _password.text);
    if (!mounted) return;
    setState(() => _loading = false);
    if (result case Failed(:final failure)) showErrorSnackBar(context, failure.message);
  }

  @override
  Widget build(BuildContext context) {
    return AuthFormScaffold(
      title: 'Connexion',
      subtitle: 'Retrouvez la météo de vos villes',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              key: const Key('login_email'),
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.mail_outline)),
              validator: validateEmail,
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('login_password'),
              controller: _password,
              obscureText: true,
              autofillHints: const [AutofillHints.password],
              decoration: const InputDecoration(labelText: 'Mot de passe', prefixIcon: Icon(Icons.lock_outline)),
              validator: validatePassword,
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Se connecter'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go(Routes.register),
              child: const Text('Pas de compte ? Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}
