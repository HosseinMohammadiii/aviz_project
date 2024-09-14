import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:aviz_project/DataFuture/advertising_save/model/advertising_save.dart';
import 'package:dartz/dartz.dart';

import '../../ad_details/Data/model/ad_facilities.dart';
import '../../add_advertising/Data/model/ad_gallery.dart';

abstract class SaveAdState {}

final class GetInitializedSaveData extends SaveAdState {}

final class SaveLoadingState extends SaveAdState {}

final class GetSaveState extends SaveAdState {
  Either<String, List<AdvertisingSave>> getSaveAd;
  Either<String, List<RegisterFutureAd>> getDisplayAd;
  Either<String, List<RegisterFutureAdGallery>> advertisingGalleryDetails;
  Either<String, List<AdvertisingFacilities>> advertisingFacilitiesDetails;
  GetSaveState(
    this.getSaveAd,
    this.getDisplayAd,
    this.advertisingGalleryDetails,
    this.advertisingFacilitiesDetails,
  );
}

final class PostSaveAdState extends SaveAdState {
  Either<String, String> postRecentAd;
  PostSaveAdState(this.postRecentAd);
}
