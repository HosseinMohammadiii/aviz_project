import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';
import 'package:dartz/dartz.dart';

import '../../add_advertising/Data/model/ad_gallery.dart';
import '../Data/model/ad_detail.dart';

abstract class AdFeaturesState {}

abstract class AdImagesState {}

final class AdDetailInitializeState extends AdFeaturesState {}

final class AdDetailLoadingState extends AdFeaturesState {}

final class AdDetailRequestSuccessState extends AdFeaturesState {
  Either<String, List<AdvertisingFeatures>> advertisingdetails;
  Either<String, List<AdvertisingFacilities>> advertisingFacilitiesList;
  AdDetailRequestSuccessState(
    this.advertisingdetails,
    this.advertisingFacilitiesList,
  );
}

final class AdFacilitiesFuturesDataState extends AdFeaturesState {
  Either<String, List<AdvertisingFacilities>> advertisingFacilities;
  Either<String, List<AdvertisingFeatures>> advertisingFeatures;
  AdFacilitiesFuturesDataState(
      this.advertisingFacilities, this.advertisingFeatures);
}

final class AdImagesInitializeState extends AdImagesState {}

final class AdImagesLoadingState extends AdImagesState {}

class AdGalleryImagesDataState extends AdImagesState {
  Either<String, List<RegisterFutureAdGallery>> displayImagesAdvertising;

  AdGalleryImagesDataState(this.displayImagesAdvertising);
}

class UserAdvertisingImageDataState extends AdImagesState {
  Either<String, List<RegisterFutureAdGallery>> displayImageAdvertising;

  UserAdvertisingImageDataState(this.displayImageAdvertising);
}
