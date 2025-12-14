
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../Base/base_request.dart';
import '../../../../../Base/base_response.dart';
import '../../../debugger/dto.dart';

part 'currency_dto.g.dart';

@JsonSerializable()
class CurrencyRequest extends BaseRequest {
  @JsonKey(name: 'RepoViewId')
  final int repoViewId;

  @JsonKey(name: 'ShowMode')
  final int showMode;

  CurrencyRequest({
    required this.repoViewId,
    required this.showMode,
  });

  factory CurrencyRequest.fromJson(Map<String, dynamic> json) =>
      _$CurrencyRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CurrencyRequestToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class CurrencyResponse extends BaseResponse<ResponseData> {
  @JsonKey(name: 'Debugger')
  final List<DebuggerModel> debugger;

  @JsonKey(name: 'ReturnCount')
  final int returnCount;

  CurrencyResponse({
    String? result,
    List<ResponseData>? data,
    String? error,
    int? totalCount,
    String? additionalInfo,
    int? status,
    int? key,
    required this.debugger,
    required this.returnCount,
  }) : super(
    result: result,
    data: data,
    error: error,
    totalCount: totalCount,
    additionalInfo: additionalInfo,
    status: status,
    key: key,
  );

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrencyResponseFromJson(
        json
      );

  @override
  Map<String, dynamic> toJson(toJsonD) => _$CurrencyResponseToJson(
    this,);

  // متد کمکی برای ایجاد Response از لیست داده
  factory CurrencyResponse.fromData(List<ResponseData> dataList) {
    return CurrencyResponse(
      result: 'Success',
      data: dataList,
      error: null,
      totalCount: dataList.length,
      additionalInfo: null,
      status: 200,
      key: null,
      debugger: [],
      returnCount: dataList.length,
    );
  }
}

@JsonSerializable()
class ResponseData extends Equatable {
  @JsonKey(name: '_SelectId')
  final int selectId;

  @JsonKey(name: '_SelectValue')
  final String selectValue;

  @JsonKey(name: '_SelectDisplay')
  final String selectDisplay;

  ResponseData({
    required this.selectId,
    required this.selectValue,
    required this.selectDisplay,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);

  @override
  List<Object?> get props => [selectId, selectValue, selectDisplay];
}