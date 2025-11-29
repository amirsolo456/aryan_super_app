import 'package:models_package/Data/Auth/Otp/dto.dart';
import 'Interfaces/iotp_service.dart';
import 'api_client_service.dart';

final String _sendOtpUrl = 'api/auth/select/user/sendotp';

class OtpService implements IOtpService {
  final ApiClient apiClient;

  OtpService(this.apiClient);

  @override
  Future<Response?> sendOtp(Request request) async {
    try {
      final response = await apiClient
          .sendObjectRequestAsync<Response, ResponseData>(
            _sendOtpUrl,
            HttpMethods.post,
            request.toJson(),
            false,
            Exception('a'),
          );
      return response;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Response?> validateOtp(Request request) async {
    try {
      final response = await apiClient
          .sendObjectRequestAsync<Response, ResponseData>(
            _sendOtpUrl,
            HttpMethods.post,
            request,
            false,
            Exception('a'),
          );
      return response;
    } catch (e) {
      return null;
    }
  }
}
