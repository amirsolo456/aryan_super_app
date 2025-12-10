



//Ehsan Change
import '../../../debugger/dto.dart';

class YearSelect4Default {
  final int yearId;
  final String yearDesc;
  final DateTime startDate;
  final DateTime endDate;
  final int placeId;
  final int pendingStatusId;

  YearSelect4Default({
    required this.yearId,
    required this.yearDesc,
    required this.startDate,
    required this.endDate,
    required this.placeId,
    required this.pendingStatusId,
  });

  factory YearSelect4Default.fromJson(Map<String, dynamic> json) {
    return YearSelect4Default(
      yearId: json["YearId"] ?? 0,
      yearDesc: json["YearDesc"] ?? "",
      startDate: DateTime.tryParse(json["StartDate"] ?? "") ?? DateTime(1970),
      endDate: DateTime.tryParse(json["EndDate"] ?? "") ?? DateTime(1970),
      placeId: json["PlaceId"] ?? 0,
      pendingStatusId: json["PendingStatusId"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "YearId": yearId,
      "YearDesc": yearDesc,
      "StartDate": startDate.toIso8601String(),
      "EndDate": endDate.toIso8601String(),
      "PlaceId": placeId,
      "PendingStatusId": pendingStatusId,
    };
  }
}



class YearRootResponse {
  final List<YearSelect4Default> data;
  final int totalCount;
  final int returnCount;
  final String result;
  final List<DebuggerModel> debugger;

  YearRootResponse({
    required this.data,
    required this.totalCount,
    required this.returnCount,
    required this.result,
    required this.debugger,
  });

  factory YearRootResponse.fromJson(Map<String, dynamic> json) {
    return YearRootResponse(
      data: (json["Data"] as List<dynamic>)
          .map((e) => YearSelect4Default.fromJson(e))
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
