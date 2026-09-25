import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/error_mapper.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/core/error/failure_l10n.dart';

import '../../helpers/localized_app.dart';

DioException dioError(DioExceptionType type, {int? status, Object? data, Object? error}) {
  final options = RequestOptions(path: '/x');
  return DioException(
    requestOptions: options,
    type: type,
    error: error,
    response: status == null ? null : Response<dynamic>(requestOptions: options, statusCode: status, data: data),
  );
}

void main() {
  test('connection error -> network', () {
    expect(failureFromDio(dioError(DioExceptionType.connectionError)), isA<NetworkFailure>());
  });

  test('unknown with SocketException -> network', () {
    final e = dioError(DioExceptionType.unknown, error: const SocketException('down'));
    expect(failureFromDio(e), isA<NetworkFailure>());
  });

  test('timeouts -> timeout', () {
    expect(failureFromDio(dioError(DioExceptionType.receiveTimeout)), isA<TimeoutFailure>());
    expect(failureFromDio(dioError(DioExceptionType.connectionTimeout)), isA<TimeoutFailure>());
  });

  test('supabase invalid credentials -> invalidCredentials', () {
    final e = dioError(DioExceptionType.badResponse,
        status: 400, data: {'error_code': 'invalid_credentials', 'msg': 'Invalid login credentials'});
    final failure = failureFromDio(e);
    expect(failure, isA<InvalidCredentialsFailure>());
    expect(failure.message(l10nFr), 'Email ou mot de passe incorrect');
  });

  test('supabase user already exists -> emailAlreadyUsed', () {
    final e = dioError(DioExceptionType.badResponse,
        status: 422, data: {'error_code': 'user_already_exists', 'msg': 'User already registered'});
    expect(failureFromDio(e), isA<EmailAlreadyUsedFailure>());
  });

  test('supabase email not confirmed -> emailNotConfirmed', () {
    final e = dioError(DioExceptionType.badResponse,
        status: 400, data: {'code': 400, 'error_code': 'email_not_confirmed', 'msg': 'Email not confirmed'});
    final failure = failureFromDio(e);
    expect(failure, isA<EmailNotConfirmedFailure>());
    expect(failure.message(l10nFr), 'Email non confirmé : cliquez sur le lien reçu par email avant de vous connecter');
  });

  test('status codes -> unauthorized / notFound / server', () {
    expect(failureFromDio(dioError(DioExceptionType.badResponse, status: 401)), isA<UnauthorizedFailure>());
    expect(failureFromDio(dioError(DioExceptionType.badResponse, status: 404)), isA<NotFoundFailure>());
    final server = failureFromDio(dioError(DioExceptionType.badResponse, status: 503));
    expect(server, const Failure.server(503));
    expect(server.message(l10nFr), 'Erreur serveur (503)');
  });

  test('409 -> conflict', () {
    final failure = failureFromDio(dioError(DioExceptionType.badResponse, status: 409));
    expect(failure, isA<ConflictFailure>());
    expect(failure.message(l10nFr), 'Cet élément existe déjà');
  });

  test('toFailure keeps Failure and maps unknown errors', () {
    expect(toFailure(const Failure.cache()), const Failure.cache());
    expect(toFailure(const FormatException('bad')), isA<UnknownFailure>());
    expect(toFailure(dioError(DioExceptionType.connectionError)), isA<NetworkFailure>());
  });
}
