import 'dart:convert';

// Enums
enum Directions { bottom, top, left, right }

// Extension for Directions serialization
extension DirectionsExtension on Directions {
  String get value {
    switch (this) {
      case Directions.bottom:
        return 'bottom';
      case Directions.top:
        return 'top';
      case Directions.left:
        return 'left';
      case Directions.right:
        return 'right';
      default:
        return 'bottom';
    }
  }

  static Directions fromString(String value) {
    switch (value) {
      case 'bottom':
        return Directions.bottom;
      case 'top':
        return Directions.top;
      case 'left':
        return Directions.left;
      case 'right':
        return Directions.right;
      default:
        return Directions.bottom;
    }
  }
}

// Base classes
class BaseQueryRequest {
  BaseQueryRequest();

  Map<String, dynamic> toJson() => {};
}

class BaseResponse<T> {
  T? data;
  String? result;
  String? message;

  BaseResponse({this.data, this.result, this.message});
}

// Main models
class Request extends BaseQueryRequest {
  int repoId;
  int type;
  int systemId;

  Request({required this.repoId, required this.type, required this.systemId})
    : super();

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      repoId: json['RepoId'] as int,
      type: json['Type'] as int,
      systemId: json['SystemId'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'RepoId': repoId, 'Type': type, 'SystemId': systemId};
  }
}

class Response extends BaseResponse<ResponseData> {
  ResponseData toolbarData;

  Response({ResponseData? toolbarData})
    : toolbarData = toolbarData ?? ResponseData(),
      super(data: toolbarData ?? ResponseData());

  factory Response.fromJson(Map<String, dynamic> json) {
    return Response(toolbarData: ResponseData.fromJson(json['Data'] ?? {}));
  }

  @override
  Map<String, dynamic> toJson() {
    return {'Data': toolbarData.toJson()};
  }
}

class ResponseData {
  List<Item>? groupMenu;
  List<Item>? gridMenu;
  List<Item>? moreMenu;
  ToolbarList? list;

  ResponseData({this.groupMenu, this.gridMenu, this.moreMenu, this.list}) {
    groupMenu ??= <Item>[];
    gridMenu ??= <Item>[];
    moreMenu ??= <Item>[];
    list ??= ToolbarList();
  }

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      groupMenu: (json['GroupMenu'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e))
          .toList(),
      gridMenu: (json['GridMenu'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e))
          .toList(),
      moreMenu: (json['MoreMenu'] as List<dynamic>?)
          ?.map((e) => Item.fromJson(e))
          .toList(),
      list: json['List'] != null ? ToolbarList.fromJson(json['List']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GroupMenu': groupMenu?.map((e) => e.toJson()).toList(),
      'GridMenu': gridMenu?.map((e) => e.toJson()).toList(),
      'MoreMenu': moreMenu?.map((e) => e.toJson()).toList(),
      'List': list?.toJson(),
    };
  }
}

class Item {
  int? menuId;
  int? actionId;
  String? menuDesc;
  String? icon;
  String? iconUrl;
  int? type;

  Item({
    this.menuId,
    this.actionId,
    this.menuDesc,
    this.icon,
    this.iconUrl,
    this.type,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      menuId: json['MenuId'] as int?,
      actionId: json['ActionId'] as int?,
      menuDesc: json['MenuDesc'] as String?,
      icon: json['Icon'] as String?,
      iconUrl: json['IconUrl'] as String?,
      type: json['Type'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MenuId': menuId,
      'ActionId': actionId,
      'MenuDesc': menuDesc,
      'Icon': icon,
      'IconUrl': iconUrl,
      'Type': type,
    };
  }
}

class ToolbarList {
  String? config;
  List<View>? listProp;

  ToolbarList({this.config, this.listProp}) {
    listProp ??= <View>[];
  }

  List<RepoConfig> get repoConfig {
    if (config != null && config!.isNotEmpty) {
      try {
        final List<dynamic> jsonList = json.decode(config!);
        return jsonList.map((e) => RepoConfig.fromJson(e)).toList();
      } catch (e) {
        return <RepoConfig>[];
      }
    } else {
      return <RepoConfig>[];
    }
  }

  factory ToolbarList.fromJson(Map<String, dynamic> json) {
    return ToolbarList(
      config: json['Config'] as String?,
      listProp: (json['ListProp'] as List<dynamic>?)
          ?.map((e) => View.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Config': config,
      'ListProp': listProp?.map((e) => e.toJson()).toList(),
    };
  }
}

class RepoConfig {
  bool? inQuickFilter;
  ValueOption? valueOption;
  String? fieldName;
  String? fieldCaption;
  String? fieldType;
  bool? inFilter;
  bool? inSort;
  Directions direction;
  FilterOption? filterOption;
  String? value;

  RepoConfig({
    this.inQuickFilter,
    this.valueOption,
    this.fieldName,
    this.fieldCaption,
    this.fieldType,
    this.inFilter,
    this.inSort,
    this.direction = Directions.bottom,
    this.filterOption,
    this.value,
  });

  factory RepoConfig.fromJson(Map<String, dynamic> json) {
    return RepoConfig(
      inQuickFilter: json['inQuickFilter'] as bool?,
      valueOption: json['valueOption'] != null
          ? ValueOption.fromJson(json['valueOption'])
          : null,
      fieldName: json['FieldName'] as String?,
      fieldCaption: json['FieldCaption'] as String?,
      fieldType: json['FieldType'] as String?,
      inFilter: json['InFilter'] as bool?,
      inSort: json['InSort'] as bool?,
      direction: DirectionsExtension.fromString(json['Direction'] ?? 'Bottom'),
      filterOption: json['FilterOption'] != null
          ? FilterOption.fromJson(json['FilterOption'])
          : null,
      value: json['Value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'InQuickFilter': inQuickFilter,
      'ValueOption': valueOption?.toJson(),
      'FieldName': fieldName,
      'FieldCaption': fieldCaption,
      'FieldType': fieldType,
      'InFilter': inFilter,
      'InSort': inSort,
      'Direction': direction.value,
      'FilterOption': filterOption?.toJson(),
      'Value': value,
    };
  }

  RepoConfig clone() {
    return RepoConfig(
      fieldName: fieldName,
      value: value,
      fieldType: fieldType,
      direction: direction,
      inQuickFilter: inQuickFilter,
      valueOption: valueOption,
      fieldCaption: fieldCaption,
      inFilter: inFilter,
      inSort: inSort,
      filterOption: filterOption,
    );
  }
}

class ValueOption {
  String endpoint;
  int? repoViewId;
  String addAppUrl;
  String addWebUrl;
  List<Option> options;

  ValueOption({
    required this.endpoint,
    this.repoViewId,
    required this.addAppUrl,
    required this.addWebUrl,
    required this.options,
  });

  factory ValueOption.fromJson(Map<String, dynamic> json) {
    return ValueOption(
      endpoint: json['Endpoint'] as String,
      repoViewId: json['RepoViewId'] as int?,
      addAppUrl: json['AddAppUrl'] as String,
      addWebUrl: json['AddWebUrl'] as String,
      options: (json['Options'] as List<dynamic>)
          .map((e) => Option.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Endpoint': endpoint,
      'RepoViewId': repoViewId,
      'AddAppUrl': addAppUrl,
      'AddWebUrl': addWebUrl,
      'Options': options.map((e) => e.toJson()).toList(),
    };
  }
}

class Option {
  String caption;
  dynamic value;

  Option({required this.caption, required this.value});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(caption: json['Caption'] as String, value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {'Caption': caption, 'Value': value};
  }
}

class FilterOption {
  String? repoViewId;
  String? addAppUrl;
  String? addWebUrl;
  String? endpoint;

  FilterOption({
    this.repoViewId,
    this.addAppUrl,
    this.addWebUrl,
    this.endpoint,
  });

  factory FilterOption.fromJson(Map<String, dynamic> json) {
    return FilterOption(
      repoViewId: json['RepoViewId'] as String?,
      addAppUrl: json['AddAppUrl'] as String?,
      addWebUrl: json['AddWebUrl'] as String?,
      endpoint: json['Endpoint'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'RepoViewId': repoViewId,
      'AddAppUrl': addAppUrl,
      'AddWebUrl': addWebUrl,
      'Endpoint': endpoint,
    };
  }
}

class View {
  int? id;
  String? desc;
  String? config;
  String? type;

  View({this.id, this.desc, this.config, this.type});

  MyModel? get listConfig {
    if (type == "List") {
      if (config != null) {
        try {
          return MyModel.fromJson(json.decode(config!));
        } catch (e) {
          return MyModel();
        }
      } else {
        return MyModel();
      }
    } else {
      return null;
    }
  }

  ViewFormConfig? get formConfig {
    if (type == "Form") {
      if (config != null) {
        try {
          return ViewFormConfig.fromJson(json.decode(config!));
        } catch (e) {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  factory View.fromJson(Map<String, dynamic> json) {
    return View(
      id: json['Iid'] as int?,
      desc: json['Desc'] as String?,
      config: json['Config'] as String?,
      type: json['Type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'Id': id, 'Desc': desc, 'Config': config, 'Type': type};
  }
}

class ViewListConfig {
  String? fieldName;
  String? fieldType;
  String? fieldCaption;

  ViewListConfig({this.fieldName, this.fieldType, this.fieldCaption});

  factory ViewListConfig.fromJson(Map<String, dynamic> json) {
    return ViewListConfig(
      fieldName: json['FieldName'] as String?,
      fieldType: json['FieldType'] as String?,
      fieldCaption: json['FieldCaption'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'FieldName': fieldName,
      'FieldType': fieldType,
      'FieldCaption': fieldCaption,
    };
  }
}

class MyModel {
  List<ViewListConfig>? column;
  bool? isDefault;
  bool? isDisableAutoRefresh;
  bool? isDisableCommentCount;
  bool? isDisableSidebarStats;
  bool? isDisableCount;

  MyModel({
    this.column,
    this.isDefault = false,
    this.isDisableAutoRefresh = false,
    this.isDisableCommentCount = false,
    this.isDisableSidebarStats = false,
    this.isDisableCount = false,
  });

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      column: (json['Column'] as List<dynamic>?)
          ?.map((e) => ViewListConfig.fromJson(e))
          .toList(),
      isDefault: json['IsDefault'] as bool?,
      isDisableAutoRefresh: json['IsDisableAutoRefresh'] as bool?,
      isDisableCommentCount: json['IsDisableCommentCount'] as bool?,
      isDisableSidebarStats: json['IsDisableSidebarStats'] as bool?,
      isDisableCount: json['IsDisableCount'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Column': column?.map((e) => e.toJson()).toList(),
      'IsDefault': isDefault,
      'IsDisableAutoRefresh': isDisableAutoRefresh,
      'IsDisableCommentCount': isDisableCommentCount,
      'IsDisableSidebarStats': isDisableSidebarStats,
      'IsDisableCount': isDisableCount,
    };
  }
}

class ViewFormConfig {
  String? addEndpoint;
  String? editEndpoint;
  String? deleteEndpoint;
  String? formIdField;
  List<Field> fields;

  ViewFormConfig({
    this.addEndpoint,
    this.editEndpoint,
    this.deleteEndpoint,
    this.formIdField,
    required this.fields,
  });

  factory ViewFormConfig.fromJson(Map<String, dynamic> json) {
    return ViewFormConfig(
      addEndpoint: json['AddEndpoint'] as String?,
      editEndpoint: json['EditEndpoint'] as String?,
      deleteEndpoint: json['DeleteEndpoint'] as String?,
      formIdField: json['FormIdField'] as String?,
      fields: (json['Fields'] as List<dynamic>)
          .map((e) => Field.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AddEndpoint': addEndpoint,
      'EditEndpoint': editEndpoint,
      'DeleteEndpoint': deleteEndpoint,
      'FormIdField': formIdField,
      'Fields': fields.map((e) => e.toJson()).toList(),
    };
  }
}

class Field {
  String? caption;
  String? name;
  String? help;
  String? type;
  String? placeHolder;
  dynamic defaultValue;
  bool showId;
  List<RadioValues> radioValues;
  int? order;
  SelectEndpoint? selectEndpoint;
  List<Select> options;
  List<Rule> rules;
  String? icon;
  int idValue;

  Field({
    this.caption,
    this.name,
    this.help,
    this.type,
    this.placeHolder,
    this.defaultValue,
    this.showId = false,
    required this.radioValues,
    this.order,
    this.selectEndpoint,
    required this.options,
    required this.rules,
    this.icon,
    this.idValue = 0,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      caption: json['Caption'] as String?,
      name: json['Name'] as String?,
      help: json['Help'] as String?,
      type: json['Type'] as String?,
      placeHolder: json['PlaceHolder'] as String?,
      defaultValue: json['DefaultValue'],
      showId: json['ShowId'] as bool? ?? false,
      radioValues: (json['RadioValues'] as List<dynamic>)
          .map((e) => RadioValues.fromJson(e))
          .toList(),
      order: json['Order'] as int?,
      selectEndpoint: json['SelectEndpoint'] != null
          ? SelectEndpoint.fromJson(json['SelectEndpoint'])
          : null,
      options: (json['Options'] as List<dynamic>)
          .map((e) => Select.fromJson(e))
          .toList(),
      rules: (json['Rules'] as List<dynamic>)
          .map((e) => Rule.fromJson(e))
          .toList(),
      icon: json['Icon'] as String?,
      idValue: json['IdValue'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Caption': caption,
      'Name': name,
      'Help': help,
      'Type': type,
      'PlaceHolder': placeHolder,
      'DefaultValue': defaultValue,
      'ShowId': showId,
      'RadioValues': radioValues.map((e) => e.toJson()).toList(),
      'Order': order,
      'SelectEndpoint': selectEndpoint?.toJson(),
      'Options': options.map((e) => e.toJson()).toList(),
      'Rules': rules.map((e) => e.toJson()).toList(),
      'Icon': icon,
      'IdValue': idValue,
    };
  }
}

class RadioValues {
  String caption;
  bool value;

  RadioValues({required this.caption, required this.value});

  factory RadioValues.fromJson(Map<String, dynamic> json) {
    return RadioValues(
      caption: json['Caption'] as String,
      value: json['Value'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'Caption': caption, 'Value': value};
  }
}

class SelectEndpoint {
  String? repoViewId;
  String? addAppUrl;
  String? addWebUrl;
  String? endpoint;

  SelectEndpoint({
    this.repoViewId,
    this.addAppUrl,
    this.addWebUrl,
    this.endpoint,
  });

  factory SelectEndpoint.fromJson(Map<String, dynamic> json) {
    return SelectEndpoint(
      repoViewId: json['RepoViewId'] as String?,
      addAppUrl: json['AddAppUrl'] as String?,
      addWebUrl: json['AddWebUrl'] as String?,
      endpoint: json['Endpoint'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'RepoViewId': repoViewId,
      'AddAppUrl': addAppUrl,
      'AddWebUrl': addWebUrl,
      'Endpoint': endpoint,
    };
  }
}

class Select {
  String caption;
  dynamic value;

  Select({required this.caption, required this.value});

  factory Select.fromJson(Map<String, dynamic> json) {
    return Select(caption: json['Caption'] as String, value: json['Value']);
  }

  Map<String, dynamic> toJson() {
    return {'Caption': caption, 'Value': value};
  }
}

class Rule {
  String? name;
  String? condition;
  String? message;
  bool required;
  String type;
  int len;

  Rule({
    this.name,
    this.condition,
    this.message,
    this.required = false,
    this.type = '',
    this.len = 0,
  });

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      name: json['Name'] as String?,
      condition: json['Condition'] as String?,
      message: json['Message'] as String?,
      required: json['Required'] as bool? ?? false,
      type: json['Type'] as String? ?? '',
      len: json['Len'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Condition': condition,
      'Message': message,
      'Required': required,
      'Type': type,
      'Len': len,
    };
  }
}
