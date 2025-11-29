import '../../../Base/base_response.dart';

class Request {
  final String userName;
  final int otp;
  final String? usertDevice;

  Request({required this.userName, required this.otp, this.usertDevice});

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      userName: json['userName'] as String,
      otp: json['otp'] as int,
      usertDevice: json['usertDevice'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userName': userName, 'otp': otp, 'usertDevice': usertDevice};
  }
}

class Response extends BaseResponse<ResponseData> {
  ValidationData? validationData;
  bool? isPendingOperated;
  int? lastKey;

  Response({this.validationData, this.isPendingOperated, this.lastKey});

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(
      validationData: json['validationData'] != null
          ? ValidationData.fromJson(json['validationData'])
          : null,
      isPendingOperated: json['isPendingOperated'] as bool?,
      lastKey: json['lastKey'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'validationData': validationData?.toJson(),
      'isPendingOperated': isPendingOperated,
      'lastKey': lastKey,
      'result': result,
      'error': error,
      'data': data,
    };
  }
}

class ResponseData {
  bool isSelected;

  ResponseData({required this.isSelected});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(isSelected: json['isSelected'] as bool);
  }

  Map<String, dynamic> toJson() {
    return {'isSelected': isSelected};
  }
}

class ValidationData {
  final String? token;

  ValidationData({this.token});

  factory ValidationData.fromJson(Map<String, dynamic> json) {
    return ValidationData(token: json['token'] as String?);
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
