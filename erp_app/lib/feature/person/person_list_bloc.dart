import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:models_package/Data/Com/Person/dto.dart';
import 'package:services_package/Interfaces/apiclient_middleware_service.dart';
import 'package:services_package/api_client_service.dart';

part 'person_list_event.dart';
part 'person_list_state.dart';

class PersonListBloc extends Bloc<PersonListEvent, PersonListState> {
  final ApiClientMiddlewareService apiMiddleware;

  PersonListBloc({required this.apiMiddleware})
    : super(PersonListInitialState()) {
    on<PersonListEvent>((event, emit) async {
      if (event is PersonListInitialEvent) {
        try {
          emit(PersonListInitialState());
          final Response response = await apiMiddleware.sendRequestWithFallback(
            '/persons',
            HttpMethods.get,
            setToken: false,
          );

          if (response != null && response.data != null) {
            emit(LoadDataSource(response.data ?? []));
          } else {
            emit(LoadDataError());
          }
        } catch (e) {
          emit(LoadDataError());
        } finally {}
      } else if (event is FilterDataEvent) {
        try {
          emit(FilterDataLoading());
          await Future.delayed(Duration(seconds: 2));
          emit(FilterDataSuccess());
        } catch (e) {
          emit(FilterDataError());
        }
      } else if (event is SortDataEvent) {
        try {
          emit(SortDataLoading());
          await Future.delayed(Duration(seconds: 2));
          emit(SortDataSuccess());
        } catch (e) {
          emit(SortDataError());
        }
      } else if (event is PaginationDataEvent) {
        try {
          emit(PaginationDataLoading());
          await Future.delayed(Duration(seconds: 2));
          emit(PaginationDataSuccess());
        } catch (e) {
          emit(PaginationDataError());
        }
      } else {}
    });
  }
}
