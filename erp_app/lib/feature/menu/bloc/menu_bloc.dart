import 'dart:convert';
import 'dart:math';

import 'package:erp_app/core/messengers_services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models_package/Data/Auth/Menu/dto.dart';
import 'package:services_package/extension/exception_handler_service.dart';
import 'package:services_package/auth/menu/menu_service.dart';

import '../../../core/network/injection_container.dart';
import 'menu_event.dart';
import 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuService getMenuUseCase;

  MenuBloc({required this.getMenuUseCase}) : super(const MenuInitial()) {
    on<LoadMenuEvent>(_onLoadMenu);
    on<MenuErrorEvent>(_onMenuError);
  }

  Future<void> _onMenuError(MenuErrorEvent event, Emitter<MenuState> emit) async {
    final snack = sl<SnackBarService>();
    snack.showError(
      event.message ?? "error",
      duration: Duration(seconds: 5),
      buttons: null,
    );
  }

  Future<void> _onLoadMenu(LoadMenuEvent event, Emitter<MenuState> emit) async {
    emit(const MenuLoadingState());
    try {
      final menus = await getMenuUseCase
          .get(Request(menuType: 1), (json) => Response.fromJson(json))
          .withExceptionHandler(
            sender: this,
            errorMessage: 'خطا هنگام گرفتن عدد',
            defaultValue: Response(
              error: e.toString(),
            ), // اگر خطا رخ داد این مقدار برگردد
          );

      if (menus == null || menus.data == null) {
        emit(MenuErrorState('Menu Is Null'));
        return;
      } else {
        emit(MenuLoadedState(menus.data ?? []));
      }
    } catch (e) {
      emit(MenuErrorState(e.toString()));
    }
  }
}
