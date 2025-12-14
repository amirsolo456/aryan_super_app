import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../Base/base_request.dart';
import '../../../../Base/base_response.dart';
import '../../debugger/dto.dart';

part 'select_option_dto.g.dart'; // این خط را اضافه کنید

@JsonSerializable()
class SelectOptionRequest extends BaseRequest {
  @JsonKey(name: 'RepoViewId')
  final int repoViewId;

  SelectOptionRequest({
    required this.repoViewId,
  });

  factory SelectOptionRequest.fromJson(Map<String, dynamic> json) =>
      _$SelectOptionRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SelectOptionRequestToJson(this);
}

@JsonSerializable()
class SelectOptionResponse extends BaseResponse<SelectOptionData> {
  @JsonKey(name: 'Debugger')
  final List<DebuggerModel>? debugger;

  @JsonKey(name: 'ReturnCount')
  final int? returnCount;

  SelectOptionResponse({
    String? result,
    List<SelectOptionData>? data,
    String? error,
    int? totalCount,
    String? additionalInfo,
    int? status,
    int? key,
    this.debugger,
    this.returnCount,
  }) : super(
    result: result,
    data: data,
    error: error,
    totalCount: totalCount,
    additionalInfo: additionalInfo,
    status: status,
    key: key,
  );

  factory SelectOptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SelectOptionResponseFromJson(json);

  @override
  Map<String, dynamic> toJson(toJsonD) => _$SelectOptionResponseToJson(this);

  // متد کمکی برای ایجاد Response از لیست داده
  factory SelectOptionResponse.fromData(List<SelectOptionData> dataList) {
    return SelectOptionResponse(
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
class SelectOptionData extends Equatable {
  @JsonKey(name: '_SelectId', defaultValue: 0)
  final int selectId;

  @JsonKey(name: '_SelectValue')
  final String? selectValue;

  @JsonKey(name: '_SelectDisplay')
  final String? selectDisplay;

  const SelectOptionData({
    this.selectId = 0,
    this.selectValue,
    this.selectDisplay,
  });

  factory SelectOptionData.fromJson(Map<String, dynamic> json) =>
      _$SelectOptionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SelectOptionDataToJson(this);

  SelectOptionData copyWith({
    int? selectId,
    String? selectValue,
    String? selectDisplay,
  }) {
    return SelectOptionData(
      selectId: selectId ?? this.selectId,
      selectValue: selectValue ?? this.selectValue,
      selectDisplay: selectDisplay ?? this.selectDisplay,
    );
  }

  @override
  List<Object?> get props => [selectId, selectValue, selectDisplay];
}

@JsonSerializable()
class SelectOptionResponseModel {
  @JsonKey(name: 'Data', defaultValue: const [])
  final List<SelectOptionData> data;

  @JsonKey(name: 'TotalCount', defaultValue: 0)
  final int totalCount;

  @JsonKey(name: 'ReturnCount', defaultValue: 0)
  final int returnCount;

  @JsonKey(name: 'Result')
  final String? result;

  @JsonKey(name: 'Debugger', defaultValue: const [])
  final List<DebuggerModel> debugger;

  const SelectOptionResponseModel({
    this.data = const [],
    this.totalCount = 0,
    this.returnCount = 0,
    this.result,
    this.debugger = const [],
  });

  factory SelectOptionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SelectOptionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SelectOptionResponseModelToJson(this);
}