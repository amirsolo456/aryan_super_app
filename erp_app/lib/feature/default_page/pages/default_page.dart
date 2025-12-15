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
import '../Language/bloc/language_state.dart';
import '../Place/bloc/place_bloc.dart';
import '../Place/bloc/place_state.dart';
import '../select_cashier/bloc/select_cashier_bloc.dart';
import '../select_cashier/bloc/select_cashier_state.dart';
import '../select_currency/bloc/select_currency_bloc.dart';
import '../select_currency/bloc/select_currency_state.dart';
import '../select_year/bloc/select_year_bloc.dart';
import '../select_year/bloc/select_year_state.dart';

import 'package:resources_package/Resources/Assets/assets_manager.dart';

// class DefaultPage extends StatelessWidget {
//   const DefaultPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => DefaultSelectionBloc(),
//       child: Scaffold(
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               _LanguageSection(),
//               SizedBox(height: 32),
//               _CurrencySection(),
//               SizedBox(height: 32),
//               _YearSection(),
//               SizedBox(height: 32),
//               _CashierSection(),
//               SizedBox(height: 32),
//               _PlaceSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ====================== Language ======================
// class _LanguageSection extends StatelessWidget {
//   const _LanguageSection();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LanguageBloc, LanguageState>(
//       builder: (context, state) {
//         if (state is LanguageLoaded) {
//           final selectedId = context.select(
//                   (DefaultSelectionBloc bloc) => bloc.state.languageId);
//           return _horizontalSelector(
//             title: 'زبان',
//             icon: AryanAssets.langIcon,
//             items: state.languages,
//             selectedId: selectedId,
//             getId: (e) => e.LanguageId,
//             getTitle: (e) => e.LanguageDesc ?? '',
//             onSelect: (id) {
//               context.read<DefaultSelectionBloc>().add(LanguageChanged(id));
//               context.read<LanguageBloc>().add(const LoadLanguageEvent());
//             },
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
//
// // ====================== Place ======================
// class _PlaceSection extends StatelessWidget {
//   const _PlaceSection();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PlaceBloc, PlaceState>(
//       builder: (context, state) {
//         if (state is PlaceLoaded) {
//           final selectedId =
//           context.select((DefaultSelectionBloc bloc) => bloc.state.placeId);
//           return _horizontalSelector<place_model.ResponseData>(
//             title: 'شرکت',
//             icon: AryanAssets.buildingsIcon,
//             items: state.places,
//             selectedId: selectedId,
//             getId: (e) => e.placeId,
//             getTitle: (e) => e.placeDesc ?? '',
//             onSelect: (id) {
//               context.read<DefaultSelectionBloc>().add(PlaceChanged(id));
//               context.read<PlaceBloc>().add( LoadPlaceEvent(placeId: id));
//             },
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
//
// // ====================== Cashier ======================
// class _CashierSection extends StatelessWidget {
//   const _CashierSection();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SelectCashierBloc, SelectCashierState>(
//       builder: (context, state) {
//         if (state is SelectCashierLoaded) {
//           final selectedId =
//           context.select((DefaultSelectionBloc bloc) => bloc.state.cashierId);
//           return _horizontalSelector<cashier_model.SelectOptionData>(
//             title: 'صندوقدار اصلی',
//             icon: AryanAssets.cashOutIcon,
//             items: state.selectCashier,
//             selectedId: selectedId,
//             getId: (e) => e.selectId,
//             getTitle: (e) => e.selectDisplay ?? '',
//             onSelect: (id) {
//               context.read<DefaultSelectionBloc>().add(CashierChanged(id));
//               context.read<SelectCashierBloc>().add( LoadSelectCashierEvent( cashierId: id));
//             },
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
//
// // ====================== Currency ======================
// class _CurrencySection extends StatelessWidget {
//   const _CurrencySection();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SelectCurrencyBloc, SelectCurrencyState>(
//       builder: (context, state) {
//         if (state is SelectCurrencyLoaded) {
//           final selectedId =
//           context.select((DefaultSelectionBloc bloc) => bloc.state.cashierId);
//           return _horizontalSelector<currency_model.ResponseData>(
//             title: 'ارز',
//             icon: AryanAssets.moneyIcon,
//             items: state.selectCurrency,
//             selectedId: selectedId,
//             getId: (e) => e.selectId,
//             getTitle: (e) => e.selectDisplay ?? '',
//             onSelect: (id) {
//               // context.read<DefaultSelectionBloc>().add();
//               context.read<SelectCurrencyBloc>().add( LoadSelectCurrencyEvent(currencyId: id));
//             },
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
//
// // ====================== Year ======================
// class _YearSection extends StatelessWidget {
//   const _YearSection();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SelectYearBloc, SelectYearState>(
//       builder: (context, state) {
//         if (state is SelectYearLoaded) {
//           final selectedId =
//           context.select((DefaultSelectionBloc bloc) => bloc.state.yearId);
//           return _horizontalSelector<select_year.ResponseData>(
//             title: 'سال مالی',
//             icon: AryanAssets.calendarIcon,
//             items: state.selectYears,
//             selectedId: selectedId,
//             getId: (e) => e.yearId,
//             getTitle: (e) => e.yearDesc ?? '',
//             onSelect: (id) {
//               context.read<DefaultSelectionBloc>().add(YearChanged(id));
//               context.read<SelectYearBloc>().add( LoadSelectYearEvent(yearId: id));
//             },
//           );
//         }
//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
//
// // ====================== Selector عمومی ======================
// Widget _horizontalSelector<T>({
//   required String title,
//   required String icon,
//   required List<T> items,
//   required int? selectedId,
//   required int Function(T) getId,
//   required String Function(T) getTitle,
//   required void Function(int) onSelect,
// }) {
//   return Directionality(
//     textDirection: TextDirection.rtl,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             SizedBox(
//               width: 55,
//               height: 55,
//               child: Image.asset(
//                 icon,
//                 package: 'resources_package',
//               ),
//             ),
//             const SizedBox(width: 8),
//             Text(
//               title,
//               style: const TextStyle(
//                   fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 50,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: items.length,
//             itemBuilder: (context, index) {
//               final item = items[index];
//               final id = getId(item);
//               final isSelected = selectedId == id;
//               final text = getTitle(item);
//
//               return Padding(
//                 padding: const EdgeInsets.only(left: 8),
//                 child: GestureDetector(
//                   onTap: () => onSelect(id),
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 8),
//                     decoration: BoxDecoration(
//                       color: isSelected ? const Color(0xFFECECEC) : Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 1,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           text,
//                           style: TextStyle(
//                             color: const Color(0xFF767676),
//                             fontWeight: isSelected
//                                 ? FontWeight.bold
//                                 : FontWeight.normal,
//                           ),
//                         ),
//                         if (isSelected) ...[
//                           const SizedBox(width: 4),
//                           const Icon(
//                             Icons.check,
//                             color: Color(0xFF767676),
//                             size: 20,
//                           ),
//                         ]
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }






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
      // appBar: AppBar(title: const Text('پیش فرض ها')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            //زبان
            _buildLanguageSection(),
            const SizedBox(height: 32),

            //ارز
            _buildCurrencySection(),
            const SizedBox(height: 32),


            //سال مالی
            _buildYearSection(),
            const SizedBox(height: 32),

            //صندوقدار اصلی
            _buildCashierSection(),
            const SizedBox(height: 32),

            //شرکت
            _buildPlaceSection(),

          ],
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
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50, // ارتفاع کارت‌ها
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final id = getId(item);
                final isSelected = selectedId == id;
                final text = getTitle(item);

                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: GestureDetector(
                    onTap: () => onSelect(id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Color(0xFFECECEC) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:  Colors.black ,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        // اندازه container متناسب با محتوا
                        children: [
                          Text(
                            text,
                            style: TextStyle(
                              color: Color(0xFF767676),
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 4),
                            const Icon(
                                Icons.check, color: Color(0xFF767676), size: 20),
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


// زبان
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
            getTitle: (e) => e.LanguageDesc ?? '',
            // فقط LanguageDesc
            onSelect: (id) => setState(() => selectedLanguageId = id),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }


// محل
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
            // فقط PlaceDesc





            onSelect: (id) => setState(() => selectedPlaceId = id),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }


// صندوقدار
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
            // فقط SelectDisplay
            onSelect: (id) => setState(() => selectedCashierId = id),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }


// واحد پول
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
            getTitle: (e) => e.selectDisplay ?? '',
            // فقط SelectDisplay
            onSelect: (id) => setState(() => selectedCurrencyId = id),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

// سال مالی
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
            getTitle: (e) => e.yearDesc ?? '',
            // فقط YearDesc
            onSelect: (id) => setState(() => selectedYearId = id),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
