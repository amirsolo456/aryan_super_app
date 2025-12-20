// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map json) => Request()
  ..url = json['Url'] as String
  ..id = (json['Id'] as num?)?.toInt()
  ..repoViewId = (json['RepoViewId'] as num?)?.toInt()
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
  'RepoViewId': instance.repoViewId,
  'Ids': instance.ids,
  'FullSearchPhrase': instance.fullSearchPhrase,
  'PagingInfo': instance.pagingInfo.toJson(),
  'OrderInfo': instance.orderInfo.map((e) => e.toJson()).toList(),
  'Filters': instance.filters.toJson(),
  'ShowTags': instance.showTags,
  'ShowMode': instance.showMode,
  'ShowBookmarked': instance.showBookmarked,
  'Defaults': instance.defaults.toJson(),
};

Response _$ResponseFromJson(Map json) => Response(
  result: json['Result'] as String?,
  data: (json['Data'] as List<dynamic>?)
      ?.map((e) => DashboardModel.fromJson(Map<String, dynamic>.from(e as Map)))
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

DashboardModel _$DashboardModelFromJson(Map json) => DashboardModel(
  htmlContent: json['HtmlContent'] as String,
  headers: Map<String, String>.from(json['Headers'] as Map),
  statusCode: (json['StatusCode'] as num).toInt(),
);

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'HtmlContent': instance.htmlContent,
      'Headers': instance.headers,
      'StatusCode': instance.statusCode,
    };
