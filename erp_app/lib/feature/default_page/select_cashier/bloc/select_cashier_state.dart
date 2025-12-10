import 'package:equatable/equatable.dart';
import 'package:models_package/Data/Default/trh/select/select_cashier.dart';



abstract class SelectCashierState extends Equatable {
  const SelectCashierState();


  @override
  List<Object?> get props => [];
}


class SelectCashierInitial extends SelectCashierState {
  const SelectCashierInitial();
}


class SelectCashierLoading extends SelectCashierState {
  const SelectCashierLoading();
}


class SelectCashierLoaded extends SelectCashierState {
  final List<ResponseData> selectCashier;
  const SelectCashierLoaded(this.selectCashier);


  @override
  List<Object?> get props => [selectCashier];
}


class SelectCashierError extends SelectCashierState {
  final String? message;
  const SelectCashierError([this.message]);


  @override
  List<Object?> get props => [message];
}