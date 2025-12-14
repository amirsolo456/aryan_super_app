

import 'package:bloc/bloc.dart';
import 'package:erp_app/feature/default_page/Place/bloc/place_event.dart';
import 'package:erp_app/feature/default_page/Place/bloc/place_state.dart';
import 'package:models_package/Data/Default/mng/select/place/place_dto.dart';
import 'package:services_package/Repo_ViewId/repo_view_id.dart';
import 'package:services_package/default/mng/select/place_service.dart';



class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceService getPlaceUseCase;

  PlaceBloc({required this.getPlaceUseCase})
      : super(const PlaceInitial()) {
    on<LoadPlaceEvent>(_onLoadPlace);
  }

  Future<void> _onLoadPlace(
      LoadPlaceEvent event,
      Emitter<PlaceState> emit,
      ) async {
    emit(const PlaceLoading());
    try {
      final places = await getPlaceUseCase.get(
        Request(repoViewId: AppConstants().PlaceRepoViewId),
            (json) => Response.fromJson(json),
      );

      if (places == null || places.data == null) {
        emit(PlaceError('Place Is Null'));
        return;
      }
      emit(PlaceLoaded(places!.data ?? []));


    } catch (e) {
      emit(PlaceError(e.toString()));
    }
  }
}
