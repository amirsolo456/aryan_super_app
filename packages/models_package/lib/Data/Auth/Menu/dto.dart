import '../../../Base/base_request.dart';
import '../../../Base/base_response.dart';

class Request extends BaseRequest {
  int menuType;

  Request({required this.menuType});
}

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

  factory Response.fromJson(Map<String, dynamic> json) {
    // یافتن کلید data در JSON (حساس به بزرگی/کوچکی حروف)
    final dataKey = json.keys.firstWhere(
      (key) => key.toLowerCase() == 'data',
      orElse: () => 'data',
    );

    List<ResponseData> dataList = [];

    if (json[dataKey] is List) {
      dataList = (json[dataKey] as List)
          .whereType<Map<String, dynamic>>()
          .map((item) => ResponseData.fromJson(item))
          .toList();
    }

    // استخراج سایر فیلدها از JSON
    final result = json['result'] ?? json['Result'];
    final error = json['error'] ?? json['Error'];
    final additionalInfo = json['additionalInfo'] ?? json['AdditionalInfo'];
    final status =
        json['status'] ??
        json['Status'] ??
        json['statusCode'] ??
        json['StatusCode'];
    final key = json['key'] ?? json['Key'];
    final totalCount = json['totalCount'] ?? json['TotalCount'] ?? dataList.length;

    return Response(
      result: result?.toString(),
      data: dataList.isNotEmpty ? dataList : null,
      error: error?.toString(),
      totalCount: totalCount is int
          ? totalCount
          : (totalCount != null ? int.tryParse(totalCount.toString()) ?? 0 : 0),
      additionalInfo: additionalInfo?.toString(),
      status: status is int
          ? status
          : (status != null ? int.tryParse(status.toString()) : null),
      key: key is int
          ? key
          : (key != null ? int.tryParse(key.toString()) : null),
    );
  }

  // متد کمکی برای تبدیل به JSON
  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'data': data?.map((e) => e.toJson()).toList(),
      'error': error,
      'totalCount': totalCount,
      'additionalInfo': additionalInfo,
      'status': status,
      'key': key,
    };
  }
}

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

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      menuId: json['MenuId'] as int?,
      actionType: json['ActionType'] as int?,
      fatherId: json['FatherId'] as int?,
      menuType: json['MenuType'] as int?,
      menuDesc: json['MenuDesc'] as String?,
      appLink: json['AppLink'] as String?,
      webLink: json['WebLink'] as String?,
      actionId: json['ActionId'] as int?,
      repoId: json['RepoId'] as int?,
      icon: json['Icon'] as String?,
      iconUrl: json['IconUrl'] as String?,
      subMenus:
          (json['SubMenus'] as List?)
              ?.map((item) => ResponseData.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MenuId': menuId,
      'MenuDesc': menuDesc,
      'AppLink': appLink,
      'WebLink': webLink,
      'ActionId': actionId,
      'RepoId': repoId,

      'Icon': icon,
      'IconUrl': iconUrl,
      'IsSelected': isSelected,
      'SubMenus': subMenus.map((item) => item.toJson()).toList(),
    };
  }
}

// Interface ISelectable
abstract class ISelectable {
  bool get isSelected;

  set isSelected(bool value);
}

// Base classes placeholder
class BaseQueryRequest {
  // می‌تونی ویژگی‌های مشترک درخواست‌ها رو اینجا اضافه کنی
}

// class BaseResponse<D> {
//   String? result;
//   String? error;
//   int? status;
//   int? key;
//   int totalCount;
//   String? additionalInfo;
//   List<T>? data;
//
//   BaseResponse({
//     this.result,
//     this.data,
//     this.error,
//     this.totalCount = 0,
//     this.additionalInfo,
//     this.status,
//     this.key,
//   });
//   factory  BaseResponse.fromJson(return BaseResponse<D>)
//   factory BaseResponse.error(String message) {
//     return BaseResponse<T>(
//       result: "Failed",
//       error: message,
//       status: 500,
//       data: [],
//     );
//   }
// }
