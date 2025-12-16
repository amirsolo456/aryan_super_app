

import 'package:bloc/bloc.dart';
import 'package:services_package/Repo_ViewId/repo_view_id.dart';
import 'package:services_package/default/trh/select/cashier_service.dart';
import 'package:models_package/Data/Default/trh/select/select_option_dto.dart';
import 'select_cashier_event.dart';
import 'select_cashier_state.dart';



class SelectCashierBloc extends Bloc<SelectCashierEvent, SelectCashierState> {
  final CashierSelectService getSelectCashierUseCase;

  SelectCashierBloc({required this.getSelectCashierUseCase})
    : super(const SelectCashierInitial()) {
    on<LoadSelectCashierEvent>(_onLoadSelectCashier);
  }

  Future<void> _onLoadSelectCashier(
    LoadSelectCashierEvent event,
    Emitter<SelectCashierState> emit,
  ) async {
    emit(const SelectCashierLoading());
    try {
      final selectCashier = await getSelectCashierUseCase.get(
        SelectOptionRequest(repoViewId: AppConstants().CashierRepoViewId),
        (json) => SelectOptionResponse.fromJson(json),
      );



          if (selectCashier == null || selectCashier.data == null) {
        emit(SelectCashierError('Select Cashier Is Null'));
        return;
      }
      emit(SelectCashierLoaded(selectCashier!.data ?? []));
    } catch (e) {
      emit(SelectCashierError(e.toString()));
    }
  }
}
