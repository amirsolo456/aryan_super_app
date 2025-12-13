// default_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models_package/Data/Default/Com/Select/Select_Currency/select_currency.dart'
    as currency_model;
import 'package:models_package/Data/Default/trh/select/select_cashier.dart'
    as cashier_model;
import 'package:models_package/Data/Default/mng/select/place/place.dart'
    as place_model;
import 'package:models_package/Data/Default/Com/Select/Select_Year/select_year.dart';

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

    context.read<PlaceBloc>().add(const LoadPlaceEvent());
    context.read<SelectCashierBloc>().add(const LoadSelectCashierEvent());
    context.read<SelectCurrencyBloc>().add(const LoadSelectCurrencyEvent());
    context.read<SelectYearBloc>().add(const LoadSelectYearEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('پیش فرض ها')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLanguageSection(),
            const SizedBox(height: 32),

            _buildPlaceSection(),
            const SizedBox(height: 32),

            _buildCashierSection(),
            const SizedBox(height: 32),

            _buildCurrencySection(),
            const SizedBox(height: 32),

            _buildYearSection(),
          ],
        ),
      ),
    );
  }

  Widget horizontalSelector<T>({
    required String title,
    required IconData icon,
    required List<T> items,
    required int? selectedId,
    required int Function(T) getId,
    required String Function(T) getTitle,
    required void Function(int id) onSelect,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final id = getId(item);
              final isSelected = selectedId == id;

              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: () => onSelect(id),
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
                          Icons.check_circle_outline,
                          color: isSelected ? Colors.blue : Colors.grey,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          getTitle(item),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageSection() {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is LanguageLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LanguageLoaded) {
          return horizontalSelector(
            title: 'زبان',
            icon: Icons.language,
            items: state.languages,
            selectedId: selectedLanguageId,
            getId: (e) => e.languageId,
            getTitle: (e) => e.languageDesc ?? '',
            onSelect: (id) {
              setState(() => selectedLanguageId = id);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPlaceSection() {
    return BlocBuilder<PlaceBloc, PlaceState>(
      builder: (context, state) {
        if (state is PlaceLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PlaceLoaded) {
          final List<place_model.ResponseData> places = state.places;

          return horizontalSelector<place_model.ResponseData>(
            title: 'محل',
            icon: Icons.location_on_outlined,
            items: places,
            selectedId: selectedPlaceId,
            getId: (e) => e.placeId,
            getTitle: (e) => e.placeDesc ?? '',
            onSelect: (id) {
              setState(() => selectedPlaceId = id);
            },
          );
        }

        if (state is PlaceError) {
          return Text(state.message ?? 'خطا در دریافت محل');
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCashierSection() {
    return BlocBuilder<SelectCashierBloc, SelectCashierState>(
      builder: (context, state) {
        if (state is SelectCashierLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SelectCashierLoaded) {
          final cashiers = state.selectCashier;

          return horizontalSelector<cashier_model.ResponseData>(
            title: 'صندوقدار',
            icon: Icons.person,
            items: cashiers,
            selectedId: selectedCashierId,
            getId: (e) => e.selectId,
            getTitle: (e) => e.selectDisplay ?? '',
            onSelect: (id) {
              setState(() => selectedCashierId = id);
            },
          );
        }

        if (state is SelectCashierError) {
          return Text(state.message ?? 'خطا در دریافت صندوقدار');
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildCurrencySection() {
    return BlocBuilder<SelectCurrencyBloc, SelectCurrencyState>(
      builder: (context, state) {
        if (state is SelectCurrencyLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SelectCurrencyLoaded) {
          final currencies = state.selectCurrency;

          return horizontalSelector<currency_model.ResponseData>(
            title: 'واحد پول',
            icon: Icons.currency_exchange,
            items: currencies,
            selectedId: selectedCurrencyId,
            getId: (e) => e.selectId,
            getTitle: (e) => e.selectDisplay,
            onSelect: (id) {
              setState(() => selectedCurrencyId = id);
            },
          );
        }

        if (state is SelectCurrencyError) {
          return Text(state.message ?? 'خطا در دریافت واحد پول');
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildYearSection() {
    return BlocBuilder<SelectYearBloc, SelectYearState>(
      builder: (context, state) {
        if (state is SelectYearLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SelectYearLoaded) {
          return horizontalSelector<ResponseData>(
            title: 'سال مالی',
            icon: Icons.calendar_today,
            items: state.selectYears,
            selectedId: selectedYearId,
            getId: (e) => e.yearId,
            getTitle: (e) => e.yearDesc,
            onSelect: (id) {
              setState(() => selectedYearId = id);
            },
          );
        }

        if (state is SelectYearError) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              state.message ?? 'خطا در دریافت سال مالی',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
