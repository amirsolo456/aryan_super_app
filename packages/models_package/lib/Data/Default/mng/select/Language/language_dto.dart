//Ehsan Change
import 'package:json_annotation/json_annotation.dart';

import '../../../../../Base/base_request.dart';
import '../../../../../Base/base_response.dart';
import '../../../debugger/dto.dart';

part 'language_dto.g.dart'; // این خط را اضافه کنید

@JsonSerializable()
class Request extends BaseRequest {
  @override
  int? repoViewId;

  Request({this.repoViewId});
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
    final totalCount =
        json['totalCount'] ?? json['TotalCount'] ?? dataList.length;

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
  Map<String, dynamic> toJson(toJsonD) {
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

@JsonSerializable()
class ResponseData {
  final int LanguageId;
  final String LanguageDesc;
  final String Code;
  final int PlaceId;
  final DateTime CreateDate;
  final int CreateUserId;
  final bool Inactive;

  ResponseData({
    required this.LanguageId,
    required this.LanguageDesc,
    required this.Code,
    required this.PlaceId,
    required this.CreateDate,
    required this.CreateUserId,
    required this.Inactive,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      LanguageId: json["LanguageId"] ?? 0,
      LanguageDesc: json["LanguageDesc"] ?? "",
      Code: json["Code"] ?? "",
      PlaceId: json["PlaceId"] ?? 0,
      CreateDate: DateTime.parse(json["CreateDate"]),
      CreateUserId: json["CreateUserId"] ?? 0,
      Inactive: json["Inactive"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "LanguageId": LanguageId,
      "LanguageDesc": LanguageDesc,
      "Code": Code,
      "PlaceId": PlaceId,
      "CreateDate": CreateDate.toIso8601String(),
      "CreateUserId": CreateUserId,
      "Inactive": Inactive,
    };
  }
}

class LanguageResponse {
  final List<ResponseData> data;
  final int totalCount;
  final int returnCount;
  final String result;
  final List<DebuggerModel> debugger;

  LanguageResponse({
    required this.data,
    required this.totalCount,
    required this.returnCount,
    required this.result,
    required this.debugger,
  });

  factory LanguageResponse.fromJson(Map<String, dynamic> json) {
    return LanguageResponse(
      data: (json["Data"] as List<dynamic>)
          .map((e) => ResponseData.fromJson(e))
          .toList(),
      totalCount: json["TotalCount"] ?? 0,
      returnCount: json["ReturnCount"] ?? 0,
      result: json["Result"] ?? "",
      debugger: (json["Debugger"] as List<dynamic>)
          .map((e) => DebuggerModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Data": data.map((e) => e.toJson()).toList(),
      "TotalCount": totalCount,
      "ReturnCount": returnCount,
      "Result": result,
      "Debugger": debugger.map((e) => e.toJson()).toList(),
    };
  }
}
