//
//
//
//
// //Ehsan Change
// import 'package:json_annotation/json_annotation.dart';
//
// import '../../../../../Base/base_request.dart';
// import '../../../../../Base/base_response.dart';
//
//
//
// @JsonSerializable()
// class Request extends BaseRequest {
//
//   Request();
// }
//
// @JsonSerializable()
// class Response extends BaseResponse<DashboardModel> {
//   Response({
//     String? result,
//     List<DashboardModel>? data,
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
//   Response.fromData(List<DashboardModel> dataList)
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
//     List<DashboardModel> dataList = [];
//
//     if (json[dataKey] is List) {
//       dataList = (json[dataKey] as List)
//           .whereType<Map<String, dynamic>>()
//           .map((item) => DashboardModel.fromJson(item))
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
// @JsonSerializable()
//
// class DashboardModel {
//   final String htmlContent;
//   final Map<String, String> headers;
//   final int statusCode;
//
//   DashboardModel({
//     required this.htmlContent,
//     required this.headers,
//     required this.statusCode,
//   });
//
//   factory DashboardModel.fromJson(Map<String, dynamic> json) {
//     return DashboardModel(
//       htmlContent: json['htmlContent'] ?? '',
//       headers: Map<String, String>.from(json['headers'] ?? {}),
//       statusCode: json['statusCode'] ?? 200,
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'htmlContent': htmlContent,
//     'headers': headers,
//     'statusCode': statusCode,
//   };
// }