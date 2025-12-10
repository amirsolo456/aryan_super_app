import '../Data/Auth/Login/dto.dart';
import '../Data/Auth/User/dto.dart';
import 'enums.dart';
import 'language.dart';

class LoginModuleResult {
  final bool success;
  final String? token;
  final UserDto? user;
  String? error;
  final DateTime timestamp;
  final LoginResultType resultType;
  final String? cachedKey;
  final Language? language;
  final int networkMode;
  final ManagementAccounts? selectedManagementAccount;
  final List<ManagementAccounts>? managementAccount;

  LoginModuleResult.success({
    required this.user,
    required this.token,
    required this.networkMode,
    this.language,
    required String cachedKey,
    required List<ManagementAccounts>? managementAccount,
    required ManagementAccounts selectedManagementAccount,
  }) : success = true,
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
      networkMode = 0,
      timestamp = DateTime.now(),
      cachedKey = null,
      managementAccount = null,
      selectedManagementAccount = null,
      language = null,
      resultType = LoginResultType.error,
      error = message;

  LoginModuleResult({
    required this.success,
    this.token,
    this.user,
    this.networkMode = 0,
    this.error,
    this.cachedKey,
    this.managementAccount,
    this.selectedManagementAccount,
    this.language,
    required this.resultType,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() => {
    'Success': success,
    'Token': token,
    'User': user?.toJson(),
    'Error': error,
    'NetworkMode': networkMode,
    'CachedKey': cachedKey,
    'ManagementAccount': managementAccount,
    'SelectedManagementAccount': selectedManagementAccount,
    'ResultType': resultType.index,
    'Language': language,
    'Timestamp': timestamp.toIso8601String(),
  };

  factory LoginModuleResult.fromJson(Map<String, dynamic> json) {
    return LoginModuleResult(
      success: json['Success'] as bool? ?? false,
      networkMode: json['NetworkMode'] as int ?? 0,
      token: json['Token'] as String?,
      user: json['User'] != null ? UserDto.fromJson(json['User']) : null,
      error: json['Error'] as String?,
      cachedKey: json['CachedKey'] as String?,
      language: json['Language'] as Language?,
      selectedManagementAccount: json['SelectedManagementAccount'] != null
          ? ManagementAccounts.fromJson(json)
          : null,
      managementAccount: (json['ManagementAccount'] as List)
          .map((e) => ManagementAccounts.fromJson(e))
          .toList(),
      resultType: LoginResultType
          .values[json['ResultType'] as int? ?? LoginResultType.error.index],
      timestamp: json['Timestamp'] != null
          ? DateTime.parse(json['Timestamp'])
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
      selectedManagementAccount:
          selectedAccount ?? this.selectedManagementAccount,
      managementAccount: managementAccounts ?? this.managementAccount,
      cachedKey: cachedKey ?? this.cachedKey,
      resultType: resultType ?? this.resultType,
    );
  }
}
