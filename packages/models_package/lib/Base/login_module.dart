import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:navigation_builder/navigation_builder.dart';

import '../Data/Auth/Login/dto.dart';
import '../Data/Auth/User/dto.dart';
import 'enums.dart';
import 'language.dart';

part 'login_module.g.dart';

@JsonSerializable()
class LoginModuleResult extends Equatable {
  final bool success;
  final String? token;
  final UserDto? user;
  String? error;
  @JsonKey(toJson: _toJson, fromJson: _fromJson)
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
    required this.language,
    this.cachedKey,
    required this.managementAccount,
    required this.timestamp,
    required this.success,
    required this.error,
    required this.selectedManagementAccount,
  }) : resultType = LoginResultType.success;

  LoginModuleResult.failure(String message)
    : success = false,
      user = null,
      token = null,
      networkMode = 0,
      timestamp = DateTime.now(),
      cachedKey = null,
      managementAccount = [],
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

  static int _toJson(DateTime value) => value.millisecondsSinceEpoch;

  static DateTime _fromJson(dynamic value) {
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    } else if (value is String) {
      return DateTime.parse(value);
    }
    return DateTime.now();
  }

  factory LoginModuleResult.fromJson(Map<String, dynamic> json) =>
      _$LoginModuleResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModuleResultToJson(this);

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

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
