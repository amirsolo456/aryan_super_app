import '../Data/Auth/Login/dto.dart';
import '../Data/Auth/User/dto.dart';
import 'enums.dart';

class LoginModuleResult {
  final bool success;
  final String? token;
  final UserDto? user;
  String? error;
  final DateTime timestamp;
  final LoginResultType resultType;
  final String? cachedKey;
  final ManagementAccounts? selectedManagementAccount;
  final List<ManagementAccounts>? managementAccount;

  LoginModuleResult.success({
    required this.user,
    required this.token,
    required String cachedKey,
    required List<ManagementAccounts>? managementAccount,
    required ManagementAccounts selectedManagementAccount,
  })
      : success = true,
        cachedKey = cachedKey ?? null,
        selectedManagementAccount = selectedManagementAccount ?? null,
        managementAccount = managementAccount ?? null,
        timestamp = DateTime.now(),
        resultType = LoginResultType.success,
        error = null;

  LoginModuleResult.failure(String message)
      : success = false,
        user = null,
        token = null,
        timestamp = DateTime.now(),
        cachedKey = null,
        managementAccount = null,
        selectedManagementAccount = null,
        resultType = LoginResultType.error,
        error = message;

  LoginModuleResult({
    required this.success,
    this.token,
    this.user,
    this.error,
    this.cachedKey,
    this.managementAccount,
    this.selectedManagementAccount,
    required this.resultType,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() =>
      {
        'success': success,
        'token': token,
        'user': user?.toJson(),
        'error': error,
        'cachedKey': cachedKey,
        'managementAccount': managementAccount,
        'selectedManagementAccount': selectedManagementAccount,
        'resultType': resultType.index,
        'timestamp': timestamp.toIso8601String(),
      };

  factory LoginModuleResult.fromJson(Map<String, dynamic> json) {
    return LoginModuleResult(
      success: json['success'] as bool? ?? false,
      token: json['token'] as String?,
      user: json['user'] != null ? UserDto.fromJson(json['user']) : null,
      error: json['error'] as String?,
      cachedKey: json['cachedKey'] as String?,
      selectedManagementAccount: json['selectedManagementAccount'] != null
          ? ManagementAccounts.fromJson(json)
          : null,
      managementAccount: (json['managementAccount'] as List)
          .map((e) => ManagementAccounts.fromJson(e))
          .toList(),
      resultType: LoginResultType
          .values[json['resultType'] as int? ?? LoginResultType.error.index],
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'])
          : DateTime.now(),
    );
  }

  LoginModuleResult copyWith({
    bool? success,
    String? token,
    UserDto? user,
    String? error,
    DateTime? timestamp,
    ManagementAccounts? selectedAccount,
    List<ManagementAccounts>? managementAccounts,
    String? cachedKey,
    LoginResultType? resultType,
  }) {
    return LoginModuleResult(
      success: success ?? this.success,
      token: token ?? this.token,
      user: user ?? this.user,
      error: error ?? this.error,
      selectedManagementAccount: selectedAccount ??
          this.selectedManagementAccount,
      managementAccount: managementAccounts ?? this.managementAccount,
      cachedKey: cachedKey ?? this.cachedKey,
      resultType: resultType ?? this.resultType,
    );
  }
}
