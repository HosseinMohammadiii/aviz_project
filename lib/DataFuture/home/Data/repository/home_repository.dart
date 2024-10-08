import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/home/Data/datasource/home_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../ad_details/Data/model/ad_detail.dart';
import '../../../ad_details/Data/model/ad_facilities.dart';
import '../../../add_advertising/Data/model/ad_gallery.dart';
import '../../../add_advertising/Data/model/register_future_ad.dart';
import '../../../advertising_save/model/advertising_save.dart';

abstract class IHomeRepository {
  Future<Either<String, List<RegisterFutureAd>>> getAdvertising();
  Future<Either<String, List<RegisterFutureAd>>> getHotAdvertising();
  Future<Either<String, List<RegisterFutureAd>>> getRecentAdvertising();
  Future<Either<String, List<AdvertisingFeatures>>> getAdvertisingDetail();
  Future<Either<String, List<RegisterFutureAdGallery>>> getDiplayImagesAd();
  Future<Either<String, List<AdvertisingFacilities>>> getDiplayFacilitiesAd();
  Future<Either<String, List<AdvertisingSave>>> getSaveAd();
}

class HomeRepository extends IHomeRepository {
  IHomeDataSoure dataSoure;

  HomeRepository(this.dataSoure);
  @override
  Future<Either<String, List<RegisterFutureAd>>> getHotAdvertising() async {
    try {
      var response = await dataSoure.getHotAdvertising();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<RegisterFutureAd>>> getRecentAdvertising() async {
    try {
      var response = await dataSoure.getRecentAdvertising();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<RegisterFutureAd>>> getAdvertising() async {
    try {
      var response = await dataSoure.getAdvertising();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingFeatures>>>
      getAdvertisingDetail() async {
    try {
      var response = await dataSoure.getAdvertisinFeatures();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<RegisterFutureAdGallery>>>
      getDiplayImagesAd() async {
    try {
      var response = await dataSoure.getDiplayImagesAd();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingFacilities>>>
      getDiplayFacilitiesAd() async {
    try {
      var response = await dataSoure.getDiplayAdvertisingFacilities();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingSave>>> getSaveAd() async {
    try {
      var response = await dataSoure.getSaveAd();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
