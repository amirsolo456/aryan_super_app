
//Ehsan Change


import '../../debugger/dto.dart';

class cashier4SelectOption {
  final int selectId;
  final String? selectValue;
  final String? selectDisplay;

  const cashier4SelectOption({
    this.selectId = 0,
    this.selectValue,
    this.selectDisplay,
  });

  factory cashier4SelectOption.fromJson(Map<String, dynamic> json) {
    return cashier4SelectOption(
      selectId: json['_SelectId'] ?? 0,
      selectValue: json['_SelectValue'] as String?,
      selectDisplay: json['_SelectDisplay'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    '_SelectId': selectId,
    '_SelectValue': selectValue,
    '_SelectDisplay': selectDisplay,
  };

  cashier4SelectOption copyWith({
    int? selectId,
    String? selectValue,
    String? selectDisplay,
  }) {
    return cashier4SelectOption(
      selectId: selectId ?? this.selectId,
      selectValue: selectValue ?? this.selectValue,
      selectDisplay: selectDisplay ?? this.selectDisplay,
    );
  }
}

class SelectOptionResponseModel {
  final List<cashier4SelectOption> data;
  final int totalCount;
  final int returnCount;
  final String? result;
  final List<DebuggerModel> debugger;

  const SelectOptionResponseModel({
    this.data = const [],
    this.totalCount = 0,
    this.returnCount = 0,
    this.result,
    this.debugger = const [],
  });

  factory SelectOptionResponseModel.fromJson(Map<String, dynamic> json) {
    return SelectOptionResponseModel(
      data: (json['Data'] as List<dynamic>? ?? [])
          .map((e) => cashier4SelectOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['TotalCount'] ?? 0,
      returnCount: json['ReturnCount'] ?? 0,
      result: json['Result'] as String?,
      debugger: (json['Debugger'] as List<dynamic>? ?? [])
          .map((e) => DebuggerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'Data': data.map((e) => e.toJson()).toList(),
    'TotalCount': totalCount,
    'ReturnCount': returnCount,
    'Result': result,
    'Debugger': debugger.map((e) => e.toJson()).toList(),
  };
}
