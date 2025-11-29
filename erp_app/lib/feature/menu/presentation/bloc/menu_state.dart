import 'package:equatable/equatable.dart';
import '../../domain/entities/menu_entity.dart';


abstract class MenuState extends Equatable {
  const MenuState();


  @override
  List<Object?> get props => [];
}


class MenuInitial extends MenuState {
  const MenuInitial();
}


class MenuLoading extends MenuState {
  const MenuLoading();
}


class MenuLoaded extends MenuState {
  final List<MenuEntity> menus;
  const MenuLoaded(this.menus);


  @override
  List<Object?> get props => [menus];
}


class MenuError extends MenuState {
  final String? message;
  const MenuError([this.message]);


  @override
  List<Object?> get props => [message];
}