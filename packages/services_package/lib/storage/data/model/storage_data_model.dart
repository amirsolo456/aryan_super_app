import 'package:json_annotation/json_annotation.dart';
import 'package:services_package/storage/data/model/secure_storage_data_model.dart';
import 'package:services_package/storage/data/model/shared_storage_data_model.dart';
import 'package:services_package/storage/data/model/sqlite_storage_data_model.dart';

@JsonSerializable()
class StorageDataModel {
  final SecureStorageDataModel? secureModel;
  final SqliteStorageDataModel? sqlLiteModel;
  final SharedStorageDataModel? sharedStorageModel;

  const StorageDataModel({
    this.secureModel,
    this.sqlLiteModel,
    this.sharedStorageModel,
  });
}
