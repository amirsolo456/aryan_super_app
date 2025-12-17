import 'package:flutter/material.dart';
import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Base/base_response.dart';
import 'package:models_package/Data/Com/Person/dto.dart';
import 'package:services_package/api_client_service.dart';
import 'package:services_package/api_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../../../../../core/network/injection_container.dart';
import '../../../../redux/generic_lists/erp_store/models/field_display_config.dart';
import '../../../../redux/generic_lists/erp_store/models/generic_list_entity_state.dart';

class Person extends ChangeNotifier {
  final int id;
  final String name;
  final String email;
  final String phone;
  final DateTime birthDate;
  final double salary;

  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.salary,
  });
}


final personFieldConfigs = <String, FieldDisplayConfig<Person>>{
  'id': FieldDisplayConfig<Person>(
    label: 'شناسه',
    valueGetter: (person) => person.id.toString(),
    width: 80,
    isSortable: true,
  ),
  'name': FieldDisplayConfig<Person>(
    label: 'نام',
    valueGetter: (person) => person.name,
    width: 150,
    isSortable: true,
  ),
  'email': FieldDisplayConfig<Person>(
    label: 'ایمیل',
    valueGetter: (person) => person.email,
    cellBuilder: (value) => InkWell(
      onTap: () => launch('mailto:$value'),
      child: Text(value, style: const TextStyle(color: Colors.blue)),
    ),
  ),
  'phone': FieldDisplayConfig<Person>(
    label: 'تلفن',
    valueGetter: (person) => person.phone,
    cellBuilder: (value) => Row(
      children: [
        const Icon(Icons.phone, size: 16),
        const SizedBox(width: 4),
        Text(value),
      ],
    ),
  ),
  'birthDate': FieldDisplayConfig<Person>(
    label: 'تاریخ تولد',
    valueGetter: (person) => '',
    isSortable: true,
  ),
  'salary': FieldDisplayConfig<Person>(
    label: 'حقوق',
    valueGetter: (person) => '',
    cellBuilder: (value) => Text(
      '$value تومان',
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
    ),
    isSortable: true,
  ),
};

class PersonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<
      GenericListEntityState<Response, ResponseData, Request>
    >(
      create: (context) =>
          GenericListEntityState<Response, ResponseData, Request>(
            totalCount: 0,
            request: Request(repoViewId: 0),
            loading: false,
            response: null,
            fields: [],
          ),
      child: Consumer<GenericListEntityState<BaseResponse<Person>, Person, BaseRequest>>(
        builder: (context, state, child) {
          // حالا می‌توانید state را به GenericEntityScreen پاس دهید.
          // اما GenericEntityScreen ما در نسخه‌ی جدید state را از طریق پارامتر نمی‌گیرد، بلکه از طریق Provider می‌گیرد.
          // بنابراین، باید GenericEntityScreen را طوری تغییر دهیم که state را از طریق Provider بگیرد.
          // من یک نسخه جدید از GenericEntityScreen می‌نویسم که state را از طریق Provider می‌خواند.
          // اما اگر می‌خواهید state را از بیرون بگیرد، می‌توانید آن را به عنوان پارامتر بفرستید.
          // من فرض می‌کنیم که می‌خواهید از Provider استفاده کنید و state را از Consumer بگیرید.
          // در این صورت، نیازی به پاس دادن state به GenericEntityScreen نیست.
          // بلکه در داخل GenericEntityScreen از Consumer یا Provider.of استفاده می‌کنیم.
          // اما از آنجایی که GenericEntityScreen جنریک است، کمی پیچیده می‌شود.
          // پیشنهاد من این است که یک کلاس جداگانه برای صفحه‌های خاص بسازید و از GenericEntityScreen استفاده نکنید.
          // اما اگر اصرار دارید، می‌توانید type parameterها را به GenericEntityScreen پاس دهید.
          // من یک راه ساده‌تر پیشنهاد می‌دهم: یک Widget به نام _GenericEntityScreenInternal بسازید که state را از طریق پارامتر بگیرد.
          // و در Consumer، آن را فراخوانی کنید.
          return _GenericEntityScreenInternal<Person>(
            state: state,
            fieldConfigs: personFieldConfigs,
          );
        },
      ),
    );
  }
}

class _GenericEntityScreenInternal<D> extends StatelessWidget {
  final GenericListEntityState state;
  final Map<String, FieldDisplayConfig<D>> fieldConfigs;

  const _GenericEntityScreenInternal({
    Key? key,
    required this.state,
    required this.fieldConfigs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // حالا می‌توانید از state استفاده کنید.
    // بقیه کدهای GenericEntityScreen را اینجا کپی کنید.
    // اما توجه: state از نوع GenericEntityState است و fetchData آن از نوع List<dynamic> است.
    // شما باید آن را به List<D> تبدیل کنید.
    List<D> data = state.fetchData as List<D>;

    // سپس با استفاده از data و fieldConfigs لیست را بسازید.
    // از آنجایی که کد طولانی است، من فقط ساختار کلی را می‌نویسم.
    return Scaffold(
      // appBar: AppBar(title: Text('/sadf')),
      body: Column(
        children: [
          // ... نوار آمار و ...
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                // اگر customItemBuilder وجود داشت، از آن استفاده کن.
                // در اینجا customItemBuilder را نداریم، پس با fieldConfigs نمایش می‌دهیم.
                final firstField = fieldConfigs.values.first;
                return ListTile(title: Text(firstField.valueGetter(item)));
              },
            ),
          ),
        ],
      ),
    );
  }
}
