export '../../../../redux/generic_lists/ui/generic_list_page.dart';
/*
 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Buttons/absoluted_button.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Expanders/list_datas_expander.dart';

import '../../../../../core/list_generic/presentation/blocs/generic_cubit.dart';
import '../blocs/search_person_bloc/search_person_bloc.dart';

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

// PersonListPage با BlocBuilder مستقیم
class _PersonListPageState extends State<PersonListPage> {
  @override
  void initState() {
    super.initState();

    setState(() {

     });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchPersonBloc, GenericState>(
      bloc: GetIt.instance<SearchPersonBloc>(),
      builder: (context, state) {
        return Scaffold(
          // appBar: AppBar(
          //   title: const Text('Users'),
          //   actions: [
          //     IconButton(
          //       icon: const Icon(Icons.refresh),
          //       onPressed: () {
          //         GetIt.instance<SearchPersonBloc>().loadData();
          //       },
          //     ),
          //   ],
          // ),
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: state.props.isNotEmpty
                    ? ListView.builder(
                        itemCount: state.props.length,
                        itemBuilder: (context, index) {
                          return PersonExpander(person: state.props[index]);
                        },
                      )
                    : const Center(child: Text('No data found')),
              ),
              const AbsoultNewButton(),
            ],
          ),
        );
      },
    );
  }
}
*/
