import 'dart:io';

import 'package:erp_app/feature/com/person/data/model/person_list_model.dart';
import 'package:models_package/Data/Com/Person/dto.dart';
import 'package:services_package/com/person/person_service.dart';

class PersonServiceDataSource extends PersonService {
  PersonServiceDataSource(super.apiClient);

  Future<Response?> getAllPersons() async {
    return await super.get(Request(repoViewId: 1), (json) => Response.fromJson(json));
  }
}
