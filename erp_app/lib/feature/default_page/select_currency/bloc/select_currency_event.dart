

import 'package:equatable/equatable.dart';

abstract class SelectCurrencyEvent extends Equatable {
  const SelectCurrencyEvent();


  @override
  List<Object?> get props => [];
}


class LoadSelectCurrencyEvent extends SelectCurrencyEvent {
  const LoadSelectCurrencyEvent();
}