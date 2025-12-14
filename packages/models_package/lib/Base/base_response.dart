
import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<D> {
  BaseResponse({
    this.result = "Failed",
    this.status,
    this.error,
    this.exception,
    this.data,
    this.additionalInfo,
    this.totalCount,
    this.key,
  });

  String? result;
  int? status;
  String? error;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Exception? exception;
  List<D>? data;
  String? additionalInfo;
  int? totalCount;
  int? key;

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      D Function(Object? json) fromJsonD,
      ) => _$BaseResponseFromJson<D>(json, fromJsonD);

  Map<String, dynamic> toJson(Object? Function(D value) toJsonD) =>
      _$BaseResponseToJson<D>(this, toJsonD);

  factory BaseResponse.error(Exception e) {
    try {
      return BaseResponse<D>(
        result: 'Failed',
        status: 0,
        error: e.toString(),
        exception: Exception(e.toString()),
        data: null,
        additionalInfo: 'a',
        totalCount: null,
        key: null,
      );
    } catch (ex) {
      return BaseResponse<D>(
        result: 'Failed',
        status: null,
        error: null,
        exception: null,
        data: null,
        additionalInfo: null,
        totalCount: null,
        key: null,
      );
    }
  }

  factory BaseResponse.success(String? message) {
    return BaseResponse<D>(result: "Success", error: message);
  }
}




// import 'dart:core';
//
// import 'package:json_annotation/json_annotation.dart';
//
// part 'base_response.g.dart';
//
// @JsonSerializable(genericArgumentFactories: true)
// class BaseResponse<D> {
//   BaseResponse({
//     this.result = "Failed",
//     this.status,
//     this.error,
//     this.exception,
//     this.data,
//     this.additionalInfo,
//     this.totalCount,
//     this.key,
//   });
//
//   String? result;
//   int? status;
//   String? error;
//   @JsonKey(includeFromJson: false, includeToJson: false)
//   final Exception? exception;
//   List<D>? data;
//   String? additionalInfo;
//   int? totalCount;
//   int? key;
//
//   factory BaseResponse.fromJson(
//     Map<String, dynamic> json,
//     D Function(Object? json) fromJsonD,
//   ) => _$BaseResponseFromJson<D>(json, fromJsonD);
//
//   Map<String, dynamic> toJson(Object? Function(D value) toJsonD) =>
//       _$BaseResponseToJson<D>(this, toJsonD);
//
//   factory BaseResponse.error(Exception e) {
//     try {
//       return BaseResponse<D>(
//         result: 'Failed',
//         status: 0,
//         error: e.toString(),
//         exception: Exception(e.toString()),
//         data: null,
//         additionalInfo: 'a',
//         totalCount: null,
//         key: null,
//       );
//     } catch (ex) {
//       return BaseResponse<D>(
//         result: 'Failed',
//         status: null,
//         error: null,
//         exception: null,
//         data: null,
//         additionalInfo: null,
//         totalCount: null,
//         key: null,
//       );
//     }
//   }
//
//   factory BaseResponse.success(String? message) {
//     return BaseResponse<D>(result: "Success", error: message);
//   }
// }
