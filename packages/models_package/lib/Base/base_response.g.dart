// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<D> _$BaseResponseFromJson<D>(
  Map json,
  D Function(Object? json) fromJsonD,
) => BaseResponse<D>(
  result: json['Result'] as String? ?? "Failed",
  status: (json['Status'] as num?)?.toInt(),
  error: json['Error'] as String?,
  data: (json['Data'] as List<dynamic>?)?.map(fromJsonD).toList(),
  additionalInfo: json['AdditionalInfo'] as String?,
  totalCount: (json['TotalCount'] as num?)?.toInt(),
  key: (json['Key'] as num?)?.toInt(),
);

Map<String, dynamic> _$BaseResponseToJson<D>(
  BaseResponse<D> instance,
  Object? Function(D value) toJsonD,
) => <String, dynamic>{
  'Result': instance.result,
  'Status': instance.status,
  'Error': instance.error,
  'Data': instance.data?.map(toJsonD).toList(),
  'AdditionalInfo': instance.additionalInfo,
  'TotalCount': instance.totalCount,
  'Key': instance.key,
};
