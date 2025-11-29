/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


final Widget languageIcon = Image.asset(
  'assets/images/lang_icon.png',
  width: 55,
  height: 55,
);

class LanguageMenuButton extends StatelessWidget {
  const LanguageMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        final cubit = context.read<LanguageCubit>();
        if (value == 'فارسی' && cubit.state.languageCode != 'fa') {
          cubit.emit(const Locale('fa', 'IR'));
        } else if (value == 'English' && cubit.state.languageCode != 'en') {
          cubit.emit(const Locale('en', 'US'));
        }
      },
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.white,
      splashRadius: 0,
      offset: Offset(30, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(15)),
      ),
      shadowColor: Colors.black38,
      padding: EdgeInsetsGeometry.all(10),
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'فارسی',
          child: Center(child: Text('فارسی')),
        ),
        PopupMenuItem<String>(
          value: 'English',
          child: Center(child: Text('English')),
        ),
      ],
      child: GestureDetector(
        onTap: null, // PopupMenuButton خودش هندل می‌کنه
        child: languageIcon,
      ),
    );
  }
}
*/
