import 'package:equatable/equatable.dart';


abstract class DefaultSelectionEvent extends Equatable {
  const DefaultSelectionEvent();

  @override
  List<Object?> get props => [];
}

class YearChanged extends DefaultSelectionEvent {
  final int yearId;
  const YearChanged(this.yearId);

  @override
  List<Object?> get props => [yearId];
}

class PlaceChanged extends DefaultSelectionEvent {
  final int placeId;
  const PlaceChanged(this.placeId);

  @override
  List<Object?> get props => [placeId];
}

class CashierChanged extends DefaultSelectionEvent {
  final int cashierId;
  const CashierChanged(this.cashierId);

  @override
  List<Object?> get props => [cashierId];
}

class CurrencyChanged extends DefaultSelectionEvent {
  final int currencyId;
  const CurrencyChanged(this.currencyId);

  @override
  List<Object?> get props => [currencyId];
}

class LanguageChanged extends DefaultSelectionEvent {
  final int languageId;
  const LanguageChanged(this.languageId);

  @override
  List<Object?> get props => [languageId];
}
