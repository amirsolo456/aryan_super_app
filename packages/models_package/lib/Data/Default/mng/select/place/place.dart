
//Ehsan Change
import '../../../debugger/dto.dart';

class place {
  final int placeId;
  final String? placeCode;
  final String? placeDesc;
  final String? placeAddress;
  final List<place> subUnits;

  const place({
    this.placeId = 0,
    this.placeCode,
    this.placeDesc,
    this.placeAddress,
    this.subUnits = const [],
  });

  factory place.fromJson(Map<String, dynamic> json) {
    return place(
      placeId: json['PlaceId'] ?? 0,
      placeCode: json['PlaceCode'] as String?,
      placeDesc: json['PlaceDesc'] as String?,
      placeAddress: json['PlaceAddress'] as String?,
      subUnits: (json['SubUnits'] as List<dynamic>? ?? [])
          .map((e) => place.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'PlaceId': placeId,
    'PlaceCode': placeCode,
    'PlaceDesc': placeDesc,
    'PlaceAddress': placeAddress,
    'SubUnits': subUnits.map((e) => e.toJson()).toList(),
  };

  place copyWith({
    int? placeId,
    String? placeCode,
    String? placeDesc,
    String? placeAddress,
    List<place>? subUnits,
  }) {
    return place(
      placeId: placeId ?? this.placeId,
      placeCode: placeCode ?? this.placeCode,
      placeDesc: placeDesc ?? this.placeDesc,
      placeAddress: placeAddress ?? this.placeAddress,
      subUnits: subUnits ?? this.subUnits,
    );
  }
}


class PlaceResponseModel {
  final List<place> data;
  final int totalCount;
  final int returnCount;
  final String? result;
  final List<DebuggerModel> debugger;

  const PlaceResponseModel({
    this.data = const [],
    this.totalCount = 0,
    this.returnCount = 0,
    this.result,
    this.debugger = const [],
  });

  factory PlaceResponseModel.fromJson(Map<String, dynamic> json) {
    return PlaceResponseModel(
      data: (json['Data'] as List<dynamic>? ?? [])
          .map((e) => place.fromJson(e as Map<String, dynamic>))
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
