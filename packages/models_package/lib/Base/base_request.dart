import 'package:json_annotation/json_annotation.dart';

part 'base_request.g.dart';

@JsonSerializable()
class BaseRequest {
  String url;
  int? id;
  int? repoViewId;
  List<int>? ids;
  String? fullSearchPhrase;
  PagingInfo pagingInfo;
  List<OrderInfo> orderInfo;
  Filters filters;
  bool? showTags;
  int? showMode;
  bool? showBookmarked;
  Defaults defaults;

  BaseRequest({
    this.url = '',
    this.id,
    this.repoViewId,
    this.ids,
    this.fullSearchPhrase,
    PagingInfo? pagingInfo,
    List<OrderInfo>? orderInfo,
    Filters? filters,
    this.showTags,
    this.showMode,
    this.showBookmarked,
    Defaults? defaults,
  }) : pagingInfo = pagingInfo ?? PagingInfo(),
       orderInfo = orderInfo ?? [],
       filters = filters ?? Filters(),
       defaults = defaults ?? Defaults();

  factory BaseRequest.fromJson(Map<String, dynamic> json) =>
      _$BaseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BaseRequestToJson(this);
  /* factory BaseRequest.fromJson(Map<String, dynamic> json) {
    return BaseRequest(
      url: json['Url'] ?? '',
      id: json['Id'],
      repoViewId: json['RepoViewId'],
      ids: json['Ids'] != null ? List<int>.from(json['Ids']) : null,
      fullSearchPhrase: json['FullSearchPhrase'],
      pagingInfo: json['PagingInfo'] != null
          ? PagingInfo.fromJson(json['PagingInfo'])
          : null,
      orderInfo: json['OrderInfo'] != null
          ? (json['OrderInfo'] as List)
                .map((e) => OrderInfo.fromJson(e))
                .toList()
          : null,
      filters: json['Filters'] != null
          ? Filters.fromJson(json['Filters'])
          : null,
      showTags: json['ShowTags'],
      showMode: json['ShowMode'],
      showBookmarked: json['ShowBookmarked'],
      defaults: json['Defaults'] != null
          ? Defaults.fromJson(json['Defaults'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Url': url,
      if (id != null) 'Id': id,
      if (repoViewId != null) 'RepoViewId': repoViewId,
      if (ids != null) 'Ids': ids,
      if (fullSearchPhrase != null) 'FullSearchPhrase': fullSearchPhrase,
      'PagingInfo': pagingInfo.toJson(),
      'OrderInfo': orderInfo.map((e) => e.toJson()).toList(),
      'Filters': filters.toJson(),
      if (showTags != null) 'ShowTags': showTags,
      if (showMode != null) 'ShowMode': showMode,
      if (showBookmarked != null) 'ShowBookmarked': showBookmarked,
      'Defaults': defaults.toJson(),
    };
  }
*/
  /*  Map<String, dynamic> tojson() {
    return {
      'Url': url,
      if (id != null) 'Id': id,
      if (repoViewId != null) 'RepoViewId': repoViewId,
      if (ids != null) 'Ids': ids,
      if (fullSearchPhrase != null) 'FullSearchPhrase': fullSearchPhrase,
      'PagingInfo': pagingInfo.toJson(),
      'OrderInfo': orderInfo.map((e) => e.toJson()).toList(),
      'Filters': filters.toJson(),
      if (showTags != null) 'ShowTags': showTags,
      if (showMode != null) 'ShowMode': showMode,
      if (showBookmarked != null) 'ShowBookmarked': showBookmarked,
      'Defaults': defaults.toJson(),
    };
  }*/
}

class Defaults {
  int currencyId;
  int cashierId;
  int placeId;
  int yearId;
  int languageId;
  int managementAccountId;

  Defaults({
    this.currencyId = 0,
    this.cashierId = 0,
    this.placeId = 0,
    this.yearId = 0,
    this.languageId = 0,
    this.managementAccountId = 0,
  });

  factory Defaults.fromJson(Map<String, dynamic> json) {
    return Defaults(
      currencyId: json['CurrencyId'] ?? 0,
      managementAccountId: json['ManagementAccountId'] ?? 0,
      cashierId: json['CashierId'] ?? 0,
      placeId: json['PlaceId'] ?? 0,
      yearId: json['YearId'] ?? 0,
      languageId: json['LanguageId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CurrencyId': currencyId,
      'ManagementAccountId': managementAccountId,
      'CashierId': cashierId,
      'PlaceId': placeId,
      'YearId': yearId,
      'LanguageId': languageId,
    };
  }
}

class BaseActionsQueryRequest {
  int? repoViewId;
  PagingInfo? pagingInfo;
  List<OrderInfo>? orderInfo;
  Filters? filters;

  BaseActionsQueryRequest({
    this.repoViewId,
    this.pagingInfo,
    this.orderInfo,
    this.filters,
  });
}

class PagingInfo {
  bool onlyTotalCount;
  int? pageRecordCount;
  int? pageNumber;
  int? startIndex;
  bool? withTotalCount;
  int? totalRowCount; // NotMapped in C#

  PagingInfo({
    this.onlyTotalCount = false,
    this.pageRecordCount = 11,
    this.pageNumber = 1,
    this.startIndex,
    this.withTotalCount = true,
    this.totalRowCount,
  });

  factory PagingInfo.fromJson(Map<String, dynamic> json) {
    return PagingInfo(
      onlyTotalCount: json['OnlyTotalCount'] ?? false,
      pageRecordCount: json['PageRecordCount'] ?? 11,
      pageNumber: json['PageNumber'] ?? 1,
      startIndex: json['StartIndex'],
      withTotalCount: json['WithTotalCount'] ?? true,
      totalRowCount: json['TotalRowCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'OnlyTotalCount': onlyTotalCount,
      'PageRecordCount': pageRecordCount,
      'PageNumber': pageNumber,
      'StartIndex': startIndex,
      'WithTotalCount': withTotalCount,
      'TotalRowCount': totalRowCount,
    };
  }
}

class OrderInfo {
  String? colName;
  bool? asc;

  OrderInfo({this.colName, this.asc});

  factory OrderInfo.fromJson(Map<String, dynamic> json) {
    return OrderInfo(colName: json['ColName'], asc: json['Asc']);
  }

  Map<String, dynamic> toJson() {
    return {
      if (colName != null) 'ColName': colName,
      if (asc != null) 'Asc': asc,
    };
  }
}

class Filters {
  List<FilterInfo?> filterInfo;
  bool? showOnlyBookmarked;
  List<int>? tagIdsFilter;

  Filters({
    List<FilterInfo?>? filterInfo,
    this.showOnlyBookmarked = false,
    this.tagIdsFilter,
  }) : filterInfo = filterInfo ?? [];

  factory Filters.fromJson(Map<String, dynamic> json) {
    return Filters(
      filterInfo: json['FilterInfo'] != null
          ? (json['FilterInfo'] as List)
                .map((e) => e != null ? FilterInfo.fromJson(e) : null)
                .toList()
          : [],
      showOnlyBookmarked: json['ShowOnlyBookmarked'] ?? false,
      tagIdsFilter: json['TagIdsFilter'] != null
          ? List<int>.from(json['TagIdsFilter'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FilterInfo': filterInfo.map((e) => e?.toJson()).toList(),
      'ShowOnlyBookmarked': showOnlyBookmarked,
      if (tagIdsFilter != null) 'TagIdsFilter': tagIdsFilter,
    };
  }
}

class FilterInfo {
  String? colName;
  String? filterType;
  String? value;

  FilterInfo({this.colName, this.filterType, this.value});

  factory FilterInfo.fromJson(Map<String, dynamic> json) {
    return FilterInfo(
      colName: json['ColName'],
      filterType: json['FilterType'],
      value: json['Value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (colName != null) 'ColName': colName,
      if (filterType != null) 'FilterType': filterType,
      if (value != null) 'Value': value,
    };
  }
}
