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
      var advertisingGallery = await repository.getDiplayImagesAd();

      emit(GetSaveState(
        displaySaveAd,
        displayAdvertising,
        advertisingGallery,
        advertisingFacilities,
      ));
    });
    on<PostSaveAdEvent>(
      (event, emit) async {
        await repository.postSaveAd(event.id);
      },
    );
    on<DeleteSaveAdEvent>(
      (event, emit) async {
        await repository.deleteSaveAd(event.id);
        emit(SaveLoadingState());
        var displaySaveAd = await repository.getSaveAd();
        var displayAdvertising = await repository.getDisplayRecentAd();
        var advertisingFacilities =
            await repository.getDiplayAdvertisingFacilities();
        var advertisingGallery = await repository.getDiplayImagesAd();

        emit(GetSaveState(
          displaySaveAd,
          displayAdvertising,
          advertisingGallery,
          advertisingFacilities,
        ));
      },
    );
  }
}
