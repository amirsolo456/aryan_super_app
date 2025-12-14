//
// //Ehsan Change
// import 'package:json_annotation/json_annotation.dart';
//
// import '../../../../../Base/base_request.dart';
// import '../../../../../Base/base_response.dart';
// import '../../../debugger/dto.dart';
//
//
//
// @JsonSerializable()
// class Request extends BaseRequest {
//   @override
//   int? repoViewId;
//
//   Request({this.repoViewId});
// }
//
// @JsonSerializable()
// class Response extends BaseResponse<ResponseData> {
//   Response({
//     String? result,
//     List<ResponseData>? data,
//     String? error,
//     int totalCount = 0,
//     String? additionalInfo,
//     int? status,
//     int? key,
//   }) : super(
//     result: result,
//     data: data,
//     error: error,
//     totalCount: totalCount,
//     additionalInfo: additionalInfo,
//     status: status,
//     key: key,
//   );
//
//   Response.fromData(List<ResponseData> dataList)
//       : super(
//     result: 'Success',
//     data: dataList,
//     error: null,
//     totalCount: dataList.length,
//     additionalInfo: null,
//     status: 200,
//     key: null,
//   );
//
//   factory Response.fromJson(Map<String, dynamic> json) {
//     // یافتن کلید data در JSON (حساس به بزرگی/کوچکی حروف)
//     final dataKey = json.keys.firstWhere(
//           (key) => key.toLowerCase() == 'data',
//       orElse: () => 'data',
//     );
//
//     List<ResponseData> dataList = [];
//
//     if (json[dataKey] is List) {
//       dataList = (json[dataKey] as List)
//           .whereType<Map<String, dynamic>>()
//           .map((item) => ResponseData.fromJson(item))
//           .toList();
//     }
//
//     // استخراج سایر فیلدها از JSON
//     final result = json['result'] ?? json['Result'];
//     final error = json['error'] ?? json['Error'];
//     final additionalInfo = json['additionalInfo'] ?? json['AdditionalInfo'];
//     final status =
//         json['status'] ??
//             json['Status'] ??
//             json['statusCode'] ??
//             json['StatusCode'];
//     final key = json['key'] ?? json['Key'];
//     final totalCount = json['totalCount'] ?? json['TotalCount'] ?? dataList.length;
//
//     return Response(
//       result: result?.toString(),
//       data: dataList.isNotEmpty ? dataList : null,
//       error: error?.toString(),
//       totalCount: totalCount is int
//           ? totalCount
//           : (totalCount != null ? int.tryParse(totalCount.toString()) ?? 0 : 0),
//       additionalInfo: additionalInfo?.toString(),
//       status: status is int
//           ? status
//           : (status != null ? int.tryParse(status.toString()) : null),
//       key: key is int
//           ? key
//           : (key != null ? int.tryParse(key.toString()) : null),
//     );
//   }
//
//   // متد کمکی برای تبدیل به JSON
//   Map<String, dynamic> toJson(toJsonD) {
//     return {
//       'result': result,
//       'data': data?.map((e) => e.toJson()).toList(),
//       'error': error,
//       'totalCount': totalCount,
//       'additionalInfo': additionalInfo,
//       'status': status,
//       'key': key,
//     };
//   }
// }
//
//
// class ResponseData {
//   final int placeId;
//   final String? placeCode;
//   final String? placeDesc;
//   final String? placeAddress;
//   final List<ResponseData> subUnits;
//
//   const ResponseData({
//     this.placeId = 0,
//     this.placeCode,
//     this.placeDesc,
//     this.placeAddress,
//     this.subUnits = const [],
//   });
//
//
//   factory ResponseData.fromJson(Map<String, dynamic> json) {
//     return ResponseData(
//       placeId: json['PlaceId'] ?? 0,
//       placeCode: json['PlaceCode'] as String?,
//       placeDesc: json['PlaceDesc'] as String?,
//       placeAddress: json['PlaceAddress'] as String?,
//       subUnits: (json['SubUnits'] as List<dynamic>? ?? [])
//           .map((e) => ResponseData.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'PlaceId': placeId,
//     'PlaceCode': placeCode,
//     'PlaceDesc': placeDesc,
//     'PlaceAddress': placeAddress,
//     'SubUnits': subUnits.map((e) => e.toJson()).toList(),
//   };
//
//   ResponseData copyWith({
//     int? placeId,
//     String? placeCode,
//     String? placeDesc,
//     String? placeAddress,
//     List<ResponseData>? subUnits,
//   }) {
//     return ResponseData(
//       placeId: placeId ?? this.placeId,
//       placeCode: placeCode ?? this.placeCode,
//       placeDesc: placeDesc ?? this.placeDesc,
//       placeAddress: placeAddress ?? this.placeAddress,
//       subUnits: subUnits ?? this.subUnits,
//     );
//   }
// }
//
// @JsonSerializable()
// class PlaceResponseModel {
//   final List<ResponseData> data;
//   final int totalCount;
//   final int returnCount;
//   final String? result;
//   final List<DebuggerModel> debugger;
//
//   const PlaceResponseModel({
//     this.data = const [],
//     this.totalCount = 0,
//     this.returnCount = 0,
//     this.result,
//     this.debugger = const [],
//   });
//
//   factory PlaceResponseModel.fromJson(Map<String, dynamic> json) {
//     return PlaceResponseModel(
//       data: (json['Data'] as List<dynamic>? ?? [])
//           .map((e) => ResponseData.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       totalCount: json['TotalCount'] ?? 0,
//       returnCount: json['ReturnCount'] ?? 0,
//       result: json['Result'] as String?,
//       debugger: (json['Debugger'] as List<dynamic>? ?? [])
//           .map((e) => DebuggerModel.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'Data': data.map((e) => e.toJson()).toList(),
//     'TotalCount': totalCount,
//     'ReturnCount': returnCount,
//     'Result': result,
//     'Debugger': debugger.map((e) => e.toJson()).toList(),
//   };
// }
