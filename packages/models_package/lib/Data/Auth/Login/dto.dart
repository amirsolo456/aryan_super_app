

import '../../../Base/base_request.dart';
import '../../../Base/base_response.dart';

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

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      deviceToken: json['deviceToken'] as String?,
      grantType: json['grantType'] as String?,
      isRefreshToken: json['isRefreshToken'] as bool?,
      langId: json['langId'] as int?,
      managementAccountId: json['managementAccountId'] as int?,
      deviceType: json['deviceType'] as int?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'password': password,
      'deviceToken': deviceToken,
      'grantType': grantType,
      'isRefreshToken': isRefreshToken,
      'langId': langId,
      'managementAccountId': managementAccountId,
      'deviceType': deviceType,
      'refreshToken': refreshToken,
    };
  }
}

class LoginResponse extends BaseResponse<ResponseData> {
  String? accessToken;
  int? expiresIn;
  String? tokenType;
  String? refreshToken;
  String? scope;
  bool? isMFA;
  bool? isMMA;
  List<ManagementAccounts>? managementAccounts;
  String? cacheKey;

  LoginResponse({
    this.accessToken,
    this.expiresIn,
    this.tokenType,
    this.refreshToken,
    this.scope,
    this.isMFA,
    this.isMMA,
    this.managementAccounts,
    this.cacheKey,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['accessToken'] as String?,
      expiresIn: json['expiresIn'] as int?,
      tokenType: json['tokenType'] as String?,
      refreshToken: json['refreshToken'] as String?,
      scope: json['scope'] as String?,
      isMFA: json['isMFA'] as bool?,
      isMMA: json['isMMA'] as bool?,
      managementAccounts: json['managementAccounts'] != null
          ? (json['managementAccounts'] as List)
                .map((e) => ManagementAccounts.fromJson(e))
                .toList()
          : null,
      cacheKey: json['cacheKey'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'expiresIn': expiresIn,
      'tokenType': tokenType,
      'refreshToken': refreshToken,
      'scope': scope,
      'isMFA': isMFA,
      'isMMA': isMMA,
      'managementAccounts': managementAccounts?.map((e) => e.toJson()).toList(),
      'cacheKey': cacheKey,
    };
  }
}

class LoginResponseNextStep extends BaseResponse<ResponseData> {
  String? accessToken;
  int? expiresIn;
  String? tokenType;
  String? refreshToken;
  String? scope;
  bool? isMFA;
  bool? isMMA;
  List<ManagementAccounts>? managementAccounts;
  UserSession? userSession;

  LoginResponseNextStep({
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

  factory LoginResponseNextStep.fromJson(Map<String, dynamic> json) {
    return LoginResponseNextStep(
      accessToken: json['accessToken'] as String?,
      expiresIn: json['expiresIn'] as int?,
      tokenType: json['tokenType'] as String?,
      refreshToken: json['refreshToken'] as String?,
      scope: json['scope'] as String?,
      isMFA: json['isMFA'] as bool?,
      isMMA: json['isMMA'] as bool?,
      managementAccounts: json['managementAccounts'] != null
          ? (json['managementAccounts'] as List)
                .map((e) => ManagementAccounts.fromJson(e))
                .toList()
          : null,
      userSession: json['userSession'] != null
          ? UserSession.fromJson(json['userSession'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'expiresIn': expiresIn,
      'tokenType': tokenType,
      'refreshToken': refreshToken,
      'scope': scope,
      'isMFA': isMFA,
      'isMMA': isMMA,
      'managementAccounts': managementAccounts?.map((e) => e.toJson()).toList(),
      'userSession': userSession?.toJson(),
    };
  }
}

class UserSession {
  UserInfo? userInfo;
  dynamic yearInfo;
  List<RoleDto>? roleDto;
  int? langId;

  UserSession({this.userInfo, this.yearInfo, this.roleDto, this.langId});

  factory UserSession.fromJson(Map<String, dynamic> json) {
    return UserSession(
      userInfo: json['userInfo'] != null
          ? UserInfo.fromJson(json['userInfo'])
          : null,
      yearInfo: json['yearInfo'],
      roleDto: json['roleDto'] != null
          ? (json['roleDto'] as List).map((e) => RoleDto.fromJson(e)).toList()
          : null,
      langId: json['langId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userInfo': userInfo?.toJson(),
      'yearInfo': yearInfo,
      'roleDto': roleDto?.map((e) => e.toJson()).toList(),
      'langId': langId,
    };
  }
}

class UserInfo {
  String? userName;
  int? userId;
  int? userType;
  String? userPic;
  int? packageId;
  String? packageExpireDate;

  UserInfo({
    this.userName,
    this.userId,
    this.userType,
    this.userPic,
    this.packageId,
    this.packageExpireDate,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userName: json['userName'] as String?,
      userId: json['userId'] as int?,
      userType: json['userType'] as int?,
      userPic: json['userPic'] as String?,
      packageId: json['packageId'] as int?,
      packageExpireDate: json['packageExpireDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userId': userId,
      'userType': userType,
      'userPic': userPic,
      'packageId': packageId,
      'packageExpireDate': packageExpireDate,
    };
  }
}

class RoleDto {
  int? roleId;
  String? roleName;
  List<Places>? places;

  RoleDto({this.roleId, this.roleName, this.places});

  factory RoleDto.fromJson(Map<String, dynamic> json) {
    return RoleDto(
      roleId: json['roleId'] as int?,
      roleName: json['roleName'] as String?,
      places: json['places'] != null
          ? (json['places'] as List).map((e) => Places.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleId': roleId,
      'roleName': roleName,
      'places': places?.map((e) => e.toJson()).toList(),
    };
  }
}

class Places {
  int? placeId;
  String? placeShortCut;
  String? placeDesc;

  Places({this.placeId, this.placeShortCut, this.placeDesc});

  factory Places.fromJson(Map<String, dynamic> json) {
    return Places(
      placeId: json['placeId'] as int?,
      placeShortCut: json['placeShortCut'] as String?,
      placeDesc: json['placeDesc'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'placeId': placeId,
      'placeShortCut': placeShortCut,
      'placeDesc': placeDesc,
    };
  }
}

class ManagementAccounts {
  int? managementAccountId;
  String? managementAccountDesc;
  bool? inActive;

  ManagementAccounts({
    this.managementAccountId,
    this.managementAccountDesc,
    this.inActive,
  });

  factory ManagementAccounts.fromJson(Map<String, dynamic> json) {
    return ManagementAccounts(
      managementAccountId: json['managementAccountId'] as int?,
      managementAccountDesc: json['managementAccountDesc'] as String?,
      inActive: json['inActive'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'managementAccountId': managementAccountId,
      'managementAccountDesc': managementAccountDesc,
      'inActive': inActive,
    };
  }
}

class ResponseData {
  bool? isSelected;

  ResponseData({this.isSelected});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(isSelected: json['isSelected'] as bool? ?? false);
  }

  Map<String, dynamic> toJson() {
    return {'isSelected': isSelected};
  }
}
