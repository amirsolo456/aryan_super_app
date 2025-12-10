import 'package:equatable/equatable.dart';
import 'package:models_package/Data/Default/Com/Select/Select_Year/select_year.dart';



abstract class SelectYearState extends Equatable {
  const SelectYearState();


  @override
  List<Object?> get props => [];
}


class SelectYearInitial extends SelectYearState {
  const SelectYearInitial();
}


class SelectYearLoading extends SelectYearState {
  const SelectYearLoading();
}


class SelectYearLoaded extends SelectYearState {
  final List<ResponseData> selectYears;
  const SelectYearLoaded(this.selectYears);


  @override
  List<Object?> get props => [selectYears];
}


class SelectYearError extends SelectYearState {
  final String? message;
  const SelectYearError([this.message]);


  @override
  List<Object?> get props => [message];
}