import 'package:aviz_project/DataFuture/advertising_save/datasource/advertising_save_datasource.dart';
import 'package:aviz_project/DataFuture/advertising_save/model/advertising_save.dart';
import 'package:dartz/dartz.dart';

import '../../NetworkUtil/api_exeption.dart';
import '../../ad_details/Data/model/ad_facilities.dart';
import '../../add_advertising/Data/model/ad_gallery.dart';
import '../../add_advertising/Data/model/register_future_ad.dart';

abstract class ISaveAdRepository {
  Future<Either<String, List<RegisterFutureAd>>> getDisplayRecentAd();
  Future<Either<String, List<AdvertisingFacilities>>>
      getDiplayAdvertisingFacilities();

  Future<Either<String, List<RegisterFutureAdGallery>>> getDiplayImagesAd();

  Future<Either<String, List<AdvertisingSave>>> getSaveAd();

  Future<Either<String, String>> postSaveAd(String adId);
  Future<Either<String, String>> deleteSaveAd(String adId);
}

final class ISaveAdRepositoryRemoot extends ISaveAdRepository {
  final ISaveAdItemsDatasource datasource;
  ISaveAdRepositoryRemoot(this.datasource);

  @override
  Future<Either<String, List<RegisterFutureAd>>> getDisplayRecentAd() async {
    try {
      var response = await datasource.getDisplayRecentAd();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> postSaveAd(String adId) async {
    try {
      var response = await datasource.postSaveAd(adId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingFacilities>>>
      getDiplayAdvertisingFacilities() async {
    try {
      var response = await datasource.getDiplayAdvertisingFacilities();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingSave>>> getSaveAd() async {
    try {
      var response = await datasource.getSaveAd();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<RegisterFutureAdGallery>>>
      getDiplayImagesAd() async {
    try {
      var response = await datasource.getDiplayImagesAd();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> deleteSaveAd(String adId) async {
    try {
      var response = await datasource.deleteSaveAd(adId);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
