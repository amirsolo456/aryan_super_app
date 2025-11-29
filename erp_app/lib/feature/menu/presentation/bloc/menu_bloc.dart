import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


import '../../domain/usecases/get_menu.dart';
import 'menu_event.dart';
import 'menu_state.dart';


class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final GetMenuUseCase getMenuUseCase;


  MenuBloc({required this.getMenuUseCase}) : super(const MenuInitial()) {
    on<LoadMenuEvent>(_onLoadMenu);
  }


  Future<void> _onLoadMenu(LoadMenuEvent event, Emitter<MenuState> emit) async {
    emit(const MenuLoading());
    try {
      final menus = await getMenuUseCase();

      // اگر Data خالی بود، همان MenuLoaded با لیست خالی بفرست
      emit(MenuLoaded(menus));
    } catch (e) {
      // پیام خطای سرور یا Exception دیگر را نمایش بده
      emit(MenuError(e.toString()));
    }
  }
}