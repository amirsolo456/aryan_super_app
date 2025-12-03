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
  bool? isExpire;
  int? status;
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  UserSession? userSession;
  bool? isMMA;
  String? cacheKey;
  List<ManagementAccounts>? managementAccounts;

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

  LoginResponse.fromJson(Map<String, dynamic> json,
      ResponseData Function(Map<String, dynamic>?) fromJsonT,) {
    result = json['Result'];
    data = null;
    totalCount = 0;
    isExpire = json['IsExpire'];
    status = json['status'];
    accessToken = json['access_token'] as String?;
    tokenType = json['token_type'] as String?;
    refreshToken = json['refresh_token'] as String?;
    userSession = json['UserSession'] != null
        ? UserSession.fromJson(json['UserSession'])
        : null;
    isMMA = json['IsMMA'] as bool?;
    managementAccounts = json['ManagementAccounts'] != null
        ? (json['ManagementAccounts'] as List)
        .map((e) => ManagementAccounts.fromJson(e))
        .toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'IsExpire': isExpire,
      'Result': result,
      'status': status,
      'access_token': accessToken,
      'token_type': tokenType,
      'refresh_token': refreshToken,
      'UserSession': userSession?.toJson(),
      'IsMMA': isMMA,
      'ManagementAccounts': managementAccounts?.map((e) => e.toJson()).toList(),
    };
  }
}

class LoginResponseNextStep extends BaseResponse<ResponseData> {
  String? accessToken;
  bool? expiresIn;
  String? tokenType;
  String? refreshToken;
  String? scope;
  bool? isMFA;
  bool? isMMA;
  List<ManagementAccounts>? managementAccounts;
  UserSession? userSession;


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

  factory LoginResponseNextStep.fromJson(Map<String, dynamic> json,
      ResponseData Function(Map<String, dynamic>?) fromJsonT,) {
    return LoginResponseNextStep(
      accessToken: json['access_token'] as String?,
      result: json['Result'] as String?,
      expiresIn: json['IsExpire'] as bool?,
      tokenType: json['token_type'] as String?,
      refreshToken: json['refresh_token'] as String?,
      scope: json['Scope'] as String?,
      isMFA: json['IsMFA'] as bool?,
      isMMA: json['IsMMA'] as bool?,
      managementAccounts: json['ManagementAccounts'] != null
          ? (json['ManagementAccounts'] as List)
          .map((e) => ManagementAccounts.fromJson(e))
          .toList() : null,
      userSession: json['UserSession'] != null
          ? UserSession.fromJson(json['UserSession'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'IsExpire': expiresIn,
      'token_Type': tokenType,
      'refresh_Token': refreshToken,
      'Scope': scope,
      'IsMFA': isMFA,
      'IsMMA': isMMA,
      'ManagementAccounts': managementAccounts?.map((e) => e.toJson()).toList(),
      'UserSession': userSession?.toJson(),
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
      userInfo: json['UserInfo'] != null
          ? UserInfo.fromJson(json['UserInfo'])
          : null,
      yearInfo: json['YearInfo'],
      roleDto: json['RoleDto'] != null
          ? (json['RoleDto'] as List).map((e) => RoleDto.fromJson(e)).toList()
          : null,
      langId: json['LangId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserInfo': userInfo?.toJson(),
      'YearInfo': yearInfo,
      'RoleDto': roleDto?.map((e) => e.toJson()).toList(),
      'LangId': langId,
    };
  }
}

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

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userName: json['UserName'] as String?,
      isAdmin: json['IsAdmin'] as bool?,
      userId: json['UserId'] as int?,
      userType: json['UserType'] as int?,
      userPic: json['UserPic'] as String?,
      packageId: json['PackageId'] as int?,
      packageExpireDate: json['PackageExpireDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'IsAdmin': isAdmin,
      'UserId': userId,
      'UserType': userType,
      'UserPic': userPic,
      'PackageId': packageId,
      'PackageExpireDate': packageExpireDate,
    };
  }
}

class RoleDto {
  int? roleId;
  bool? isSupporter;
  String? roleName;
  List<Places>? places;

  RoleDto({this.roleId, this.roleName, this.places,this.isSupporter});

  factory RoleDto.fromJson(Map<String, dynamic> json) {
    return RoleDto(
      roleId: json['RoleId'] as int?,
      isSupporter: json['IsSupporter'] as bool?,
      roleName: json['RoleName'] as String?,
      places: json['Places'] != null
          ? (json['Places'] as List).map((e) => Places.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'RoleId': roleId,
      'RoleName': roleName,
      'IsSupporter': isSupporter,
      'Places': places?.map((e) => e.toJson()).toList(),
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
      placeId: json['PlaceId'] as int?,
      placeShortCut: json['PlaceShortCut'] as String?,
      placeDesc: json['PlaceDesc'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PlaceId': placeId,
      'PlaceShortCut': placeShortCut,
      'PlaceDesc': placeDesc,
    };
  }
}

class ManagementAccounts {
  int? managementAccountId;
  String? managementAccountDesc;
  int? credit;
  String? expireDate;
  int? packageId;
  bool? inActive;

  ManagementAccounts({
    this.managementAccountId,
    this.managementAccountDesc,
    this.credit,
    this.expireDate,
    this.packageId,
    this.inActive,
  });

  factory ManagementAccounts.fromJson(Map<String, dynamic> json) {
    return ManagementAccounts(
      managementAccountId: json['ManagementAccountId'] as int?,
      managementAccountDesc: json['ManagementAccountDesc'] as String?,
      credit: json['Credit'] as int?,
      expireDate: json['ExpireDate'] as String?,
      packageId: json['PackageId'] as int?,
      inActive: json['InActive'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ManagementAccountId': managementAccountId,
      'ManagementAccountDesc': managementAccountDesc,
      'Credit': credit,
      'ExpireDate': expireDate,
      'PackageId': packageId,
      'InActive': inActive,
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
