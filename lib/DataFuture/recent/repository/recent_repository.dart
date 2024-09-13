import 'package:aviz_project/DataFuture/recent/datasource/recent_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../NetworkUtil/api_exeption.dart';
import '../../ad_details/Data/model/ad_facilities.dart';
import '../../add_advertising/Data/model/ad_gallery.dart';
import '../../add_advertising/Data/model/register_future_ad.dart';
import '../model/recent_model.dart';

abstract class IRecentRepository {
  Future<Either<String, List<RegisterFutureAd>>> getDisplayRecentAd();
  Future<Either<String, List<AdvertisingFacilities>>>
      getDiplayAdvertisingFacilities();

  Future<Either<String, List<RegisterFutureAdGallery>>> getDiplayImagesAd();

  Future<Either<String, List<RecentModel>>> getRecentAd();

  Future<Either<String, String>> postRecentAd(String adId);
}

final class IRecentRepositoryRemoot extends IRecentRepository {
  final IRecentAdItems datasource;
  IRecentRepositoryRemoot(this.datasource);

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
  Future<Either<String, String>> postRecentAd(String adId) async {
    try {
      var response = await datasource.postRecentAd(adId);
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
  Future<Either<String, List<RecentModel>>> getRecentAd() async {
    try {
      var response = await datasource.getRecentAd();
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
}
