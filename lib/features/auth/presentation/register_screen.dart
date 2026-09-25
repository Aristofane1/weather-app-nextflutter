import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/routes.dart';
import '../../../core/error/failure_l10n.dart';
import '../../../core/result/result.dart';
import '../../../core/widgets/snackbars.dart';
import '../../../l10n/l10n.dart';
import 'auth_controller.dart';
import 'validators.dart';
import 'widgets/auth_form_scaffold.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final result = await ref.read(authControllerProvider.notifier).signUp(_email.text, _password.text);
    if (!mounted) return;
    setState(() => _loading = false);
    switch (result) {
      case Failed(:final failure):
        showErrorSnackBar(context, failure.message(context.l10n));
      case Success(data: null):
        showInfoSnackBar(context, context.l10n.accountCreatedConfirmEmail);
        context.go(Routes.login);
      case Success():
        break; // Session ouverte : le routeur redirige vers l'accueil.
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AuthFormScaffold(
      title: l10n.registerTitle,
      subtitle: l10n.registerSubtitle,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: l10n.emailLabel, prefixIcon: const Icon(Icons.mail_outline)),
              validator: (v) => validateEmail(v, l10n),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _password,
              obscureText: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: l10n.passwordLabel, prefixIcon: const Icon(Icons.lock_outline)),
              validator: (v) => validateNewPassword(v, l10n),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirm,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.confirmPasswordLabel,
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              validator: (v) => v != _password.text ? l10n.passwordsDontMatch : null,
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(l10n.registerButton),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go(Routes.login),
              child: Text(l10n.goToLogin),
            ),
          ],
        ),
      ),
    );
  }
}
