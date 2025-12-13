import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../Base/base_request.dart';
import '../../../Base/base_response.dart';

part 'dto.g.dart';

@JsonSerializable()
class LoginRequest extends BaseRequest {
  String? userName;
  String? password;
  String? deviceToken;
  String? grantType;
  bool? isRefreshToken;
  int? langId;
  int? managementAccountId;
  int? deviceType;
  String? refreshToken;

  LoginRequest({
    this.userName,
    this.password,
    this.deviceToken,
    this.grantType,
    this.isRefreshToken,
    this.langId,
    this.managementAccountId,
    this.deviceType,
    this.refreshToken,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> fromJsonD) =>
      _$LoginRequestFromJson(fromJsonD);

  @override
  Map<String, dynamic> toJson() {
    return _$LoginRequestToJson(this);
  }
}

@JsonSerializable()
class LoginResponse extends BaseResponse<ResponseData> {
  final bool? isExpire;
  final int? status;
  @JsonKey(name: "access_token", includeToJson: true, includeFromJson: true)
  final String? accessToken;
  @JsonKey(name: "token_type")
  final String? tokenType;
  @JsonKey(name: "refresh_token")
  final String? refreshToken;
  final UserSession? userSession;
  final bool? isMMA;
  String? cacheKey;
  final List<ManagementAccounts>? managementAccounts;

  LoginResponse({
    this.isExpire,
    this.status,
    this.accessToken,
    this.tokenType,
    this.refreshToken,
    this.userSession,
    this.isMMA,
    this.cacheKey,
    this.managementAccounts,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(json) {
    return _$LoginResponseToJson(this);
  }
}

@JsonSerializable()
class LoginResponseNextStep extends BaseResponse<ResponseData> {
  final String? accessToken;
  final bool? expiresIn;
  final String? tokenType;
  final String? refreshToken;
  final String? scope;
  final bool? isMFA;
  final bool? isMMA;
  final List<ManagementAccounts>? managementAccounts;
  final UserSession? userSession;

  LoginResponseNextStep({
    super.result,
    this.accessToken,
    this.expiresIn,
    this.tokenType,
    this.refreshToken,
    this.scope,
    this.isMFA,
    this.isMMA,
    this.managementAccounts,
    this.userSession,
  });

  factory LoginResponseNextStep.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseNextStepFromJson(json);

  Map<String, dynamic> toJson(json) {
    return _$LoginResponseNextStepToJson(this);
  }
}

@JsonSerializable()
class UserSession {
  final UserInfo? userInfo;
  final YearInfo? yearInfo;
  final List<RoleDto>? roleDto;
  final int? langId;

  UserSession({this.userInfo, this.yearInfo, this.roleDto, this.langId});

  factory UserSession.fromJson(Map<String, dynamic> json) =>
      _$UserSessionFromJson(json);

  Map<String, dynamic> toJson() {
    return _$UserSessionToJson(this);
  }
}

@JsonSerializable()
class YearInfo {
  final Object? size;

  YearInfo({this.size});
  factory YearInfo.fromJson(Map<String, dynamic> json) =>
      _$YearInfoFromJson(json);

  Map<String, dynamic> toJson() => _$YearInfoToJson(this);
}

@JsonSerializable()
class UserInfo {
  String? userName;
  bool? isAdmin;
  int? userId;
  int? userType;
  String? userPic;
  int? packageId;
  String? packageExpireDate;

  UserInfo({
    this.userName,
    this.isAdmin,
    this.userId,
    this.userType,
    this.userPic,
    this.packageId,
    this.packageExpireDate,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class RoleDto {
  final int? roleId;
  final bool? isSupporter;
  final String? roleName;
  final List<Places>? places;

  RoleDto({this.roleId, this.roleName, this.places, this.isSupporter});

  factory RoleDto.fromJson(Map<String, dynamic> json) =>
      _$RoleDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RoleDtoToJson(this);
}

@JsonSerializable()
class Places {
  final int? placeId;
  final String? placeShortCut;
  final String? placeDesc;

  Places({this.placeId, this.placeShortCut, this.placeDesc});

  factory Places.fromJson(Map<String, dynamic> json) => _$PlacesFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesToJson(this);
}

@JsonSerializable()
class ManagementAccounts extends Equatable {
  final int? managementAccountId;
  final String? managementAccountDesc;
  final int? credit;
  final String? expireDate;
  final int? packageId;
  final bool? inActive;

  ManagementAccounts({
    this.managementAccountId,
    this.managementAccountDesc,
    this.credit,
    this.expireDate,
    this.packageId,
    this.inActive,
  });

  factory ManagementAccounts.fromJson(Map<String, dynamic> json) =>
      _$ManagementAccountsFromJson(json);

  Map<String, dynamic> toJson() => _$ManagementAccountsToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class ResponseData {
  bool? isSelected;

  ResponseData({this.isSelected});

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}
