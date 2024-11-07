import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_event.dart';
import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_state.dart';
import 'package:aviz_project/DataFuture/advertising_save/repository/advertising_save_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SaveAdBloc extends Bloc<SaveAdEvent, SaveAdState> {
  ISaveAdRepository repository;
  SaveAdBloc(this.repository) : super(GetInitializedSaveData()) {
    on<GetInitializedSaveDataEvent>((event, emit) async {
      emit(SaveLoadingState());
      var displaySaveAd = await repository.getSaveAd();
      var displayAdvertising = await repository.getDisplayRecentAd();
      var advertisingFacilities =
          await repository.getDiplayAdvertisingFacilities();

      emit(GetSaveState(
        displaySaveAd,
        displayAdvertising,
        advertisingFacilities,
      ));
    });
    on<GetInitializedExistsSaveDataEvent>(
      (event, emit) async {
        emit(SaveLoadingState());
        var existsSaveAd = await repository.getSaveAd();
        emit(GetExistsSaveState(existsSaveAd));
      },
    );
    on<PostSaveAdEvent>(
      (event, emit) async {
        emit(SaveLoadingState());
        var postSaveAd = await repository.postSaveAd(event.id);
        emit(PostSaveAdState(postSaveAd));
      },
    );
    on<DeleteSaveAdEvent>(
      (event, emit) async {
        emit(SaveLoadingState());
        var deleteSaveAd = await repository.deleteSaveAd(event.id);
        emit(DeleteSaveAdState(deleteSaveAd));
      },
    );
    on<ExistsSaveAdEvent>(
      (event, emit) async {
        emit(SaveLoadingState());
        var existsSaveAd =
            await repository.existsSaveAd(event.userId, event.id);
        emit(ExistsSaveAdState(existsSaveAd));
      },
    );
  }
}
