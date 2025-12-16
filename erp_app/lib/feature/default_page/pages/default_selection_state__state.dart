import 'package:equatable/equatable.dart';
import 'package:models_package/Base/base_request.dart';

class DefaultSelectionState extends Equatable {
  final Defaults defaults;

  const DefaultSelectionState({required this.defaults});

  factory DefaultSelectionState.initial() =>
      DefaultSelectionState(defaults: Defaults());

  DefaultSelectionState copyWith({
    int? yearId,
    int? placeId,
    int? cashierId,
    int? languageId,
    int? currencyId,
  }) {
    return DefaultSelectionState(
      defaults: Defaults(
        yearId: yearId ?? defaults.yearId,
        placeId: placeId ?? defaults.placeId,
        cashierId: cashierId ?? defaults.cashierId,
        languageId: languageId ?? defaults.languageId,
        currencyId: currencyId ?? defaults.currencyId,
        managementAccountId: defaults.managementAccountId,
      ),
    );
  }

  @override
  List<Object?> get props => [defaults];
}
