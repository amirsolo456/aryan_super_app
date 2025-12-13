// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRequest _$BaseRequestFromJson(Map json) => BaseRequest(
  url: json['Url'] as String? ?? '',
  id: (json['Id'] as num?)?.toInt(),
  repoViewId: (json['RepoViewId'] as num?)?.toInt(),
  ids: (json['Ids'] as List<dynamic>?)?.map((e) => (e as num).toInt()).toList(),
  fullSearchPhrase: json['FullSearchPhrase'] as String?,
  pagingInfo: json['PagingInfo'] == null
      ? null
      : PagingInfo.fromJson(
          Map<String, dynamic>.from(json['PagingInfo'] as Map),
        ),
  orderInfo: (json['OrderInfo'] as List<dynamic>?)
      ?.map((e) => OrderInfo.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  filters: json['Filters'] == null
      ? null
      : Filters.fromJson(Map<String, dynamic>.from(json['Filters'] as Map)),
  showTags: json['ShowTags'] as bool?,
  showMode: (json['ShowMode'] as num?)?.toInt(),
  showBookmarked: json['ShowBookmarked'] as bool?,
  defaults: json['Defaults'] == null
      ? null
      : Defaults.fromJson(Map<String, dynamic>.from(json['Defaults'] as Map)),
);

Map<String, dynamic> _$BaseRequestToJson(BaseRequest instance) =>
    <String, dynamic>{
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
