import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Base/login_module.dart';

abstract class ISqliteStorageDataSource {
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

  Future<LoginModuleResult> sqlLoadLoginSessionModel();
  Future<void> sqlSaveLoginSessionModel(LoginModuleResult loginSessionModel);
  Future<void> sqlRemoveLoginSessionModel();

  Future<String?> getSqliteDbPath();
}
