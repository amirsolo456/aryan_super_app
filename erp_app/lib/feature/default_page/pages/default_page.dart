

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models_package/Data/Default/Com/Select/Select_Currency/currency_dto.dart'
    as currency_model;
import 'package:models_package/Data/Default/trh/select/select_option_dto.dart'
    as cashier_model;
import 'package:models_package/Data/Default/mng/select/place/place_dto.dart'
    as place_model;
import 'package:models_package/Data/Default/Com/Select/Select_Year/select_year_dto.dart'
    as select_year;
import '../Language/bloc/language_bloc.dart';
import '../Language/bloc/language_event.dart';
import '../Language/bloc/language_state.dart';
import '../Place/bloc/place_bloc.dart';
import '../Place/bloc/place_event.dart';
import '../Place/bloc/place_state.dart';
import '../select_cashier/bloc/select_cashier_bloc.dart';
import '../select_cashier/bloc/select_cashier_event.dart';
import '../select_cashier/bloc/select_cashier_state.dart';
import '../select_currency/bloc/select_currency_bloc.dart';
import '../select_currency/bloc/select_currency_event.dart';
import '../select_currency/bloc/select_currency_state.dart';
import '../select_year/bloc/select_year_bloc.dart';
import '../select_year/bloc/select_year_event.dart';
import '../select_year/bloc/select_year_state.dart';
import 'package:resources_package/Resources/Assets/assets_manager.dart';

import 'default_selection_state__bloc.dart';
import 'default_selection_state__event.dart';
import 'default_selection_state__state.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({super.key});

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  int? selectedLanguageId;
  int? selectedPlaceId;
  int? selectedCashierId;
  int? selectedCurrencyId;
  int? selectedYearId;

  @override
  void initState() {
    super.initState();
    // لود اولیه داده‌ها
    context.read<SelectYearBloc>().add(const LoadSelectYearEvent());
    context.read<SelectCurrencyBloc>().add(const LoadSelectCurrencyEvent());
    context.read<SelectCashierBloc>().add(const LoadSelectCashierEvent());
    context.read<PlaceBloc>().add(const LoadPlaceEvent());
    context.read<LanguageBloc>().add(const LoadLanguageEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DefaultSelectionBloc, DefaultSelectionState>(
        listenWhen: (prev, curr) => prev.defaults != curr.defaults,
        listener: (context, state) {
          // هر بار DefaultSelection تغییر کرد، بلوک‌ها را ری‌لود کن
          context.read<SelectYearBloc>().add(const LoadSelectYearEvent());
          context.read<SelectCurrencyBloc>().add(
            const LoadSelectCurrencyEvent(),
          );
          context.read<SelectCashierBloc>().add(const LoadSelectCashierEvent());
          context.read<PlaceBloc>().add(const LoadPlaceEvent());
          context.read<LanguageBloc>().add(const LoadLanguageEvent());
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLanguageSection(),
              const SizedBox(height: 32),
              _buildCurrencySection(),
              const SizedBox(height: 32),
              // Text("aaa"),
              _buildYearSection(),
              const SizedBox(height: 32),
              _buildCashierSection(),
              const SizedBox(height: 32),
              _buildPlaceSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget horizontalSelector<T>({
    required String title,
    required String iconTitle,
    required List<T> items,
    required int? selectedId,
    required int Function(T) getId,
    required String Function(T) getTitle,
    required void Function(int id) onSelect,
  }) {
    // اگر آیتمی وجود نداره، یک لیست خالی می‌سازیم ولی تیتر و آیکون همیشه نمایش داده می‌شود
    final displayItems = [...items];

    // 2. انتخاب شده را اول می‌آوریم
    if (selectedId != null) {
      displayItems.sort((a, b) {
        if (getId(a) == selectedId) return -1;
        if (getId(b) == selectedId) return 1;
        return 0;
      });
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 55,
                height: 55,
                child: Image.asset(
                  iconTitle,
                  package: 'resources_package',
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          displayItems.isEmpty
              ? Container(
            height: 50,
            alignment: Alignment.center,
            child: const Text(
              'موردی موجود نیست',
              style: TextStyle(color: Colors.grey),
            ),
          )
              : SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: displayItems.length,
              itemBuilder: (context, index) {
                final item = displayItems[index];
                final id = getId(item);
                final isSelected = selectedId == id;
                final text = getTitle(item);

                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: GestureDetector(
                    onTap: () => onSelect(id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFECECEC) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                              color: const Color(0xFF767676),
                              fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.check, color: Color(0xFF767676), size: 20),
                          ]
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  _buildLanguageSection() {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is LanguageLoaded) {
          return horizontalSelector(
            iconTitle: AryanAssets.langIcon,
            title: 'زبان',
            items: state.languages,
            selectedId: selectedLanguageId,
            getId: (e) => e.LanguageId,
            getTitle: (e) => e.LanguageDesc,
            onSelect: (id) {
              setState(() => selectedLanguageId = id);
              context.read<DefaultSelectionBloc>().add(LanguageChanged(id));
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _buildPlaceSection() {
    return BlocBuilder<PlaceBloc, PlaceState>(
      builder: (context, state) {
        if (state is PlaceLoaded) {
          return horizontalSelector<place_model.ResponseData>(
            iconTitle: AryanAssets.buildingsIcon,
            title: 'شرکت',
            items: state.places,
            selectedId: selectedPlaceId,
            getId: (e) => e.placeId,
            getTitle: (e) => e.placeDesc ?? '',
            onSelect: (id) {
              setState(() => selectedPlaceId = id);
              context.read<DefaultSelectionBloc>().add(PlaceChanged(id));
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _buildCashierSection() {
    return BlocBuilder<SelectCashierBloc, SelectCashierState>(
      builder: (context, state) {
        if (state is SelectCashierLoaded) {
          return horizontalSelector<cashier_model.SelectOptionData>(
            iconTitle: AryanAssets.cashOutIcon,
            title: 'صندوقدار اصلی',
            items: state.selectCashier,
            selectedId: selectedCashierId,
            getId: (e) => e.selectId,
            getTitle: (e) => e.selectDisplay ?? '',
            onSelect: (id) {
              setState(() => selectedCashierId = id);
              context.read<DefaultSelectionBloc>().add(CashierChanged(id));
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _buildCurrencySection() {
    return BlocBuilder<SelectCurrencyBloc, SelectCurrencyState>(
      builder: (context, state) {
        if (state is SelectCurrencyLoaded) {
          return horizontalSelector<currency_model.ResponseData>(
            iconTitle: AryanAssets.moneyIcon,
            title: 'ارز',
            items: state.selectCurrency,
            selectedId: selectedCurrencyId,
            getId: (e) => e.selectId,
            getTitle: (e) => e.selectDisplay,
            onSelect: (id) {
              setState(() => selectedCurrencyId = id);
              context.read<DefaultSelectionBloc>().add(CurrencyChanged(id));
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _buildYearSection() {
    return BlocBuilder<SelectYearBloc, SelectYearState>(
      builder: (context, state) {
        if (state is SelectYearLoaded) {
          return horizontalSelector<select_year.ResponseData>(
            iconTitle: AryanAssets.calendarIcon,
            title: 'سال مالی',
            items: state.selectYears,
            selectedId: selectedYearId,
            getId: (e) => e.yearId,
            getTitle: (e) => e.yearDesc,
            onSelect: (id) {
              setState(() => selectedYearId = id);
              context.read<DefaultSelectionBloc>().add(YearChanged(id));
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
