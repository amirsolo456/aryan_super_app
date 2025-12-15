import 'package:equatable/equatable.dart';

class DefaultSelectionState extends Equatable {
  final int? placeId;
  final int? yearId;
  final int? cashierId;
  final int? languageId;

  const DefaultSelectionState({
    this.placeId,
    this.yearId,
    this.cashierId,
    this.languageId,
  });

  DefaultSelectionState copyWith({
    int? placeId,
    int? yearId,
    int? cashierId,
    int? languageId,
  }) {
    return DefaultSelectionState(
      placeId: placeId ?? this.placeId,
      yearId: yearId ?? this.yearId,
      cashierId: cashierId ?? this.cashierId,
      languageId: languageId ?? this.languageId,
    );
  }

  @override
  List<Object?> get props => [placeId, yearId, cashierId, languageId];
}
