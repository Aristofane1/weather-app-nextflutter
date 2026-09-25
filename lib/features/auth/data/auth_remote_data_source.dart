import 'package:dio/dio.dart';

/// Endpoints Supabase Auth (GoTrue). Utilise le client sans AuthInterceptor.
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/v1/token',
      queryParameters: {'grant_type': 'password'},
      data: {'email': email, 'password': password},
    );
    return res.data!;
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/v1/signup',
      data: {'email': email, 'password': password},
    );
    return res.data!;
  }

  Future<void> signOut(String accessToken) async {
    await _dio.post<void>(
      '/auth/v1/logout',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }
}
