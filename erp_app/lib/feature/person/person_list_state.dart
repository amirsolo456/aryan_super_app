part of 'person_list_bloc.dart';

@immutable
sealed class PersonListState {}

final class PersonListInitialState extends PersonListState {}

class LoadDataSuccess extends PersonListState {}

class LoadDataError extends PersonListState {}

class LoadDataSource extends PersonListState {
  final List<ResponseData> data;

  LoadDataSource(this.data);
}

class FilterDataLoading extends PersonListState {}

class FilterDataSuccess extends PersonListState {}

class FilterDataError extends PersonListState {}

class SortDataLoading extends PersonListState {}

class SortDataSuccess extends PersonListState {}

class SortDataError extends PersonListState {}

class PaginationDataLoading extends PersonListState {}

class PaginationDataSuccess extends PersonListState {}

class PaginationDataError extends PersonListState {}
