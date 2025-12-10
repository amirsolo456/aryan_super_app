import 'package:models_package/Base/base_request.dart';
import 'package:services_package/storage/data/datasource/storage_datasource.dart';

abstract class ISqliteStorageDataSource extends StorageDatasource {
  Future<Filters> loadFilters();
  Future<void> saveFilters(Filters filters);
  Future<void> removeFilters();

  Future<FilterInfo> loadFilterInfo();
  Future<void> saveFilterInfo(FilterInfo filterInfos);
  Future<void> removeFilterInfo();

  Future<OrderInfo> loadOrderInfo();
  Future<void> saveOrderInfo(OrderInfo filters);
  Future<void> removeOrderInfo();

  Future<PagingInfo> loadPagingInfo();
  Future<void> savePagingInfo(PagingInfo pagingInfo);
  Future<void> removePagingInfo();

  Future<Defaults> loadDefaults();
  Future<void> saveDefaults(Defaults defaults);
  Future<void> removeDefaults();
}
