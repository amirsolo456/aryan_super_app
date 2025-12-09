
import 'package:models_package/Data/Auth/User/dto.dart';
abstract class IUserExistService {
  Future<Response?> CheckIfExist(Request request);
}
