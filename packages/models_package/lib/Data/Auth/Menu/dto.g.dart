// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map json) =>
    Request(menuType: (json['MenuType'] as num).toInt())
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
  'MenuType': instance.menuType,
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
  'Error': instance.error,
  'Data': instance.data?.map((e) => e.toJson()).toList(),
  'AdditionalInfo': instance.additionalInfo,
  'TotalCount': instance.totalCount,
  'Key': instance.key,
};

ResponseData _$ResponseDataFromJson(Map json) => ResponseData(
  menuId: (json['MenuId'] as num?)?.toInt(),
  actionType: (json['ActionType'] as num?)?.toInt(),
  fatherId: (json['FatherId'] as num?)?.toInt(),
  menuType: (json['MenuType'] as num?)?.toInt(),
  menuDesc: json['MenuDesc'] as String?,
  appLink: json['AppLink'] as String?,
  webLink: json['WebLink'] as String?,
  actionId: (json['ActionId'] as num?)?.toInt(),
  repoId: (json['RepoId'] as num?)?.toInt(),
  icon: json['Icon'] as String?,
  iconUrl: json['IconUrl'] as String?,
  subMenus: (json['SubMenus'] as List<dynamic>?)
      ?.map((e) => ResponseData.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  isSelected: json['IsSelected'] as bool? ?? false,
);

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'MenuId': instance.menuId,
      'MenuDesc': instance.menuDesc,
      'AppLink': instance.appLink,
      'ActionType': instance.actionType,
      'FatherId': instance.fatherId,
      'MenuType': instance.menuType,
      'WebLink': instance.webLink,
      'ActionId': instance.actionId,
      'RepoId': instance.repoId,
      'Icon': instance.icon,
      'IconUrl': instance.iconUrl,
      'SubMenus': instance.subMenus.map((e) => e.toJson()).toList(),
      'IsSelected': instance.isSelected,
    };
