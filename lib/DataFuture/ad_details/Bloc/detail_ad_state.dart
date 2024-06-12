import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';
import 'package:dartz/dartz.dart';

import '../Data/model/ad_detail.dart';

abstract class AdFeaturesState {}

final class AdDetailInitializeState extends AdFeaturesState {}

final class AdDetailLoadingState extends AdFeaturesState {}

final class AdDetailRequestSuccessState extends AdFeaturesState {
  Either<String, List<AdvertisingFeatures>> advertisingdetails;
  Either<String, List<AdvertisingFacilities>> advertisingFacilities;
  AdDetailRequestSuccessState(
    this.advertisingdetails,
    this.advertisingFacilities,
  );
}
