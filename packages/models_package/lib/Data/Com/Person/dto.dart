

import '../../../Base/base_request.dart';
import '../../../Base/base_response.dart';
import '../../Auth/Tag/dto.dart' show TagData;

class Request extends BaseRequest {

  Request();

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request();
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}

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

class ResponseData {
  int? personId;
  String? firstName;
  String? lastName;
  String? fullName;
  bool? isForeign;
  String? fatherName;
  String? nationalCode;
  String? economicCode;
  String? identityNumber;
  String? birthDate;
  bool isSelected;
  String? displayName;
  int? placeId;
  List<TagData> tagsInfo;
  bool hasBookMark;
  int pendingStatusId;

  ResponseData({
    this.personId,
    this.firstName,
    this.lastName,
    this.fullName,
    this.isForeign,
    this.fatherName,
    this.nationalCode,
    this.economicCode,
    this.identityNumber,
    this.birthDate,
    this.isSelected = false,
    this.displayName,
    this.placeId,
    List<TagData>? tagsInfo,
    this.hasBookMark = false,
    this.pendingStatusId = 0,
  }) : tagsInfo = tagsInfo ?? [];

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      personId: json['personId'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      fullName: json['fullName'] as String?,
      isForeign: json['isForeign'] as bool?,
      fatherName: json['fatherName'] as String?,
      nationalCode: json['nationalCode'] as String?,
      economicCode: json['economicCode'] as String?,
      identityNumber: json['identityNumber'] as String?,
      birthDate: json['birthDate'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
      displayName: json['displayName'] as String?,
      placeId: json['placeId'] as int?,
      tagsInfo: json['tagsInfo'] != null
          ? List<TagData>.from(
        (json['tagsInfo'] as List).map((x) => TagData.fromJson(x)),
      )
          : [],
      hasBookMark: json['hasBookMark'] as bool? ?? false,
      pendingStatusId: json['pendingStatusId'] as int? ?? 0,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'personId': personId,
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'isForeign': isForeign,
      'fatherName': fatherName,
      'nationalCode': nationalCode,
      'economicCode': economicCode,
      'identityNumber': identityNumber,
      'birthDate': birthDate,
      'isSelected': isSelected,
      'displayName': displayName,
      'placeId': placeId,
      'tagsInfo': tagsInfo.map((x) => x.toJson()).toList(),
      'hasBookMark': hasBookMark,
      'pendingStatusId': pendingStatusId,
    };
  }
}
