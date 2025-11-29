import 'package:models_package/Data/Auth/Menu/dto.dart';

abstract class IMenuService {
  Future<Response?> getMenu(Request request);
}
