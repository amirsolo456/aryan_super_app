import 'package:erp_app/feature/person/person_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Buttons/absoluted_button.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Expanders/list_datas_expander.dart';

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
    return BlocBuilder<PersonListBloc, PersonListState>(
      builder: (context, state) {
        if (state is PersonListInitialState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LoadDataSource) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: ListView.builder(
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return PersonExpander(person: state.data[index]);
                  },
                ),
              ),
              AbsoultNewButton(),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
