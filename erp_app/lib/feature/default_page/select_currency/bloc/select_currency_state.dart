import 'package:equatable/equatable.dart';
import 'package:models_package/Data/Default/Com/Select/Select_Currency/currency_dto.dart';



abstract class SelectCurrencyState extends Equatable {
  const SelectCurrencyState();


  @override
  List<Object?> get props => [];
}


class SelectCurrencyInitial extends SelectCurrencyState {
  const SelectCurrencyInitial();
}


class SelectCurrencyLoading extends SelectCurrencyState {
  const SelectCurrencyLoading();
}


class SelectCurrencyLoaded extends SelectCurrencyState {
  final List<ResponseData> selectCurrency;
  const SelectCurrencyLoaded(this.selectCurrency);


  @override
  List<Object?> get props => [selectCurrency];
}


class SelectCurrencyError extends SelectCurrencyState {
  final String? message;
  const SelectCurrencyError([this.message]);


  @override
  List<Object?> get props => [message];
}