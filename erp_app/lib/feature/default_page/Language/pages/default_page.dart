// default_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/language_bloc.dart';
import '../bloc/language_event.dart';
import '../bloc/language_state.dart';

class DefaultPage extends StatelessWidget {
  const DefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سرویس‌ها'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<LanguageBloc, LanguageState>(
      listener: (context, state) {
        if (state is LanguageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message ?? "خطا در دریافت اطلاعات")),
          );
        }
      },
      builder: (context, state) {
        if (state is LanguageLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LanguageLoaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // بخش زبان با اسکرول افقی
                _buildLanguageSection(context, state),

                const SizedBox(height: 32),

              ],
            ),
          );
        }

        if (state is LanguageError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  state.message ?? "خطای نامشخص",
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<LanguageBloc>().add(const LoadLanguageEvent());
                  },
                  child: const Text('تلاش مجدد'),
                ),
              ],
            ),
          );
        }

        return const Center(
          child: Text('برای شروع دکمه را فشار دهید'),
        );
      },
    );
  }

  Widget _buildLanguageSection(BuildContext context, LanguageLoaded state) {
    // متغیر برای ذخیره زبان انتخاب شده
    int? selectedLanguageId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // تیتر زبان
        const Row(
          children: [
            Icon(Icons.language, size: 24),
            SizedBox(width: 8),
            Text(
              'زبان',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // لیست افقی زبان‌ها
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.languages.length,
            itemBuilder: (context, index) {
              final language = state.languages[index];
              final isSelected = selectedLanguageId == language.languageId;

              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: GestureDetector(
                  onTap: () {
                    // ذخیره زبان انتخابی
                    selectedLanguageId = language.languageId;
                    // ری‌بیلد ویجت
                    (context as Element).markNeedsBuild();
                  },
                  child: Container(
                    width: 120,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[50] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.translate,
                          color: isSelected ? Colors.blue : Colors.grey,
                          size: 30,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          language.languageDesc ?? 'بدون نام',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.blue : Colors.black,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // نمایش زبان انتخاب شده
        if (selectedLanguageId != null)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    'زبان انتخابی: ${state.languages.firstWhere((lang) => lang.languageId == selectedLanguageId).languageDesc}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

}