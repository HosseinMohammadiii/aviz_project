import 'package:dartz/dartz.dart';

import '../../ad_details/Data/model/ad_facilities.dart';
import '../../add_advertising/Data/model/register_future_ad.dart';

abstract class HomeState {}

final class HomeInitializeState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeRequestSuccessState extends HomeState {
  Either<String, List<RegisterFutureAd>> getAdvertising;
  Either<String, List<AdvertisingFacilities>> advertisingFacilities;

  HomeRequestSuccessState(
    this.getAdvertising,
    this.advertisingFacilities,
  );
}

final class HomeFuturesDataState extends HomeState {
  Either<String, AdvertisingFacilities> advertisingFacilities;
  HomeFuturesDataState(this.advertisingFacilities);
}
