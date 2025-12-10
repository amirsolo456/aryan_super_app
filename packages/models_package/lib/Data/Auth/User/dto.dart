import '../../../Base/base_request.dart';
import '../../../Base/base_response.dart';

/// -------------------- Request --------------------
class Request extends BaseRequest {
  String? userName;
  String? deviceToken;

  Request({this.userName, this.deviceToken});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      userName: json['UserName'] as String?,
      deviceToken: json['DeviceToken'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'UserName': userName, 'DeviceToken': deviceToken};
  }
}

/// -------------------- Response --------------------
class Response extends BaseResponse<ResponseData> {
  Response({List<ResponseData>? data}) {
    this.data = data ?? [];
  }

  Response.fromJson(
    Map<String, dynamic> json,
    ResponseData Function(Map<String, dynamic>) fromJsonT,
  ) {
    result = json['Result'] ?? "";
    error = json['Error']   ?? "";

    if (json['Data'] is List) {

      totalCount = json['TotalCount'];
      data = (json['Data'] as List)
          .map((e) => fromJsonT(e as Map<String, dynamic>))
          .toList();
    } else if (json['Data'] is Map) {
      data = [fromJsonT(json['Data'])];
    } else {
      data = [];
    }


  }

  Map<String, dynamic> toJson() {
    return {'Data': data?.map((x) => x.toJson()).toList() ?? []};
  }
}

/// -------------------- ResponseData --------------------
class ResponseData {
  bool exist;
  bool inactive;
  bool invited;
  bool isSelected;

  ResponseData({
    this.exist = false,
    this.inactive = false,
    this.invited = false,
    this.isSelected = false,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      exist: json['Exist'] as bool? ?? false,
      inactive: json['Inactive'] as bool? ?? false,
      invited: json['Invited'] as bool? ?? false,
      isSelected: json['IsSelected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Exist': exist,
      'Inactive': inactive,
      'Invited': invited,
      'IsSelected': isSelected,
    };
  }
}

class UserDto {
  int? id;
  String? userName;
  String? password;
  String? firstName;
  String? lastName;
  String? fullName;
  String? imageUrl;
  String? token;
  String? type;
  String? refreshToken;

  UserDto({
    this.id,
    this.userName,
    this.password,
    this.firstName,
    this.lastName,
    this.fullName,
    this.imageUrl,
    required this.token,
    this.type,
    required this.refreshToken,
  });

  // متد copyWith
  UserDto copyWith({
    int? id,
    String? userName,
    String? password,
    String? firstName,
    String? lastName,
    String? fullName,
    String? imageUrl,
    String? token,
    String? type,
    String? refreshToken,
  }) {
    return UserDto(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      imageUrl: imageUrl ?? this.imageUrl,
      token: token ?? this.token,
      type: type ?? this.type,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int?,
      userName: json['userName'] as String?,
      password: json['password'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      fullName: json['fullName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      token: json['token'] as String?,
      type: json['type'] as String?,
      refreshToken: json['refreshtoken'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'imageUrl': imageUrl,
      'token': token,
      'type': type,
      'refreshtoken': refreshToken,
    };
  }
}
