import 'dart:async';

class MeesangerService {
  static final MeesangerService _instance = MeesangerService._internal();
  factory MeesangerService() => _instance;
  MeesangerService._internal();

  final _controller = StreamController<String>.broadcast();
  Stream<String> get stream => _controller.stream;

  void send(String message) => _controller.add(message);
  void sendError(Object error) => _controller.addError(error);
}
