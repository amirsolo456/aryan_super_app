
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models_package/Data/Auth/Menu/dto.dart';
import 'package:services_package/auth/menu/menu_service.dart';


import 'menu_event.dart';
import 'menu_state.dart';


class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuService getMenuUseCase;


  MenuBloc({required this.getMenuUseCase}) : super(const MenuInitial()) {
    on<LoadMenuEvent>(_onLoadMenu);
  }


  Future<void> _onLoadMenu(LoadMenuEvent event, Emitter<MenuState> emit) async {
    emit(const MenuLoading());
    try {
      final menus = await getMenuUseCase.get(Request(menuType: 1),(json) => Response.fromJson(json));

      if(menus  == null || menus.data == null){
        emit(MenuError('Menu Is Null'));
            return;
      }
      emit(MenuLoaded(menus!.data ?? []));
    } catch (e) {
      emit(MenuError(e.toString()));
    }
  }
}