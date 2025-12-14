import 'dart:ffi';

import 'package:flutter/cupertino.dart' show immutable;
import 'package:models_package/Data/Com/Person/dto.dart';
import '../../../../../../core/list_generic/presentation/blocs/generic_cubit.dart';
import '../../../domain/repositories/person_repository.dart';

part 'search_person_event.dart';

part 'search_person_state.dart';

class SearchPersonBloc extends GenericBloc<Response, ResponseData, Request> {
  final PersonRepository _repository;

  SearchPersonBloc(this._repository) : super();

  @override
  Future<void> loadWithParams(Request params) async {
    emit(const LoadingState());
    try {
      final data = await _repository.searchUsers(params);
      emit(LoadedState<ResponseData>(data.data ?? []));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  @override
  Future<void> filterData(String query) async {
    final currentState = state;
    if (currentState is LoadedState<ResponseData>) {
      final filteredUsers = currentState.data
          .where(
            (user) =>
                user.fullName?.toLowerCase().contains(query.toLowerCase()) ??
                false,
          )
          .toList();

      emit(LoadedState<ResponseData>(filteredUsers));
    }
  }

  @override
  Future<Response> fetchData() async {
    return await _repository.getAllUsers();
  }
}
