import 'package:flutter/material.dart';
import 'package:models_package/Base/enums.dart';

final Widget futuresIcon = Image.asset(
  'assets/images/futures.png',
  package: 'resources_package',
  width: 24,
  height: 24,
);
final Widget moreIcon = Image.asset(
  'assets/images/more.png',
  package: 'resources_package',
  width: 24,
  height: 24,
);

class ListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBarsMode mode;
  const ListAppBar({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case AppBarsMode.erpPersonListMode:
        return buildPersonListAppBar(context);

      case AppBarsMode.erpNewMode:
        return buildNewModeAppBar(context);

      case AppBarsMode.erpOpendMode:
        return builderpOpendAppBar(context);

      case AppBarsMode.erpdefaultMode:
        return builderpdefaultAppBar(context);

      case AppBarsMode.erpprofileMode:
        return builderpprofileAppBar(context);

      default:
        return builderpdashvoardAppBar(context);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

AppBar buildPersonListAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,

    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("منو", style: TextStyle(color: Colors.black)),
        // SizedBox(width: 5), // فاصله دلخواه
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
      ],
    ),
  );
}

AppBar buildNewModeAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      textAlign: TextAlign.start,
      // AppLocalizations.of(context)!.personList,
      "اضافه کردن ",
      style: TextStyle(color: Colors.black),
    ),
    // centerTitle: true,
    // actions: [
    //   IconButton(
    //     onPressed: () {},
    //     icon: futuresIcon,
    //     highlightColor: Colors.black.withOpacity(0.05),
    //   ),
    //   IconButton(
    //     onPressed: () {},
    //     icon: moreIcon,
    //     highlightColor: Colors.black.withOpacity(0.05),
    //   ),
    // ],
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    toolbarHeight: 70,
  );
}

AppBar builderpOpendAppBar(BuildContext context) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    elevation: 0.0,
    backgroundColor: Colors.white,
    primary: true,
    title: Text(
      "باز شده ها",
      // AppLocalizations.of(context)!.profileTitle,
      style: const TextStyle(color: Color(0xFF585858)),
    ),
    centerTitle: false,
  );
}

AppBar builderpdefaultAppBar(BuildContext context) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    elevation: 0.0,
    backgroundColor: Colors.white,
    primary: true,
    title: Text(
      "پیش فرض ها",
      // AppLocalizations.of(context)!.profileTitle,
      style: const TextStyle(color: Color(0xFF585858)),
    ),
    centerTitle: false,
  );
}

AppBar builderpprofileAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,

    title: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("حساب کاربری", style: TextStyle(color: Colors.black)),
        // SizedBox(width: 5), // فاصله دلخواه
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward)),
      ],
    ),
  );
}

AppBar builderpdashvoardAppBar(BuildContext context) {
  return AppBar(
    scrolledUnderElevation: 0.0,
    elevation: 0.0,
    backgroundColor: Colors.white,
    primary: true,
    title: Text("داشبورد", style: const TextStyle(color: Color(0xFF585858))),
    centerTitle: false,
  );
}

AppBar buildDefaultAppBar(BuildContext context) {
  return AppBar(
    title: Text("صفحه ${1}"),
    elevation: 0.0,
    primary: true,
    backgroundColor: Colors.white,
    scrolledUnderElevation: 0.0,
  );
}
