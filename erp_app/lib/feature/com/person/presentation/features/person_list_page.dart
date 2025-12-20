import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:models_package/Base/enums.dart';
import 'package:models_package/Data/Com/Person/dto.dart' as person;
import 'package:services_package/Repo_ViewId/repo_view_id.dart';
import 'package:services_package/com/person/person_service.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Components/list_pagination.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Expanders/list_datas_expander.dart';
import 'package:ui_components_package/erp_app_componenets/mobile/Headers/list_head_actionbar.dart';
import '../../../../../page_cache_provider.dart';
import '../../../../navigation_button/presentation/bloc/navigation_notifier.dart';
import '../../../../navigation_button/presentation/widget/app_navigation_button.dart';
import '../../../../redux/generic_lists/erp_store/models/field_display_config.dart';
import '../../../../redux/generic_lists/erp_store/models/generic_list_entity_state.dart';
import '../../../../redux/generic_lists/ui/generic_list_page.dart';
import 'package:provider/provider.dart';

class PersonListPage extends StatefulWidget {
  final bool refreshData;

  const PersonListPage({super.key, required this.refreshData});

  @override
  State<PersonListPage> createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
  late int repoViewId;
  GenericListEntityState? _listState;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    repoViewId = AppConstants().PersonListRepoViewId;
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() => _isLoading = true);

    try {
      final response = await GetIt.instance<PersonService>().get(
        person.Request(repoViewId: repoViewId),
        (json) => person.Response.fromJson(json),
      );

      setState(() {
        _listState =
            GenericListEntityState<
              person.Response,
              person.ResponseData,
              person.Request
            >(
              request: person.Request(repoViewId: repoViewId),
              response: response,
              fetchData: response?.data ?? [],
              fields: [
                FieldDisplayConfig(
                  label: 'نام',
                  valueGetter: (p) => p.displayName ?? '',
                ),
                FieldDisplayConfig(
                  label: 'ایمیل',
                  valueGetter: (p) => p.email ?? p.firstName ?? '',
                ),
              ],
            );
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cacheProvider = Provider.of<PageCacheProvider>(
      context,
      listen: false,
    );

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_listState == null || _listState!.fetchData.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('داده‌ای یافت نشد'),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('بارگذاری مجدد'),
            ),
          ],
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _fetchData,
          isExtended: false,

          backgroundColor: Colors.black,
          tooltip: 'افزودن',
          child: const Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          centerTitle: false,
          title: Text('لیست اشخاص'),
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          actionsPadding: EdgeInsetsGeometry.only(left: 10),
          titleSpacing: 25,
          leadingWidth: 14,
          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0,
          actions: [
            IconButton(onPressed: () => {}, icon: Icon(Icons.search)),
            IconButton(onPressed: () => {}, icon: Icon(Icons.more_vert)),
          ],
          leading: IconButton(
            onPressed: () => {},
            icon: Icon(Icons.arrow_back),
          ),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(left: 15, right: 0),
              child: const Row(
                children: [ListPagination(), Spacer(), ButtonPanel()],
              ),
            ),
            Expanded(
              child: GenericEntityScreen<person.ResponseData>(
                screenTitle: 'لیست اشخاص',
                fieldConfigs: [
                  FieldDisplayConfig(
                    label: 'نام',
                    valueGetter: (p) => p.displayName ?? '',
                  ),
                  FieldDisplayConfig(
                    label: 'ایمیل',
                    valueGetter: (p) => p.firstName ?? p.firstName ?? '',
                  ),
                ],
                enableSearch: true,
                enableSorting: true,
                enablePagination: true,
                customItemBuilder: (person) {
                  return PersonExpander(person: person);
                },
                onFetchData: () async {
                  final response = await GetIt.instance<PersonService>().get(
                    person.Request(repoViewId: repoViewId),
                    (json) => person.Response.fromJson(json),
                  );

                  return GenericListEntityState<
                    person.Response,
                    person.ResponseData,
                    person.Request
                  >(
                    request: person.Request(repoViewId: repoViewId),
                    response: response,
                    fetchData: response?.data ?? [],
                    fields: [
                      FieldDisplayConfig(
                        label: 'نام',
                        valueGetter: (p) => p.displayName ?? '',
                      ),
                      FieldDisplayConfig(
                        label: 'ایمیل',
                        valueGetter: (p) => p.email ?? p.firstName ?? '',
                      ),
                    ],
                  );
                  return _listState!;
                },
              ),
            ),
            AppNavigationButton(
              selectedTab: cacheProvider.selectedTab,
              onTabSelected: (tab) => {
                setState(() {
                  cacheProvider.changePage(
                    PageType.tabBar,
                    route: null,
                    tab: tab,
                  );
                  cacheProvider.clearPageCache(tab);
                }),
              },
            ),
          ],
        ),
      ),
    );
  }
}
