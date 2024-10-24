import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:aviz_project/DataFuture/advertising_save/model/advertising_save.dart';
import 'package:aviz_project/DataFuture/recent/model/recent_model.dart';
import 'package:dartz/dartz.dart';

import '../../ad_details/Data/model/ad_facilities.dart';

abstract class RecentState {}

final class GetInitializedData extends RecentState {}

final class RecentLoadingState extends RecentState {}

final class GetRecentState extends RecentState {
  Either<String, List<RecentModel>> getRecentAd;
  Either<String, List<RegisterFutureAd>> getDisplayAd;
  Either<String, List<AdvertisingFacilities>> advertisingFacilitiesDetails;
  Either<String, List<AdvertisingSave>> advertisingSaveDetails;
  GetRecentState(
    this.getRecentAd,
    this.getDisplayAd,
    this.advertisingFacilitiesDetails,
    this.advertisingSaveDetails,
  );
}

final class PostRecentState extends RecentState {
  Either<String, String> postRecentAd;
  PostRecentState(this.postRecentAd);
}
