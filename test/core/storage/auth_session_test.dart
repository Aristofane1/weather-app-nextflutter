import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/storage/auth_session.dart';

void main() {
  final now = DateTime(2026, 9, 24, 12);
  final supabaseJson = {
    'access_token': 'acc',
    'refresh_token': 'ref',
    'expires_in': 3600,
    'token_type': 'bearer',
    'user': {'id': 'u1', 'email': 'a@b.c'},
  };

  test('fromSupabase computes expiresAt from expires_in', () {
    final s = AuthSession.fromSupabase(supabaseJson, now: now);
    expect(s.accessToken, 'acc');
    expect(s.refreshToken, 'ref');
    expect(s.userId, 'u1');
    expect(s.email, 'a@b.c');
    expect(s.expiresAt, now.add(const Duration(hours: 1)));
  });

  test('isExpired uses a 30s safety margin', () {
    final s = AuthSession.fromSupabase(supabaseJson, now: now);
    expect(s.isExpired(now.add(const Duration(minutes: 58))), isFalse);
    expect(s.isExpired(now.add(const Duration(minutes: 59, seconds: 45))), isTrue);
  });

  test('json round trip', () {
    final s = AuthSession.fromSupabase(supabaseJson, now: now);
    expect(AuthSession.fromJson(s.toJson()), s);
  });
}
