import 'package:models_package/Data/Com/Person/dto.dart';

class PersonRepository {
  Future<Response> getAllUsers() async {
    await Future.delayed(const Duration(seconds: 2));
    return Response(
      data: [ResponseData(displayName: "", birthDate: "sfaf")],
    );
  }

  Future<Response> searchUsers(Request params) async {
    return await getAllUsers();
  }
}
