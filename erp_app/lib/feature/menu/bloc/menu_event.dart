import 'package:equatable/equatable.dart';

abstract class MenuEvent extends Equatable {
  const MenuEvent();

  @override
  List<Object?> get props => [];
}

class LoadMenuEvent extends MenuEvent {
  const LoadMenuEvent();
}

class MenuErrorEvent extends MenuEvent {
final String? message;

  const MenuErrorEvent({this.message} );
}
