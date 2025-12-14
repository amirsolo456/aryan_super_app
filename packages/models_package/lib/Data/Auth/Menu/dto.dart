import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import '../../../Base/base_request.dart';
import '../../../Base/base_response.dart';

part 'dto.g.dart';

@JsonSerializable()
class Request extends BaseRequest {
  final int menuType;

  Request({required this.menuType});

  factory Request.fromJson(Map<String, dynamic> json) =>
      _$RequestFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return _$RequestToJson(this);
  }
}

@JsonSerializable()
class Response extends BaseResponse<ResponseData> {
  Response({
    String? result,
    List<ResponseData>? data,
    String? error,
    int totalCount = 0,
    String? additionalInfo,
    int? status,
    int? key,
  }) : super(
         result: result,
         data: data,
         error: error,
         totalCount: totalCount,
         additionalInfo: additionalInfo,
         status: status,
         key: key,
       );

  Response.fromData(List<ResponseData> dataList)
    : super(
        result: 'Success',
        data: dataList,
        error: null,
        totalCount: dataList.length,
        additionalInfo: null,
        status: 200,
        key: null,
      );

  @override
  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(toJsonD) {return _$ResponseToJson(this);}
}

@JsonSerializable()
class ResponseData {
  int? menuId;
  String? menuDesc;
  String? appLink;
  int? actionType;
  int? fatherId;
  int? menuType;
  String? webLink;
  int? actionId;
  int? repoId;
  String? icon;
  String? iconUrl;
  List<ResponseData> subMenus;
  bool isSelected;

  ResponseData({
    this.menuId,
    this.actionType,
    this.fatherId,
    this.menuType,
    this.menuDesc,
    this.appLink,
    this.webLink,
    this.actionId,
    this.repoId,
    this.icon,
    this.iconUrl,
    List<ResponseData>? subMenus,
    this.isSelected = false,
  }) : subMenus = subMenus ?? [];

  ResponseData copyWith({
    int? menuId,
    String? menuDesc,
    int? actionType,
    int? fatherId,
    int? menuType,
    String? appLink,
    String? webLink,
    int? actionId,
    int? repoId,
    String? icon,
    String? iconUrl,
    List<ResponseData>? subMenus,
    bool? isSelected,
  }) {
    return ResponseData(
      menuId: menuId ?? this.menuId,
      actionType: actionType ?? this.actionType,
      fatherId: fatherId ?? this.fatherId,
      menuType: menuType ?? this.menuType,
      menuDesc: menuDesc ?? this.menuDesc,
      appLink: appLink ?? this.appLink,
      webLink: webLink ?? this.webLink,
      actionId: actionId ?? this.actionId,
      repoId: repoId ?? this.repoId,
      icon: icon ?? this.icon,
      iconUrl: iconUrl ?? this.iconUrl,
      subMenus: subMenus ?? List<ResponseData>.from(this.subMenus),
      isSelected: isSelected ?? this.isSelected,
    );
  }

  factory ResponseData.fromJson(Map<String, dynamic> fromJsonD) =>
      _$ResponseDataFromJson(fromJsonD);

  @override
  Map<String, dynamic> toJson() {
    return _$ResponseDataToJson(this);
  }
}
