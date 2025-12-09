import 'package:bloc/bloc.dart';
import 'package:erp_app/feature/person/presentation/blocs/person_bloc/person_list_state.dart';
import 'package:meta/meta.dart';
import 'package:models_package/Data/Com/Person/dto.dart';
 import 'package:services_package/com/person/person_service.dart';

part 'person_list_event.dart';

class PersonListBloc extends Bloc<PersonListEvent, PersonListState> {
  final PersonService personService;

  PersonListBloc({required this.personService})
      : super(PersonListInitialState()) {

    on<PersonListEvent>((event, emit) async {
      if (event is PersonListInitialEvent) {
        try {

          final Response? response = await personService.get(
              Request(),
                  (json) => Response.fromJson(json)
          );
          emit(PersonListInitialState());
          if (response != null && response.data != null) {
            emit(LoadDataSource(response));
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
