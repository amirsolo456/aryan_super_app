import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

// Enums
enum Directions { bottom, top, left, right }

// Base classes (you need to implement these based on your C# base classes)
class BaseQueryRequest {
  // Implement based on your C# BaseQueryRequest
}

class BaseResponse<T> {
  // Implement based on your C# BaseResponse<T>
}

// Main models
@JsonSerializable()
class Request extends BaseQueryRequest {
  int repoId;
  int type;
  int systemId;

  Request({required this.repoId, required this.type, required this.systemId});
}

@JsonSerializable()
class Response extends BaseResponse<ResponseData> {
  @JsonKey(name: 'Data')
  ResponseData toolbarData;

  Response() : toolbarData = ResponseData();
}

@JsonSerializable()
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
}

@JsonSerializable()
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
}

@JsonSerializable()
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
}

@JsonSerializable()
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
      inQuickFilter: json['inQuickFilter'] ?? null as bool?,
      valueOption: json['valueOption'] ?? null as ValueOption?,
      fieldName: json['fieldName'] as String?,
      fieldCaption: json['fieldCaption'] ?? null as String?,
      fieldType: json['fieldType'] ?? null as String?,
      inFilter: json['inFilter'] ?? null as bool?,
      inSort: json['inSort'] ?? null as bool?,
      direction: json['direction'] ?? null as Directions?,
      filterOption: json['filterOption'] ?? null as FilterOption?,
      value: json['value'] ?? null as String?,
    );
  }

  RepoConfig clone() {
    return RepoConfig(fieldName: fieldName, value: value, fieldType: fieldType);
  }
}

@JsonSerializable()
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
}

@JsonSerializable()
class Option {
  String caption;
  dynamic value;

  Option({required this.caption, required this.value});
}

@JsonSerializable()
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
}

@JsonSerializable()
class View {
  int? id;
  String? desc;
  String? config;
  String? type;

  View({this.id, this.desc, this.config, this.type});

  MyModel? get listConfig {
    if (type == "list") {
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
    if (type == "form") {
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
}

@JsonSerializable()
class ViewListConfig {
  String? fieldName;
  String? fieldType;
  String? fieldCaption;

  ViewListConfig({this.fieldName, this.fieldType, this.fieldCaption});
}

@JsonSerializable()
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
      column: json['column'] ?? null as List<ViewListConfig>?,
      isDefault: json['isDefault'] ?? null as bool?,
      isDisableAutoRefresh: json['isDisableAutoRefresh'] as bool?,
      isDisableCommentCount: json['isDisableCommentCount'] ?? null as bool?,
      isDisableSidebarStats: json['isDisableSidebarStats'] ?? null as bool?,
      isDisableCount: json['isDisableCount'] ?? null as bool?,
    );
  }
}

@JsonSerializable()
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
      addEndpoint: json['addEndpoint'] as String?,
      editEndpoint: json['editEndpoint'] as String?,
      deleteEndpoint: json['deleteEndpoint'] as String?,
      formIdField: json['formIdField'] as String?,
      fields: json['fields'] as List<Field>,
    );
  }
}

@JsonSerializable()
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
}

@JsonSerializable()
class RadioValues {
  String caption;
  bool value;

  RadioValues({required this.caption, required this.value});
}

@JsonSerializable()
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
}

@JsonSerializable()
class Select {
  String caption;
  dynamic value;

  Select({required this.caption, required this.value});
}

@JsonSerializable()
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
      name: json['name'] as String?,
      condition: json['condition'] as String?,
      message: json['message'] as String?,
      required: json['required'] as bool,
      type: json['type'] as String,
      len: json['len'] as int,
    );
  }
}
