import 'package:equatable/equatable.dart';
import 'package:models_package/Data/Auth/Menu/dto.dart';



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
  final List<ResponseData> menus;
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