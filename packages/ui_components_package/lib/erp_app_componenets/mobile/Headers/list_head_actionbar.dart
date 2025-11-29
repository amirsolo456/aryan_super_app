import 'package:flutter/material.dart';

import '../Buttons/dynamic_button.dart';
import '../Buttons/sort_button.dart';

final Widget sortIcon = Image.asset(
  'assets/images/sort.png',
  width: 24,
  height: 24,
  package:'resources_package',
);
final Widget filterNoneIcon = Image.asset(
  'assets/images/filternone.png',
  width: 24,
  height: 24,
  package:'resources_package',
);
final Widget filterSigningIcon = Image.asset(
  'assets/images/filtersigning.png',
  width: 24,
  height: 24,
  package:'resources_package',
);
final Widget refreshIcon = Image.asset(
  'assets/images/refresh.png',
  width: 24,
  height: 24,
  package:'resources_package',
);

class ButtonPanel extends StatelessWidget {
  const ButtonPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Wrap(
        spacing: 5,
        crossAxisAlignment: WrapCrossAlignment.end,
        alignment: WrapAlignment.end,
        direction: Axis.horizontal,
        children: [
          RotatingSortButton(),
          CustomDynamicButton(
            icon: filterNoneIcon,
            backgroundColor: Color(0xFFECECEC),
            elevation: 0,
            size: 46,
            borderRadius: 6,
            onPressed: OnFilterPressed,
          ),
          CustomDynamicButton(
            icon: refreshIcon,
            backgroundColor: Color(0xFFECECEC),
            elevation: 0,
            size: 46,
            borderRadius: 6,
            onPressed: OnRefreshPressed,
          ),
        ],
      ),
    );
  }

  void OnFilterPressed() {}

  void OnRefreshPressed() {}
}
