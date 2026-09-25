import 'dart:io';

import 'package:dio/dio.dart';

import 'failure.dart';

/// Convertit toute erreur remontée par la couche data en [Failure].
Failure toFailure(Object error) => switch (error) {
      Failure() => error,
      DioException() => failureFromDio(error),
      SocketException() => const Failure.network(),
      _ => const Failure.unknown(),
    };

Failure failureFromDio(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      return const Failure.network();
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
      return const Failure.timeout();
    case DioExceptionType.badResponse:
      return _failureFromResponse(e.response);
    case DioExceptionType.unknown:
      return e.error is SocketException ? const Failure.network() : const Failure.unknown();
    case DioExceptionType.cancel:
    case DioExceptionType.badCertificate:
      return const Failure.unknown();
  }
}

Failure _failureFromResponse(Response<dynamic>? response) {
  final status = response?.statusCode ?? 0;
  final body = response?.data;
  final map = body is Map ? body : const <String, dynamic>{};
  final code = '${map['error_code'] ?? map['error'] ?? ''}';
  final msg = '${map['msg'] ?? map['error_description'] ?? map['message'] ?? ''}'.toLowerCase();

  // Codes d'erreur de Supabase Auth (GoTrue).
  if (code == 'invalid_credentials' || code == 'invalid_grant' || msg.contains('invalid login credentials')) {
    return const Failure.invalidCredentials();
  }
  if (code == 'email_not_confirmed' || msg.contains('email not confirmed')) {
    return const Failure.emailNotConfirmed();
  }
  if (code == 'user_already_exists' || msg.contains('already registered')) {
    return const Failure.emailAlreadyUsed();
  }
  if (status == 401) return const Failure.unauthorized();
  if (status == 404) return const Failure.notFound();
  // Contrainte d'unicité PostgREST (ex. double ajout d'un favori).
  if (status == 409) return const Failure.conflict();
  return Failure.server(status);
}
