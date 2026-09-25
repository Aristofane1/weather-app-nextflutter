import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String message) => _show(
      context,
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );

void showInfoSnackBar(BuildContext context, String message) =>
    _show(context, SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));

void _show(BuildContext context, SnackBar snackBar) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
