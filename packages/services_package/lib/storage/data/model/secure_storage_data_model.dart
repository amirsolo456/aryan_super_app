import 'package:json_annotation/json_annotation.dart';
import 'package:models_package/Data/Auth/User/dto.dart';

@JsonSerializable()
class SecureStorageDataModel {
  final int Id;
  final UserDto user;
  final String token;

  const SecureStorageDataModel({
    required this.Id,
    required this.token,
    required this.user,
  });
}
