import '../Data/Auth/User/dto.dart';
import 'enums.dart';

class LoginModuleResult {
  final bool success;
  final String? token;
  final UserDto? user;
  final String? error;
  final DateTime? timestamp;
  final LoginResultType resultType;

  LoginModuleResult.success({required this.user, required this.token})
    : success = true,
      timestamp = null,
      resultType = LoginResultType.success,
      error = null;

  LoginModuleResult.failure(String message)
    : success = false,
      user = null,
      token = null,
      timestamp = null,
      resultType = LoginResultType.error,
      error = message;

  LoginModuleResult({
    required this.success,
    this.token,
    this.user,
    this.error,
    required this.resultType,
  }) : timestamp = DateTime.now();
}
