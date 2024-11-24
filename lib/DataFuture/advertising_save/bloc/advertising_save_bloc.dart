import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_event.dart';
import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_state.dart';
import 'package:aviz_project/DataFuture/advertising_save/repository/advertising_save_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SaveAdBloc extends Bloc<SaveAdEvent, SaveAdState> {
  ISaveAdRepository repository;
  SaveAdBloc(this.repository) : super(GetInitializedSaveData()) {
    on<GetInitializedSaveDataEvent>((event, emit) async {
      try {
        emit(SaveLoadingState());
        var displaySaveAd = await repository.getSaveAd();
        var displayAdvertising = await repository.getDisplayAd();
        var advertisingFacilities =
            await repository.getDiplayAdvertisingFacilities();

        emit(GetSaveState(
          displaySaveAd,
          displayAdvertising,
          advertisingFacilities,
        ));
      } catch (e) {
        emit(SaveHandleErrorState());
      }
    });
    on<GetInitializedExistsSaveDataEvent>(
      (event, emit) async {
        try {
          emit(SaveLoadingState());
          var existsSaveAd = await repository.getSaveAd();
          emit(GetExistsSaveState(existsSaveAd));
        } catch (e) {
          emit(SaveHandleErrorState());
        }
      },
    );
    on<PostSaveAdEvent>(
      (event, emit) async {
        try {
          emit(SaveLoadingState());
          var postSaveAd = await repository.postSaveAd(event.id);
          emit(PostSaveAdState(postSaveAd));
        } catch (e) {
          emit(SaveHandleErrorState());
        }
      },
    );
    on<DeleteSaveAdEvent>(
      (event, emit) async {
        try {
          emit(SaveLoadingState());
          var deleteSaveAd = await repository.deleteSaveAd(event.id);
          emit(DeleteSaveAdState(deleteSaveAd));
        } catch (e) {
          emit(SaveHandleErrorState());
        }
      },
    );
    on<ExistsSaveAdEvent>(
      (event, emit) async {
        try {
          emit(SaveLoadingState());
          var existsSaveAd =
              await repository.existsSaveAd(event.userId, event.id);
          emit(ExistsSaveAdState(existsSaveAd));
        } catch (e) {
          emit(SaveHandleErrorState());
        }
      },
    );
  }
}
