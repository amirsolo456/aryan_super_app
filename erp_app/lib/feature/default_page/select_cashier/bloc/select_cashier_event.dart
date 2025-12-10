

import 'package:equatable/equatable.dart';

abstract class SelectCashierEvent extends Equatable {
  const SelectCashierEvent();


  @override
  List<Object?> get props => [];
}


class LoadSelectCashierEvent extends SelectCashierEvent {
  const LoadSelectCashierEvent();
}