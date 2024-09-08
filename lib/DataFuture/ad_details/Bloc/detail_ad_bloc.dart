import 'package:aviz_project/DataFuture/ad_details/Data/repository/ad_detail_repository.dart';
import 'package:bloc/bloc.dart';

import 'detail_ad_event.dart';
import 'detail_ad_state.dart';

class AdHomeFeaturesBloc extends Bloc<AdFeaturesEvent, AdFeaturesState> {
  final IAddDetailFuturesRepository repository;
  AdHomeFeaturesBloc(this.repository) : super(AdDetailInitializeState()) {
    on<AdFeaturesGetInitializeData>(
      (event, emit) async {
        emit(AdDetailLoadingState());
        var adFeatures =
            await repository.getAdvertisinFeatures(event.idFeatures);
        var adFacilitiesList =
            await repository.getAdvertisinFacilities(event.facilitiesId);
        emit(AdDetailRequestSuccessState(
          adFeatures,
          adFacilitiesList,
        ));
      },
    );
  }
}

class AdImagesHomeBloc extends Bloc<UserAdEvent, AdImagesState> {
  final IAddDetailFuturesRepository repository;
  AdImagesHomeBloc(this.repository) : super(AdImagesInitializeState()) {
    on<AdGalleryImagesDataEvent>(
      (event, emit) async {
        var adGallery = await repository.getDiplayImagesAd(event.id);
        emit(AdGalleryImagesDataState(adGallery));
      },
    );
    on<AdImageListHomeEvent>(
      (event, emit) async {
        var adGallery = await repository.getDiplayImagesAd(event.id);
        emit(UserAdvertisingImageDataState(adGallery));
      },
    );
  }
}
