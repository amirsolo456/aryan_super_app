import '../../../Base/base_request.dart';
import '../../../Base/base_response.dart';

/// -------------------- Request --------------------
class Request extends BaseRequest {
  String? userName;
  String? deviceToken;

  Request({this.userName, this.deviceToken});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      userName: json['userName'] as String?,
      deviceToken: json['deviceToken'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'deviceToken': deviceToken,
    };
  }
}

/// -------------------- Response --------------------
class Response extends BaseResponse<ResponseData> {
  Response({List<ResponseData>? data}) {
    this.data = data ?? [];
  }

  factory Response.fromJson(Map<String, dynamic> json) {
    var list = <ResponseData>[];
    if (json['data'] != null) {
      list = (json['data'] as List)
          .map((x) => ResponseData.fromJson(x))
          .toList();
    }
    return Response(data: list);
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((x) => x.toJson()).toList() ?? [],
    };
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
      exist: json['exist'] as bool? ?? false,
      inactive: json['inactive'] as bool? ?? false,
      invited: json['invited'] as bool? ?? false,
      isSelected: json['isSelected'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exist': exist,
      'inactive': inactive,
      'invited': invited,
      'isSelected': isSelected,
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
