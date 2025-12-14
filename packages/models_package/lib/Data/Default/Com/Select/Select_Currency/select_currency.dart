//
//
//
//
// //Ehsan Change
// import '../../../../../Base/base_request.dart';
// import '../../../../../Base/base_response.dart';
// import '../../../debugger/dto.dart';
//
//
//
// class Request extends BaseRequest {
//   int RepoViewId;
//   int ShowMode;
//
//   Request({required this.RepoViewId,required this.ShowMode});
// }
//
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
//   Map<String, dynamic> toJson() {
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
//
//
//
// class ResponseData {
//   final int selectId;
//   final String selectValue;
//   final String selectDisplay;
//
//   ResponseData({
//     required this.selectId,
//     required this.selectValue,
//     required this.selectDisplay,
//   });
//
//   factory ResponseData.fromJson(Map<String, dynamic> json) {
//     return ResponseData(
//       selectId: json["_SelectId"] ?? 0,
//       selectValue: json["_SelectValue"] ?? "",
//       selectDisplay: json["_SelectDisplay"] ?? "",
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "_SelectId": selectId,
//       "_SelectValue": selectValue,
//       "_SelectDisplay": selectDisplay,
//     };
//   }
// }
//
//
// class CurrencyResponse {
//   final List<ResponseData> data;
//   final int totalCount;
//   final int returnCount;
//   final String result;
//   final List<DebuggerModel> debugger;
//
//   CurrencyResponse({
//     required this.data,
//     required this.totalCount,
//     required this.returnCount,
//     required this.result,
//     required this.debugger,
//   });
//
//   factory CurrencyResponse.fromJson(Map<String, dynamic> json) {
//     return CurrencyResponse(
//       data: (json["Data"] as List<dynamic>)
//           .map((e) => ResponseData.fromJson(e))
//           .toList(),
//       totalCount: json["TotalCount"] ?? 0,
//       returnCount: json["ReturnCount"] ?? 0,
//       result: json["Result"] ?? "",
//       debugger: (json["Debugger"] as List<dynamic>)
//           .map((e) => DebuggerModel.fromJson(e))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       "Data": data.map((e) => e.toJson()).toList(),
//       "TotalCount": totalCount,
//       "ReturnCount": returnCount,
//       "Result": result,
//       "Debugger": debugger.map((e) => e.toJson()).toList(),
//     };
//   }
// }
