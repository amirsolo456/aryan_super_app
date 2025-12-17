// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map json) =>
    Request(repoViewId: (json['RepoViewId'] as num).toInt())
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
  'Data': instance.data?.map((e) => e.toJson()).toList(),
  'AdditionalInfo': instance.additionalInfo,
  'TotalCount': instance.totalCount,
  'Key': instance.key,
};

ResponseData _$ResponseDataFromJson(Map json) => ResponseData(
  personId: (json['ID'] as num?)?.toInt(),
  firstName: json['FirstName'] as String?,
  lastName: json['LastName'] as String?,
  fullName: json['FullName'] as String?,
  isForeign: json['IsForeign'] as bool?,
  fatherName: json['FatherName'] as String?,
  nationalCode: json['NationalCode'] as String?,
  economicCode: json['EconomicCode'] as String?,
  identityNumber: json['IdentityNumber'] as String?,
  birthDate: json['BirthDate'] as String?,
  isSelected: json['IsSelected'] as bool? ?? false,
  displayName: json['DisplayName'] as String?,
  placeId: (json['PlaceId'] as num?)?.toInt(),
  tagsInfo: (json['TagsInfo'] as List<dynamic>?)
      ?.map((e) => TagData.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList(),
  hasBookMark: json['HasBookMark'] as bool? ?? false,
  pendingStatusId: (json['pendingStatus'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'ID': instance.personId,
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'FullName': instance.fullName,
      'IsForeign': instance.isForeign,
      'FatherName': instance.fatherName,
      'NationalCode': instance.nationalCode,
      'EconomicCode': instance.economicCode,
      'IdentityNumber': instance.identityNumber,
      'BirthDate': instance.birthDate,
      'IsSelected': instance.isSelected,
      'DisplayName': instance.displayName,
      'PlaceId': instance.placeId,
      'TagsInfo': instance.tagsInfo.map((e) => e.toJson()).toList(),
      'HasBookMark': instance.hasBookMark,
      'pendingStatus': instance.pendingStatusId,
    };
