import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_detail.dart';
import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';

class Ad {
  RegisterFutureAd adHome;
  AdvertisingFeatures adFeatures;
  AdvertisingFacilities adFacilities;

  Ad({
    required this.adHome,
    required this.adFeatures,
    required this.adFacilities,
  });
}
