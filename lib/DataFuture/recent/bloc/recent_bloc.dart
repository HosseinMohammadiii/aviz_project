import 'package:aviz_project/DataFuture/recent/bloc/recent_event.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_state.dart';
import 'package:aviz_project/DataFuture/recent/repository/recent_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  IRecentRepository repository;
  RecentBloc(this.repository) : super(GetInitializedData()) {
    on<GetInitializedDataEvent>((event, emit) async {
      emit(RecentLoadingState());
      var displayRecetAd = await repository.getRecentAd();
      var displayAdvertising = await repository.getDisplayRecentAd();
      var advertisingFacilities =
          await repository.getDiplayAdvertisingFacilities();
      var advertisingGallery = await repository.getDiplayImagesAd();

      emit(GetRecentState(
        displayRecetAd,
        displayAdvertising,
        advertisingGallery,
        advertisingFacilities,
      ));
    });
  }
}
