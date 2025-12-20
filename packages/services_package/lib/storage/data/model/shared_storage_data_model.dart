import 'package:json_annotation/json_annotation.dart';
import 'package:models_package/Base/language.dart';

@JsonSerializable()
class SharedStorageDataModel {
  final int Id;
  final Language? language;
  final String? deviceToken;

  const SharedStorageDataModel({
    required this.Id,
    this.language,
    this.deviceToken,
  });
}
