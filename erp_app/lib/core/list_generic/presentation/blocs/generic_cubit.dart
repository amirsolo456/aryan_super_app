import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:models_package/Base/base_request.dart';
import 'package:models_package/Base/base_response.dart';

part 'generic_state.dart';

abstract class GenericBloc<T extends BaseResponse<D>, D, C extends BaseRequest>
    extends Cubit<GenericState> {
  GenericBloc() : super(const LoadingState());

  Future<T> fetchData();

  Future<void> loadData() async {
    emit(const LoadingState());
    try {
      final data = await fetchData();
      emit(LoadedState<D>(data.data ?? []));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> refresh() async => loadData();

  void clearError() {
    if (state is ErrorState) {
      loadData();
    }
  }
}

abstract class SpecializedBaseBloc<
  T extends BaseResponse<D>,
  D,
  C extends BaseRequest
>
    extends GenericBloc<T, D, C> {
  SpecializedBaseBloc() : super();

  Future<void> loadWithParams(C params);

  Future<void> filterData(String query);
}
