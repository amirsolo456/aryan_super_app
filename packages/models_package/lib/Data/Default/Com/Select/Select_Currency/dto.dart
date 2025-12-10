



//Ehsan Change
import '../../../debugger/dto.dart';

class currency4bankAccount {
  final int selectId;
  final String selectValue;
  final String selectDisplay;

  currency4bankAccount({
    required this.selectId,
    required this.selectValue,
    required this.selectDisplay,
  });

  factory currency4bankAccount.fromJson(Map<String, dynamic> json) {
    return currency4bankAccount(
      selectId: json["_SelectId"] ?? 0,
      selectValue: json["_SelectValue"] ?? "",
      selectDisplay: json["_SelectDisplay"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_SelectId": selectId,
      "_SelectValue": selectValue,
      "_SelectDisplay": selectDisplay,
    };
  }
}


class CurrencyResponse {
  final List<currency4bankAccount> data;
  final int totalCount;
  final int returnCount;
  final String result;
  final List<DebuggerModel> debugger;

  CurrencyResponse({
    required this.data,
    required this.totalCount,
    required this.returnCount,
    required this.result,
    required this.debugger,
  });

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) {
    return CurrencyResponse(
      data: (json["Data"] as List<dynamic>)
          .map((e) => currency4bankAccount.fromJson(e))
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
