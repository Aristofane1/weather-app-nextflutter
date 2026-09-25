import 'package:dio/dio.dart';

class CitiesRemoteDataSource {
  CitiesRemoteDataSource({required Dio owm, required Dio supabase})
      : _owm = owm,
        _supabase = supabase;

  final Dio _owm;

  /// Client portant l'AuthInterceptor : la RLS filtre par `auth.uid()`.
  final Dio _supabase;

  static const _table = '/rest/v1/favorite_cities';

  Future<List<dynamic>> search(String query) async {
    final res = await _owm.get<List<dynamic>>('/geo/1.0/direct', queryParameters: {'q': query, 'limit': 5});
    return res.data!;
  }

  Future<List<dynamic>> fetchFavorites() async {
    final res = await _supabase.get<List<dynamic>>(
      _table,
      queryParameters: {'select': 'id,name,country,state,lat,lon', 'order': 'created_at.asc'},
    );
    return res.data!;
  }

  Future<Map<String, dynamic>> addFavorite(Map<String, dynamic> body) async {
    final res = await _supabase.post<List<dynamic>>(
      _table,
      data: body,
      options: Options(headers: {'Prefer': 'return=representation'}),
    );
    return res.data!.first as Map<String, dynamic>;
  }

  Future<void> removeFavorite(int id) async {
    await _supabase.delete<void>(_table, queryParameters: {'id': 'eq.$id'});
  }
}
