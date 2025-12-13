// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginModuleResult _$LoginModuleResultFromJson(Map json) => LoginModuleResult(
  success: json['Success'] as bool,
  token: json['Token'] as String?,
  user: json['User'] == null
      ? null
      : UserDto.fromJson(Map<String, dynamic>.from(json['User'] as Map)),
  networkMode: (json['NetworkMode'] as num?)?.toInt() ?? 0,
  error: json['Error'] as String?,
  cachedKey: json['CachedKey'] as String?,
  managementAccount: (json['ManagementAccount'] as List<dynamic>?)
      ?.map(
        (e) => ManagementAccounts.fromJson(Map<String, dynamic>.from(e as Map)),
      )
      .toList(),
  selectedManagementAccount: json['SelectedManagementAccount'] == null
      ? null
      : ManagementAccounts.fromJson(
          Map<String, dynamic>.from(json['SelectedManagementAccount'] as Map),
        ),
  language: json['Language'] == null
      ? null
      : Language.fromJson(Map<String, dynamic>.from(json['Language'] as Map)),
  resultType: $enumDecode(_$LoginResultTypeEnumMap, json['ResultType']),
  timestamp: LoginModuleResult._fromJson(json['Timestamp']),
);

Map<String, dynamic> _$LoginModuleResultToJson(LoginModuleResult instance) =>
    <String, dynamic>{
      'Success': instance.success,
      'Token': instance.token,
      'User': instance.user?.toJson(),
      'Error': instance.error,
      'Timestamp': LoginModuleResult._toJson(instance.timestamp),
      'ResultType': _$LoginResultTypeEnumMap[instance.resultType]!,
      'CachedKey': instance.cachedKey,
      'Language': instance.language?.toJson(),
      'NetworkMode': instance.networkMode,
      'SelectedManagementAccount': instance.selectedManagementAccount?.toJson(),
      'ManagementAccount': instance.managementAccount
          ?.map((e) => e.toJson())
          .toList(),
    };

const _$LoginResultTypeEnumMap = {
  LoginResultType.success: 'success',
  LoginResultType.error: 'error',
  LoginResultType.cancelled: 'cancelled',
  LoginResultType.networkError: 'networkError',
  LoginResultType.validationError: 'validationError',
  LoginResultType.managementAccountPick: 'managementAccountPick',
};
