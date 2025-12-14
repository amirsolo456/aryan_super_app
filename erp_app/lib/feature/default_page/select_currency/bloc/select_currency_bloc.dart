import 'package:bloc/bloc.dart';
import 'package:models_package/Data/Default/Com/Select/Select_Currency/currency_dto.dart';
import 'package:services_package/Repo_ViewId/repo_view_id.dart';
import 'package:services_package/default/com/select/currency_service.dart';
import 'select_currency_event.dart';
import 'select_currency_state.dart';

class SelectCurrencyBloc
    extends Bloc<SelectCurrencyEvent, SelectCurrencyState> {
  final CurrencySelectService getSelectCurrencyUseCase;

  SelectCurrencyBloc({required this.getSelectCurrencyUseCase})
    : super(const SelectCurrencyInitial()) {
    on<LoadSelectCurrencyEvent>(_onLoadSelectCurrency);
  }

  Future<void> _onLoadSelectCurrency(
    LoadSelectCurrencyEvent event,
    Emitter<SelectCurrencyState> emit,
  ) async {
    emit(const SelectCurrencyLoading());
    try {
      final selectCurrencys = await getSelectCurrencyUseCase.get(
        CurrencyRequest(
          repoViewId: AppConstants.repoViewId207003,
          showMode: 10,
        ),
        (json) => CurrencyResponse.fromJson(json),
      );

      if (selectCurrencys == null || selectCurrencys.data == null) {
        emit(SelectCurrencyError('Select Currencys Is Null'));
        return;
      }
      emit(SelectCurrencyLoaded(selectCurrencys!.data ?? []));
    } catch (e) {
      emit(SelectCurrencyError(e.toString()));
    }
  }
}
