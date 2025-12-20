import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models_package/Data/Auth/Menu/dto.dart';
import 'package:services_package/auth/menu/menu_service.dart';
import 'package:services_package/storage/domain/usecases/storage_service.dart';
import '../../../../advance_router.dart';
import '../../../../components/mainlayout/main_layout.dart';
import '../../../../core/network/injection_container.dart';
import '../../../../main.dart';
import '../pages/menu_page.dart';
import 'menu_event.dart';
import 'menu_state.dart';
import 'package:provider/provider.dart';
import '../../../../page_cache_provider.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuService getMenuUseCase;

  MenuBloc({required this.getMenuUseCase}) : super(const MenuInitial()) {
    on<LoadMenuEvent>(_onLoadMenu);
    on<MenuTokenNeedEvent>(_onMenuNeedToken);
  }

  Future<void> _onLoadMenu(LoadMenuEvent event, Emitter<MenuState> emit) async {
    emit(const MenuLoadingState());
    try {
      final menus = await getMenuUseCase.get(
        Request(menuType: 1),
            (json) => Response.fromJson(json),
      );

      if (menus == null || menus.data == null) {
        emit(MenuErrorState('Menu Is Null'));
        return;
      }
      if (menus.status == HttpStatus.unauthorized ||
          menus.status == HttpStatus.internalServerError) {
        emit(MenuTokenNeedState());
        return;
      }

      emit(MenuLoadedState(menus.data ?? []));
    } catch (e) {
      emit(MenuErrorState(e.toString()));
    }
  }

  Future<void> _onMenuNeedToken(MenuTokenNeedEvent event,
      Emitter<MenuState> emit,) async {
    emit(const MenuLoadingState());
    try {
      StorageService storage = sl<StorageService>();
      await storage.signOut();
      await erpNavigator.to('/signOut');
    } catch (e) {
      emit(MenuErrorState(e.toString()));
    }
  }
}
