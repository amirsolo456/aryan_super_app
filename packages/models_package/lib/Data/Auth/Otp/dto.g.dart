// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map json) =>
    Response(
        validationData: json['ValidationData'] == null
            ? null
            : ValidationData.fromJson(
                Map<String, dynamic>.from(json['ValidationData'] as Map),
              ),
        isPendingOperated: json['IsPendingOperated'] as bool?,
        lastKey: (json['LastKey'] as num?)?.toInt(),
      )
      ..result = json['Result'] as String?
      ..status = (json['Status'] as num?)?.toInt()
      ..error = json['Error'] as String?
      ..data = (json['Data'] as List<dynamic>?)
          ?.map(
            (e) => ResponseData.fromJson(Map<String, dynamic>.from(e as Map)),
          )
          .toList()
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
  'ValidationData': instance.validationData?.toJson(),
  'IsPendingOperated': instance.isPendingOperated,
  'LastKey': instance.lastKey,
};

ValidationData _$ValidationDataFromJson(Map json) =>
    ValidationData(token: json['Token'] as String?);

Map<String, dynamic> _$ValidationDataToJson(ValidationData instance) =>
    <String, dynamic>{'Token': instance.token};
