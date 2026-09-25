import 'dart:async';

/// Canal core → feature auth : émis quand le refresh token est refusé.
class SessionEvents {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get onExpired => _controller.stream;

  void expired() => _controller.add(null);

  Future<void> dispose() => _controller.close();
}
