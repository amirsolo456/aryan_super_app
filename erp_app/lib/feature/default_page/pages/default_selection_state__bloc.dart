import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:services_package/api_client_service.dart';
import 'default_selection_state__event.dart';
import 'default_selection_state__state.dart';

class DefaultSelectionBloc
    extends Bloc<DefaultSelectionEvent, DefaultSelectionState> {

  final ApiSettings apiSettings;

  DefaultSelectionBloc(this.apiSettings)
      : super(DefaultSelectionState.initial()) {

    on<YearChanged>((event, emit) {
      final newState = state.copyWith(yearId: event.yearId);
      apiSettings.appDefaults.yearId = event.yearId;
      emit(newState);
    });

    on<PlaceChanged>((event, emit) {
      final newState = state.copyWith(placeId: event.placeId);
      apiSettings.appDefaults.placeId = event.placeId;
      emit(newState);
    });

    on<CashierChanged>((event, emit) {
      final newState = state.copyWith(cashierId: event.cashierId);
      apiSettings.appDefaults.cashierId = event.cashierId;
      emit(newState);
    });

    on<LanguageChanged>((event, emit) {
      final newState = state.copyWith(languageId: event.languageId);
      apiSettings.appDefaults.languageId = event.languageId;
      emit(newState);
    });

    on<CurrencyChanged>((event, emit) {
      final newState = state.copyWith(currencyId: event.currencyId);
      apiSettings.appDefaults.currencyId = event.currencyId;
      emit(newState);
    });



  }
}
