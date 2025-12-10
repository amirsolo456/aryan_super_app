import 'package:json_annotation/json_annotation.dart';
import 'package:models_package/Base/base_request.dart';

@JsonSerializable()
class SqliteStorageDataModel {
  final Filters? filters;
  final FilterInfo? filterInfos;
  final OrderInfo? sortOrder;
  final PagingInfo? pagingInfo;
  final Defaults? defaults;
  final int Id;

  const SqliteStorageDataModel({
    required this.Id,
    this.filters,
    this.filterInfos,
    this.sortOrder,
    this.pagingInfo,
    this.defaults,
  });
}
