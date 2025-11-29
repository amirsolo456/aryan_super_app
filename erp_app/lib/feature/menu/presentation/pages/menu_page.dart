import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/menu_entity.dart';
import '../bloc/menu_bloc.dart';
import '../bloc/menu_event.dart';
import '../bloc/menu_state.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  TextEditingController searchController = TextEditingController();
  List<MenuEntity> filteredMenus = [];

  bool isFocused = false;
  final FocusNode searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    searchFocusNode.addListener(() {
      setState(() {
        isFocused = searchFocusNode.hasFocus;
      });
    });
  }

  void filterMenus(List<MenuEntity> menus, String query) {
    filteredMenus = menus
        .map((menu) => _filterMenu(menu, query))
        .where((e) => e != null)
        .cast<MenuEntity>()
        .toList();
    setState(() {});
  }

  MenuEntity? _filterMenu(MenuEntity menu, String query) {
    // فیلتر کردن خود منو یا زیرمنوها
    final bool matches = menu.menuDesc.contains(query);
    final subMenusFiltered = menu.subMenus
        .map((e) => _filterMenu(e, query))
        .where((e) => e != null)
        .cast<MenuEntity>()
        .toList();

    if (matches || subMenusFiltered.isNotEmpty) {
      return MenuEntity(
        menuId: menu.menuId,
        icon: menu.icon,
        menuDesc: menu.menuDesc,
        iconUrl: menu.iconUrl,
        actionType: menu.actionType,
        menuType: menu.menuType,
        actionId: menu.actionId,
        repoId: menu.repoId,
        subMenus: subMenusFiltered,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('منو')),
      body: BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          if (state is MenuLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is MenuError) {
            return const Center(child: Text('خطا در بارگذاری'));
          }
          if (state is MenuLoaded) {
            // اگر چیزی تایپ شد، فیلتر را اعمال کن
            if (searchController.text.isEmpty) {
              filteredMenus = state.menus;
            }

            return                 Directionality(
              textDirection: TextDirection.rtl,

              child: Column(
                children: [
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isFocused ? Colors.white : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color:isFocused ? Colors.black12 : Colors.white)
                        ),
                        child: TextField(
                          controller: searchController,
                          focusNode: searchFocusNode,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'IRanSans',
                          ),
                          decoration: const InputDecoration(
                            hintText: 'جستجو',
                            hintStyle: TextStyle(color: Colors.black54),

                            // مهم! باید صفر شود تا صد در صد رنگ پس‌زمینه از Container گرفته شود
                            filled: false,
                            // fillColor: Colors.red,

                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                          onChanged: (value) => filterMenus(state.menus, value),
                        ),
                      )


                   ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: filteredMenus.length,
                      itemBuilder: (context, index) {
                        return _MenuTile(filteredMenus[index]);
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final MenuEntity item;
  const _MenuTile(this.item);

  @override
  Widget build(BuildContext context) {
    final bool hasChildren = item.subMenus.isNotEmpty;

    final Widget titleWidget = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (item.icon.isNotEmpty)
          SvgPicture.string(item.icon, width: 18, height: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            item.menuDesc,
            textDirection: TextDirection.rtl,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );

    /// -------------------------
    /// بدون زیرمنو
    /// -------------------------
    if (!hasChildren) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: ListTile(
          dense: true,
          visualDensity: const VisualDensity(vertical: -3),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          title: titleWidget,
          onTap: () {},
        ),
      );
    }

    /// -------------------------
    /// با زیرمنو
    /// -------------------------
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 12),
          childrenPadding: const EdgeInsets.only(right: 20, bottom: 2),

          /// ⚡️ این خط جهت قرارگیری فلش را تغییر می‌دهد
          controlAffinity: ListTileControlAffinity.trailing,

          collapsedIconColor: Colors.black,
          iconColor: Colors.black,
          dense: true,
          visualDensity: const VisualDensity(vertical: -3),

          title: Row(
            children: [
              /// آیکون + متن سمت راست
              Expanded(child: titleWidget),

              /// فاصله بین عنوان و فلش (که چپ می‌رود)
              const SizedBox(width: 10),
            ],
          ),

          children: item.subMenus.map((e) => _MenuTile(e)).toList(),
        ),
      ),
    );
  }
}
