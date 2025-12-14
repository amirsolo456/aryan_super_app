// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map json) =>
    LoginRequest(
        userName: json['UserName'] as String?,
        password: json['Password'] as String?,
        deviceToken: json['DeviceToken'] as String?,
        grantType: json['GrantType'] as String?,
        isRefreshToken: json['IsRefreshToken'] as bool?,
        langId: (json['LangId'] as num?)?.toInt(),
        managementAccountId: (json['ManagementAccountId'] as num?)?.toInt(),
        deviceType: (json['DeviceType'] as num?)?.toInt(),
        refreshToken: json['RefreshToken'] as String?,
      )
      ..url = json['Url'] as String
      ..id = (json['Id'] as num?)?.toInt()
      ..repoViewId = (json['RepoViewId'] as num?)?.toInt()
      ..ids = (json['Ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList()
      ..fullSearchPhrase = json['FullSearchPhrase'] as String?
      ..pagingInfo = PagingInfo.fromJson(
        Map<String, dynamic>.from(json['PagingInfo'] as Map),
      )
      ..orderInfo = (json['OrderInfo'] as List<dynamic>)
          .map((e) => OrderInfo.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList()
      ..filters = Filters.fromJson(
        Map<String, dynamic>.from(json['Filters'] as Map),
      )
      ..showTags = json['ShowTags'] as bool?
      ..showMode = (json['ShowMode'] as num?)?.toInt()
      ..showBookmarked = json['ShowBookmarked'] as bool?
      ..defaults = Defaults.fromJson(
        Map<String, dynamic>.from(json['Defaults'] as Map),
      );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'Url': instance.url,
      'Id': instance.id,
      'RepoViewId': instance.repoViewId,
      'Ids': instance.ids,
      'FullSearchPhrase': instance.fullSearchPhrase,
      'PagingInfo': instance.pagingInfo.toJson(),
      'OrderInfo': instance.orderInfo.map((e) => e.toJson()).toList(),
      'Filters': instance.filters.toJson(),
      'ShowTags': instance.showTags,
      'ShowMode': instance.showMode,
      'ShowBookmarked': instance.showBookmarked,
      'Defaults': instance.defaults.toJson(),
      'UserName': instance.userName,
      'Password': instance.password,
      'DeviceToken': instance.deviceToken,
      'GrantType': instance.grantType,
      'IsRefreshToken': instance.isRefreshToken,
      'LangId': instance.langId,
      'ManagementAccountId': instance.managementAccountId,
      'DeviceType': instance.deviceType,
      'RefreshToken': instance.refreshToken,
    };

LoginResponse _$LoginResponseFromJson(Map json) =>
    LoginResponse(
        isExpire: json['IsExpire'] as bool?,
        status: (json['Status'] as num?)?.toInt(),
        accessToken: json['access_token'] as String?,
        tokenType: json['token_type'] as String?,
        refreshToken: json['refresh_token'] as String?,
        userSession: json['UserSession'] == null
            ? null
            : UserSession.fromJson(
                Map<String, dynamic>.from(json['UserSession'] as Map),
              ),
        isMMA: json['IsMMA'] as bool?,
        cacheKey: json['CacheKey'] as String?,
        managementAccounts: (json['ManagementAccounts'] as List<dynamic>?)
            ?.map(
              (e) => ManagementAccounts.fromJson(
                Map<String, dynamic>.from(e as Map),
              ),
            )
            .toList(),
      )
      ..result = json['Result'] as String?
      ..error = json['Error'] as String?
      ..data = (json['Data'] as List<dynamic>?)
          ?.map(
            (e) => ResponseData.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList()
      ..additionalInfo = json['AdditionalInfo'] as String?
      ..totalCount = (json['TotalCount'] as num?)?.toInt()
      ..key = (json['Key'] as num?)?.toInt();

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'Result': instance.result,
      'Data': instance.data?.map((e) => e.toJson()).toList(),
      'AdditionalInfo': instance.additionalInfo,
      'TotalCount': instance.totalCount,
      'Key': instance.key,
      'IsExpire': instance.isExpire,
      'Status': instance.status,
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'refresh_token': instance.refreshToken,
      'UserSession': instance.userSession?.toJson(),
      'IsMMA': instance.isMMA,
      'CacheKey': instance.cacheKey,
      'ManagementAccounts': instance.managementAccounts
          ?.map((e) => e.toJson())
          .toList(),
    };

LoginResponseNextStep _$LoginResponseNextStepFromJson(Map json) =>
    LoginResponseNextStep(
        result: json['Result'] as String? ?? "Failed",
        accessToken: json['AccessToken'] as String?,
        expiresIn: json['ExpiresIn'] as bool?,
        tokenType: json['TokenType'] as String?,
        refreshToken: json['RefreshToken'] as String?,
        scope: json['Scope'] as String?,
        isMFA: json['IsMFA'] as bool?,
        isMMA: json['IsMMA'] as bool?,
        managementAccounts: (json['ManagementAccounts'] as List<dynamic>?)
            ?.map(
              (e) => ManagementAccounts.fromJson(
                Map<String, dynamic>.from(e as Map),
              ),
            )
            .toList(),
        userSession: json['UserSession'] == null
            ? null
            : UserSession.fromJson(
                Map<String, dynamic>.from(json['UserSession'] as Map),
              ),
      )
      ..status = (json['Status'] as num?)?.toInt()
      ..error = json['Error'] as String?
      ..data = (json['Data'] as List<dynamic>?)
          ?.map(
            (e) => ResponseData.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList()
      ..additionalInfo = json['AdditionalInfo'] as String?
      ..totalCount = (json['TotalCount'] as num?)?.toInt()
      ..key = (json['Key'] as num?)?.toInt();

Map<String, dynamic> _$LoginResponseNextStepToJson(
  LoginResponseNextStep instance,
) => <String, dynamic>{
  'Result': instance.result,
  'Status': instance.status,
  'Data': instance.data?.map((e) => e.toJson()).toList(),
  'AdditionalInfo': instance.additionalInfo,
  'TotalCount': instance.totalCount,
  'Key': instance.key,
  'AccessToken': instance.accessToken,
  'ExpiresIn': instance.expiresIn,
  'TokenType': instance.tokenType,
  'RefreshToken': instance.refreshToken,
  'Scope': instance.scope,
  'IsMFA': instance.isMFA,
  'IsMMA': instance.isMMA,
  'ManagementAccounts': instance.managementAccounts
      ?.map((e) => e.toJson())
      .toList(),
  'UserSession': instance.userSession?.toJson(),
};

UserSession _$UserSessionFromJson(Map json) => UserSession(
  userInfo: json['UserInfo'] == null
      ? null
      : UserInfo.fromJson(Map<String, dynamic>.from(json['UserInfo'] as Map)),
  yearInfo: json['YearInfo'] == null
      ? null
      : YearInfo.fromJson(Map<String, dynamic>.from(json['YearInfo'] as Map)),
  roleDto: (json['RoleDto'] as List<dynamic>?)
      ?.map((e) => RoleDto.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  langId: (json['LangId'] as num?)?.toInt(),
);

Map<String, dynamic> _$UserSessionToJson(UserSession instance) =>
    <String, dynamic>{
      'UserInfo': instance.userInfo?.toJson(),
      'YearInfo': instance.yearInfo?.toJson(),
      'RoleDto': instance.roleDto?.map((e) => e.toJson()).toList(),
      'LangId': instance.langId,
    };

YearInfo _$YearInfoFromJson(Map json) => YearInfo(size: json['Size']);

Map<String, dynamic> _$YearInfoToJson(YearInfo instance) => <String, dynamic>{
  'Size': instance.size,
};

UserInfo _$UserInfoFromJson(Map json) => UserInfo(
  userName: json['UserName'] as String?,
  isAdmin: json['IsAdmin'] as bool?,
  userId: (json['UserId'] as num?)?.toInt(),
  userType: (json['UserType'] as num?)?.toInt(),
  userPic: json['UserPic'] as String?,
  packageId: (json['PackageId'] as num?)?.toInt(),
  packageExpireDate: json['PackageExpireDate'] as String?,
);

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
  'UserName': instance.userName,
  'IsAdmin': instance.isAdmin,
  'UserId': instance.userId,
  'UserType': instance.userType,
  'UserPic': instance.userPic,
  'PackageId': instance.packageId,
  'PackageExpireDate': instance.packageExpireDate,
};

RoleDto _$RoleDtoFromJson(Map json) => RoleDto(
  roleId: (json['RoleId'] as num?)?.toInt(),
  roleName: json['RoleName'] as String?,
  places: (json['Places'] as List<dynamic>?)
      ?.map((e) => Places.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  isSupporter: json['IsSupporter'] as bool?,
);

Map<String, dynamic> _$RoleDtoToJson(RoleDto instance) => <String, dynamic>{
  'RoleId': instance.roleId,
  'IsSupporter': instance.isSupporter,
  'RoleName': instance.roleName,
  'Places': instance.places?.map((e) => e.toJson()).toList(),
};

Places _$PlacesFromJson(Map json) => Places(
  placeId: (json['PlaceId'] as num?)?.toInt(),
  placeShortCut: json['PlaceShortCut'] as String?,
  placeDesc: json['PlaceDesc'] as String?,
);

Map<String, dynamic> _$PlacesToJson(Places instance) => <String, dynamic>{
  'PlaceId': instance.placeId,
  'PlaceShortCut': instance.placeShortCut,
  'PlaceDesc': instance.placeDesc,
};

ManagementAccounts _$ManagementAccountsFromJson(Map json) => ManagementAccounts(
  managementAccountId: (json['ManagementAccountId'] as num?)?.toInt(),
  managementAccountDesc: json['ManagementAccountDesc'] as String?,
  credit: (json['Credit'] as num?)?.toInt(),
  expireDate: json['ExpireDate'] as String?,
  packageId: (json['PackageId'] as num?)?.toInt(),
  inActive: json['InActive'] as bool?,
);

Map<String, dynamic> _$ManagementAccountsToJson(ManagementAccounts instance) =>
    <String, dynamic>{
      'ManagementAccountId': instance.managementAccountId,
      'ManagementAccountDesc': instance.managementAccountDesc,
      'Credit': instance.credit,
      'ExpireDate': instance.expireDate,
      'PackageId': instance.packageId,
      'InActive': instance.inActive,
    };

ResponseData _$ResponseDataFromJson(Map json) =>
    ResponseData(isSelected: json['IsSelected'] as bool?);

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{'IsSelected': instance.isSelected};
