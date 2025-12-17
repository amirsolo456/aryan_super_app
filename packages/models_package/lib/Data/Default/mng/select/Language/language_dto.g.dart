// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map json) =>
    Request(repoViewId: (json['RepoViewId'] as num?)?.toInt())
      ..url = json['Url'] as String
      ..id = (json['Id'] as num?)?.toInt()
      ..ids = (json['Ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList()
      ..fullSearchPhrase = json['FullSearchPhrase'] as String?
      ..pagingInfo = PagingInfo.fromJson(
        Map<String, dynamic>.from(json['PagingInfo'] as Map),
      )
      ..orderInfo = (json['OrderInfo'] as List<dynamic>)
          .map((e) => OrderInfo.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList()
      ..filters = Filters.fromJson(
        Map<String, dynamic>.from(json['Filters'] as Map),
      )
      ..showTags = json['ShowTags'] as bool?
      ..showMode = (json['ShowMode'] as num?)?.toInt()
      ..showBookmarked = json['ShowBookmarked'] as bool?
      ..defaults = Defaults.fromJson(
        Map<String, dynamic>.from(json['Defaults'] as Map),
      );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
  'Url': instance.url,
  'Id': instance.id,
  'Ids': instance.ids,
  'FullSearchPhrase': instance.fullSearchPhrase,
  'PagingInfo': instance.pagingInfo.toJson(),
  'OrderInfo': instance.orderInfo.map((e) => e.toJson()).toList(),
  'Filters': instance.filters.toJson(),
  'ShowTags': instance.showTags,
  'ShowMode': instance.showMode,
  'ShowBookmarked': instance.showBookmarked,
  'Defaults': instance.defaults.toJson(),
  'RepoViewId': instance.repoViewId,
};

Response _$ResponseFromJson(Map json) => Response(
  result: json['Result'] as String?,
  data: (json['Data'] as List<dynamic>?)
      ?.map((e) => ResponseData.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  error: json['Error'] as String?,
  totalCount: (json['TotalCount'] as num?)?.toInt() ?? 0,
  additionalInfo: json['AdditionalInfo'] as String?,
  status: (json['Status'] as num?)?.toInt(),
  key: (json['Key'] as num?)?.toInt(),
);

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
  'Result': instance.result,
  'Status': instance.status,
  'Data': instance.data?.map((e) => e.toJson()).toList(),
  'AdditionalInfo': instance.additionalInfo,
  'TotalCount': instance.totalCount,
  'Key': instance.key,
};

ResponseData _$ResponseDataFromJson(Map json) => ResponseData(
  LanguageId: (json['LanguageId'] as num).toInt(),
  LanguageDesc: json['LanguageDesc'] as String,
  Code: json['Code'] as String,
  PlaceId: (json['PlaceId'] as num).toInt(),
  CreateDate: DateTime.parse(json['CreateDate'] as String),
  CreateUserId: (json['CreateUserId'] as num).toInt(),
  Inactive: json['Inactive'] as bool,
);

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'LanguageId': instance.LanguageId,
      'LanguageDesc': instance.LanguageDesc,
      'Code': instance.Code,
      'PlaceId': instance.PlaceId,
      'CreateDate': instance.CreateDate.toIso8601String(),
      'CreateUserId': instance.CreateUserId,
      'Inactive': instance.Inactive,
    };
