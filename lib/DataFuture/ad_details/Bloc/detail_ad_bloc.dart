import 'package:aviz_project/DataFuture/ad_details/Data/repository/ad_detail_repository.dart';
import 'package:bloc/bloc.dart';

import 'detail_ad_event.dart';
import 'detail_ad_state.dart';

class AdFeaturesBloc extends Bloc<AdFeaturesEvent, AdFeaturesState> {
  final IAddDetailFuturesRepository repository;
  AdFeaturesBloc(this.repository) : super(AdDetailInitializeState()) {
    on<AdFeaturesGetInitializeData>(
      (event, emit) async {
        emit(AdDetailLoadingState());
        var adFeatures = await repository.getAdvertisinFeatures(event.adId);
        var adFacilities = await repository.getAdvertisinFacilities(event.adId);
        var adFacilitiesList =
            await repository.getAdvertisinFacilities(event.adId);
        emit(AdDetailRequestSuccessState(
          adFeatures,
          adFacilities,
          adFacilitiesList,
        ));
      },
    );
  }
}
