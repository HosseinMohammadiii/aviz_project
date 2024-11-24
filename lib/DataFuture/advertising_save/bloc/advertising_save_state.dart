import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:aviz_project/DataFuture/advertising_save/model/advertising_save.dart';
import 'package:dartz/dartz.dart';

import '../../ad_details/Data/model/ad_facilities.dart';

abstract class SaveAdState {}

abstract class ExistSaveAdState {}

final class GetInitializedSaveData extends SaveAdState {}

final class SaveHandleErrorState extends SaveAdState {}

final class SaveLoadingState extends SaveAdState {}

final class GetSaveState extends SaveAdState {
  Either<String, List<AdvertisingSave>> getSaveAd;
  Either<String, List<RegisterFutureAd>> getDisplayAd;
  Either<String, List<AdvertisingFacilities>> advertisingFacilitiesDetails;
  GetSaveState(
    this.getSaveAd,
    this.getDisplayAd,
    this.advertisingFacilitiesDetails,
  );
}

final class GetExistsSaveState extends SaveAdState {
  Either<String, List<AdvertisingSave>> getSaveAd;

  GetExistsSaveState(
    this.getSaveAd,
  );
}

final class PostSaveAdState extends SaveAdState {
  Either<String, String> postSaveAd;
  PostSaveAdState(this.postSaveAd);
}

final class DeleteSaveAdState extends SaveAdState {
  Either<String, String> deleteSaveAd;
  DeleteSaveAdState(this.deleteSaveAd);
}

final class ExistsSaveAdState extends SaveAdState {
  Either<String, String> existsSaveAd;
  ExistsSaveAdState(this.existsSaveAd);
}
