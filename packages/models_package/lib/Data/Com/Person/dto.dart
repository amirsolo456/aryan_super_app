import 'package:json_annotation/json_annotation.dart';

import '../../../Base/base_request.dart';
import '../../../Base/base_response.dart';
import '../../Auth/Tag/dto.dart' show TagData;

part 'dto.g.dart';

@JsonSerializable()
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

@JsonSerializable()
class Response extends BaseResponse<ResponseData> {
  Response({List<ResponseData>? data}) {
    this.data = data ?? [];
  }

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(toJsonD) {
    return _$ResponseToJson(this);
  }
}

@JsonSerializable()
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

  factory ResponseData.fromJson(Map<String, dynamic> fromJsonD) =>
      _$ResponseDataFromJson(fromJsonD);

  Map<String, dynamic> toJson() {
    return _$ResponseDataToJson(this);
  }
}
