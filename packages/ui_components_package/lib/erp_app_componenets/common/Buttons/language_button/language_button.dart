import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'language_cubit.dart';

final Widget languageIcon = Image.asset(
  'assets/images/lang_icon.png',
  package: 'resources.package',
  width: 55,
  height: 55,
);

class LanguageMenuButton extends StatelessWidget {
  const LanguageMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    // دسترسی به cubit؛ فرض می‌کنیم پروژه مادر آن را فراهم کرده
    final cubit = context.watch<LanguageCubit>();
    final current = cubit.state;

    final locales = const [
      Locale('fa', 'IR'),
      Locale('en', 'US'),
    ];

    return PopupMenuButton<Locale>(
      onSelected: (value) {
        // فراخوانی متد عمومی cubit (نه emit)
        context.read<LanguageCubit>().setLocale(value);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      offset: const Offset(30, 50),
      itemBuilder: (BuildContext ctx) => locales.map((locale) {
        final isSelected = locale.languageCode == current.languageCode;
        return PopupMenuItem<Locale>(
          value: locale,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(locale.languageCode == 'fa' ? 'فارسی' : 'English'),
              if (isSelected) ...[
                const SizedBox(width: 8),
                const Icon(Icons.check, size: 18, color: Colors.blue),
              ]
            ],
          ),
        );
      }).toList(),
      child: languageIcon,
    );
  }
}
