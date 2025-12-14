import 'package:flutter/material.dart';
import 'package:models_package/Data/Com/Person/dto.dart';



@immutable
sealed class PersonListState {}

final class PersonListInitialState extends PersonListState {}

class LoadDataSuccess extends PersonListState {}

class LoadDataError extends PersonListState {}

class LoadDataSource extends PersonListState {
  final Response data;

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
