

import 'package:bloc/bloc.dart';
import 'package:models_package/Data/Default/Com/Select/Select_Year/select_year.dart';
import 'package:services_package/Repo_ViewId/repo_view_id.dart';
import 'package:services_package/default/com/select/Year_Select_Service.dart';
import 'select_year_event.dart';
import 'select_year_state.dart';

class SelectYearBloc extends Bloc<SelectYearEvent, SelectYearState> {
  final YearSelectService getSelectYearUseCase;

  SelectYearBloc({required this.getSelectYearUseCase})
    : super(const SelectYearInitial()) {
    on<LoadSelectYearEvent>(_onLoadSelectYear);
  }

  Future<void> _onLoadSelectYear(
    LoadSelectYearEvent event,
    Emitter<SelectYearState> emit,
  ) async {
    emit(const SelectYearLoading());
    try {
      final selectYears = await getSelectYearUseCase.get(
        Request(RepoViewId: AppConstants.repoViewId207003, ShowMode: 10),
        (json) => Response.fromJson(json),
      );

      if (selectYears == null || selectYears.data == null) {
        emit(SelectYearError('Select Years Is Null'));
        return;
      }
      emit(SelectYearLoaded(selectYears!.data ?? []));
    } catch (e) {
      emit(SelectYearError(e.toString()));
    }
  }
}
