import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:aviz_project/DataFuture/recent/model/recent_model.dart';
import 'package:dartz/dartz.dart';

import '../../ad_details/Data/model/ad_facilities.dart';
import '../../add_advertising/Data/model/ad_gallery.dart';

abstract class RecentState {}

final class GetInitializedData extends RecentState {}

final class RecentLoadingState extends RecentState {}

final class GetRecentState extends RecentState {
  Either<String, List<RecentModel>> getRecentAd;
  Either<String, List<RegisterFutureAd>> getDisplayAd;
  Either<String, List<RegisterFutureAdGallery>> advertisingGalleryDetails;
  Either<String, List<AdvertisingFacilities>> advertisingFacilitiesDetails;
  GetRecentState(
    this.getRecentAd,
    this.getDisplayAd,
    this.advertisingGalleryDetails,
    this.advertisingFacilitiesDetails,
  );
}

final class PostRecentState extends RecentState {
  Either<String, String> postRecentAd;
  PostRecentState(this.postRecentAd);
}
