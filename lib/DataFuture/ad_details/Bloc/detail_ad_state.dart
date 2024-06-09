import 'package:dartz/dartz.dart';

import '../Data/model/ad_detail.dart';

abstract class AdFeaturesState {}

final class AdDetailInitializeState extends AdFeaturesState {}

final class AdDetailLoadingState extends AdFeaturesState {}

final class AdDetailRequestSuccessState extends AdFeaturesState {
  Either<String, List<AdvertisingFeatures>> advertisingdetails;
  AdDetailRequestSuccessState(this.advertisingdetails);
}
