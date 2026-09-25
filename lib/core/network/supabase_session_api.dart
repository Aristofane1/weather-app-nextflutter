import 'package:dio/dio.dart';

import '../storage/auth_session.dart';

/// `authDio` ne doit PAS porter l'AuthInterceptor (sinon deadlock de la file).
Future<AuthSession> refreshSupabaseSession(Dio authDio, String refreshToken) async {
  final res = await authDio.post<Map<String, dynamic>>(
    '/auth/v1/token',
    queryParameters: {'grant_type': 'refresh_token'},
    data: {'refresh_token': refreshToken},
  );
  return AuthSession.fromSupabase(res.data!);
}
