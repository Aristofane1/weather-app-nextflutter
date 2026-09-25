import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session.freezed.dart';
part 'auth_session.g.dart';

@freezed
abstract class AuthSession with _$AuthSession {
  const AuthSession._();

  const factory AuthSession({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
    required String userId,
    required String email,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) => _$AuthSessionFromJson(json);

  /// Réponse de `POST /auth/v1/token` (grant password ou refresh_token).
  factory AuthSession.fromSupabase(Map<String, dynamic> json, {DateTime? now}) {
    final user = json['user'] as Map<String, dynamic>;
    return AuthSession(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      expiresAt: (now ?? DateTime.now()).add(Duration(seconds: (json['expires_in'] as num).toInt())),
      userId: user['id'] as String,
      email: user['email'] as String,
    );
  }

  /// Marge de 30 s pour ne pas envoyer un token qui expire en vol.
  bool isExpired([DateTime? now]) =>
      !(now ?? DateTime.now()).isBefore(expiresAt.subtract(const Duration(seconds: 30)));
}
