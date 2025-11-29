// lib/widgets/language_menu_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'language_button_stand_alone_cubit.dart';


final Widget languageIcon = Image.asset(
  'assets/images/lang_icon.png',
  package: 'resources_package',
  width: 40,
  height: 40,
);

class LanguageButtonStandAlone extends StatelessWidget {
  const LanguageButtonStandAlone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageButtonStandAloneCubit, Locale>(
      builder: (context, locale) {
        final locales = const [
          Locale('fa', 'IR'),
          Locale('en', 'US'),
        ];

        return PopupMenuButton<Locale>(
          onSelected: (value) {
            context.read<LanguageButtonStandAloneCubit>().setLocale(value);
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Colors.white,
          offset: const Offset(0, 40),
          itemBuilder: (ctx) {
            return locales.map((l) {
              final isSelected = l.languageCode == locale.languageCode;
              return PopupMenuItem<Locale>(
                value: l,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l.languageCode == 'fa' ? 'فارسی' : 'English'),
                    if (isSelected) ...[
                      const SizedBox(width: 8),
                      const Icon(Icons.check, size: 18, color: Colors.blue),
                    ],
                  ],
                ),
              );
            }).toList();
          },
          child: languageIcon,
        );
      },
    );
  }
}
