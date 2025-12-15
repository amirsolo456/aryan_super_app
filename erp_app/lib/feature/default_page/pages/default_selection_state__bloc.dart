import 'package:flutter_bloc/flutter_bloc.dart';
import 'default_selection_state__event.dart';
import 'default_selection_state__state.dart';

class DefaultSelectionBloc
    extends Bloc<DefaultSelectionEvent, DefaultSelectionState> {

  DefaultSelectionBloc()
      : super(const DefaultSelectionState()) {

    on<PlaceChanged>((event, emit) {
      emit(state.copyWith(placeId: event.placeId));
    });

    on<YearChanged>((event, emit) {
      emit(state.copyWith(yearId: event.yearId));
    });

    on<CashierChanged>((event, emit) {
      emit(state.copyWith(cashierId: event.cashierId));
    });

    on<LanguageChanged>((event, emit) {
      emit(state.copyWith(languageId: event.languageId));
    });
  }
}
