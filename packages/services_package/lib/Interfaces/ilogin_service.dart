import 'package:models_package/Data/Auth/Login/dto.dart';



abstract class ILoginService {
  Future<LoginResponse?> login(LoginRequest loginRequest);
  Future<LoginResponseNextStep?> nextLogin(
    String cacheKey,
    ManagementAccounts management,
  );
}
