import 'package:aviz_project/DataFuture/add_advertising/Data/model/ad_gallery.dart';
import 'package:aviz_project/DataFuture/advertising_save/model/advertising_save.dart';
import 'package:dartz/dartz.dart';

import '../../ad_details/Data/model/ad_detail.dart';
import '../../ad_details/Data/model/ad_facilities.dart';
import '../../add_advertising/Data/model/register_future_ad.dart';

abstract class HomeState {}

final class HomeInitializeState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeRequestSuccessState extends HomeState {
  Either<String, List<RegisterFutureAd>> getAdvertising;
  Either<String, List<RegisterFutureAd>> hotAdvertising;
  Either<String, List<RegisterFutureAd>> recentAdvertising;

  Either<String, List<AdvertisingFeatures>> advertisingdetails;
  Either<String, List<RegisterFutureAdGallery>> advertisingGalleryDetails;
  Either<String, List<AdvertisingFacilities>> advertisingFacilities;
  Either<String, List<AdvertisingSave>> advertisingSave;

  HomeRequestSuccessState(
    this.getAdvertising,
    this.hotAdvertising,
    this.recentAdvertising,
    this.advertisingdetails,
    this.advertisingGalleryDetails,
    this.advertisingFacilities,
    this.advertisingSave,
  );
}

final class HomeFuturesDataState extends HomeState {
  Either<String, AdvertisingFacilities> advertisingFacilities;
  HomeFuturesDataState(this.advertisingFacilities);
}
