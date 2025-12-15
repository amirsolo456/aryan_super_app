import 'package:equatable/equatable.dart';

abstract class DefaultSelectionEvent extends Equatable {
  const DefaultSelectionEvent();

  @override
  List<Object?> get props => [];
}

class PlaceChanged extends DefaultSelectionEvent {
  final int placeId;
  const PlaceChanged(this.placeId);

  @override
  List<Object?> get props => [placeId];
}

class YearChanged extends DefaultSelectionEvent {
  final int yearId;
  const YearChanged(this.yearId);

  @override
  List<Object?> get props => [yearId];
}

class CashierChanged extends DefaultSelectionEvent {
  final int cashierId;
  const CashierChanged(this.cashierId);

  @override
  List<Object?> get props => [cashierId];
}

class LanguageChanged extends DefaultSelectionEvent {
  final int languageId;
  const LanguageChanged(this.languageId);

  @override
  List<Object?> get props => [languageId];
}
