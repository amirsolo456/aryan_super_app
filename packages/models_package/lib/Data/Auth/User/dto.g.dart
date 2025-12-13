// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map json) =>
    Response(
        data: (json['Data'] as List<dynamic>?)
            ?.map(
              (e) => ResponseData.fromJson(Map<String, dynamic>.from(e as Map)),
            )
            .toList(),
      )
      ..result = json['Result'] as String?
      ..status = (json['Status'] as num?)?.toInt()
      ..error = json['Error'] as String?
      ..additionalInfo = json['AdditionalInfo'] as String?
      ..totalCount = (json['TotalCount'] as num?)?.toInt()
      ..key = (json['Key'] as num?)?.toInt();

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
  'Result': instance.result,
  'Status': instance.status,
  'Error': instance.error,
  'Data': instance.data?.map((e) => e.toJson()).toList(),
  'AdditionalInfo': instance.additionalInfo,
  'TotalCount': instance.totalCount,
  'Key': instance.key,
};
