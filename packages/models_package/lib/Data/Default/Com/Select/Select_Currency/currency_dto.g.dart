// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyRequest _$CurrencyRequestFromJson(Map json) =>
    CurrencyRequest(
        repoViewId: (json['RepoViewId'] as num).toInt(),
        showMode: (json['ShowMode'] as num).toInt(),
      )
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
      ..showBookmarked = json['ShowBookmarked'] as bool?
      ..defaults = Defaults.fromJson(
        Map<String, dynamic>.from(json['Defaults'] as Map),
      );

Map<String, dynamic> _$CurrencyRequestToJson(CurrencyRequest instance) =>
    <String, dynamic>{
      'Url': instance.url,
      'Id': instance.id,
      'Ids': instance.ids,
      'FullSearchPhrase': instance.fullSearchPhrase,
      'PagingInfo': instance.pagingInfo.toJson(),
      'OrderInfo': instance.orderInfo.map((e) => e.toJson()).toList(),
      'Filters': instance.filters.toJson(),
      'ShowTags': instance.showTags,
      'ShowBookmarked': instance.showBookmarked,
      'Defaults': instance.defaults.toJson(),
      'RepoViewId': instance.repoViewId,
      'ShowMode': instance.showMode,
    };

CurrencyResponse _$CurrencyResponseFromJson(Map json) => CurrencyResponse(
  result: json['Result'] as String?,
  data: (json['Data'] as List<dynamic>?)
      ?.map((e) => ResponseData.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  error: json['Error'] as String?,
  totalCount: (json['TotalCount'] as num?)?.toInt(),
  additionalInfo: json['AdditionalInfo'] as String?,
  status: (json['Status'] as num?)?.toInt(),
  key: (json['Key'] as num?)?.toInt(),
  debugger: (json['Debugger'] as List<dynamic>)
      .map((e) => DebuggerModel.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  returnCount: (json['ReturnCount'] as num).toInt(),
);

Map<String, dynamic> _$CurrencyResponseToJson(CurrencyResponse instance) =>
    <String, dynamic>{
      'Result': instance.result,
      'Status': instance.status,
      'Data': instance.data?.map((e) => e.toJson()).toList(),
      'AdditionalInfo': instance.additionalInfo,
      'TotalCount': instance.totalCount,
      'Key': instance.key,
      'Debugger': instance.debugger.map((e) => e.toJson()).toList(),
      'ReturnCount': instance.returnCount,
    };

ResponseData _$ResponseDataFromJson(Map json) => ResponseData(
  selectId: (json['_SelectId'] as num).toInt(),
  selectValue: json['_SelectValue'] as String,
  selectDisplay: json['_SelectDisplay'] as String,
);

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      '_SelectId': instance.selectId,
      '_SelectValue': instance.selectValue,
      '_SelectDisplay': instance.selectDisplay,
    };
