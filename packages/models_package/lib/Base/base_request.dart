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

  factory BaseRequest.fromJson(Map<String, dynamic> json) {
    return BaseRequest(
      url: json['url'] ?? '',
      id: json['id'],
      repoViewId: json['repoViewId'],
      ids: json['ids'] != null ? List<int>.from(json['ids']) : null,
      fullSearchPhrase: json['fullSearchPhrase'],
      pagingInfo: json['pagingInfo'] != null
          ? PagingInfo.fromJson(json['pagingInfo'])
          : null,
      orderInfo: json['orderInfo'] != null
          ? (json['orderInfo'] as List)
                .map((e) => OrderInfo.fromJson(e))
                .toList()
          : null,
      filters: json['filters'] != null
          ? Filters.fromJson(json['filters'])
          : null,
      showTags: json['showTags'],
      showMode: json['showMode'],
      showBookmarked: json['showBookmarked'],
      defaults: json['defaults'] != null
          ? Defaults.fromJson(json['defaults'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      if (id != null) 'id': id,
      if (repoViewId != null) 'repoViewId': repoViewId,
      if (ids != null) 'ids': ids,
      if (fullSearchPhrase != null) 'fullSearchPhrase': fullSearchPhrase,
      'pagingInfo': pagingInfo.toJson(),
      'orderInfo': orderInfo.map((e) => e.toJson()).toList(),
      'filters': filters.toJson(),
      if (showTags != null) 'showTags': showTags,
      if (showMode != null) 'showMode': showMode,
      if (showBookmarked != null) 'showBookmarked': showBookmarked,
      'defaults': defaults.toJson(),
    };
  }

  Map<String,dynamic> tojson() {
    return {
      'url': url,
      if (id != null) 'id': id,
      if (repoViewId != null) 'repoViewId': repoViewId,
      if (ids != null) 'ids': ids,
      if (fullSearchPhrase != null) 'fullSearchPhrase': fullSearchPhrase,
      'pagingInfo': pagingInfo.toJson(),
      'orderInfo': orderInfo.map((e) => e.toJson()).toList(),
      'filters': filters.toJson(),
      if (showTags != null) 'showTags': showTags,
      if (showMode != null) 'showMode': showMode,
      if (showBookmarked != null) 'showBookmarked': showBookmarked,
      'defaults': defaults.toJson(),
    };
  }
}

class Defaults {
  int currencyId;
  int cashierId;
  int placeId;
  int yearId;
  int languageId;

  Defaults({
    this.currencyId = 0,
    this.cashierId = 0,
    this.placeId = 0,
    this.yearId = 0,
    this.languageId = 0,
  });

  factory Defaults.fromJson(Map<String, dynamic> json) {
    return Defaults(
      currencyId: json['currencyId'] ?? 0,
      cashierId: json['cashierId'] ?? 0,
      placeId: json['placeId'] ?? 0,
      yearId: json['yearId'] ?? 0,
      languageId: json['languageId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currencyId': currencyId,
      'cashierId': cashierId,
      'placeId': placeId,
      'yearId': yearId,
      'languageId': languageId,
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
      onlyTotalCount: json['onlyTotalCount'] ?? false,
      pageRecordCount: json['pageRecordCount'] ?? 11,
      pageNumber: json['pageNumber'] ?? 1,
      startIndex: json['startIndex'],
      withTotalCount: json['withTotalCount'] ?? true,
      totalRowCount: json['totalRowCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'onlyTotalCount': onlyTotalCount,
      'pageRecordCount': pageRecordCount,
      'pageNumber': pageNumber,
      'startIndex': startIndex,
      'withTotalCount': withTotalCount,
      'totalRowCount': totalRowCount,
    };
  }
}

class OrderInfo {
  String? colName;
  bool? asc;

  OrderInfo({this.colName, this.asc});

  factory OrderInfo.fromJson(Map<String, dynamic> json) {
    return OrderInfo(colName: json['colName'], asc: json['asc']);
  }

  Map<String, dynamic> toJson() {
    return {
      if (colName != null) 'colName': colName,
      if (asc != null) 'asc': asc,
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
      filterInfo: json['filterInfo'] != null
          ? (json['filterInfo'] as List)
                .map((e) => e != null ? FilterInfo.fromJson(e) : null)
                .toList()
          : [],
      showOnlyBookmarked: json['showOnlyBookmarked'] ?? false,
      tagIdsFilter: json['tagIdsFilter'] != null
          ? List<int>.from(json['tagIdsFilter'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filterInfo': filterInfo.map((e) => e?.toJson()).toList(),
      'showOnlyBookmarked': showOnlyBookmarked,
      if (tagIdsFilter != null) 'tagIdsFilter': tagIdsFilter,
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
      colName: json['colName'],
      filterType: json['filterType'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (colName != null) 'colName': colName,
      if (filterType != null) 'filterType': filterType,
      if (value != null) 'value': value,
    };
  }
}
