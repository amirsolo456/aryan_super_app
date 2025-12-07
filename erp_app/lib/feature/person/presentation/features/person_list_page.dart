import 'package:erp_app/feature/person/domain/repositories/person_repository.dart';
import 'package:erp_app/feature/person/presentation/blocs/person_bloc/person_list_bloc.dart';
import 'package:erp_app/feature/person/presentation/blocs/search_person_bloc/search_person_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models_package/Data/Com/Person/dto.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Buttons/absoluted_button.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Expanders/list_datas_expander.dart';
import '../../../../core/list_generic/presentation/features/generic_page.dart';

class PersonListPage extends StatefulWidget {
  final bool refreshData;

  const PersonListPage({super.key, required this.refreshData});

  @override
  State<PersonListPage> createState() => _PersonListPageState();
}

final Widget addIcon = Image.asset(
  'assets/images/add.png',
  package: 'resources_package',
  width: 44,
  height: 44,
);

class _PersonListPageState extends State<PersonListPage> {
  @override
  void initState() {
    super.initState();
    if (widget.refreshData) {
      context.read<PersonListBloc>().add(PersonListInitialEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GenericPage<SearchPersonBloc, Response, ResponseData, Request>(
      createBloc: () => SearchPersonBloc(PersonRepository()),
      autoLoad: true,
      builder: (context, state, bloc) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Users'),
                actions: [
            IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => state.props,
        ),
        ],
        ),
        body: Scaffold(
        body: Stack(
        children: [
        Padding(
        padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
        ),
        child: ListView.builder(
            itemCount: state.props.length,
          itemBuilder: (context, index) {
            return PersonExpander(person: state.props[index]);
          },
        ),
        ),
        AbsoultNewButton(),
        ],
        ),
        ),
        );
      },
    );
  }
}
