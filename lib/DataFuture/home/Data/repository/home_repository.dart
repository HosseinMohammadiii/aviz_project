import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/home/Data/datasource/home_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../ad_details/Data/model/ad_facilities.dart';
import '../../../add_advertising/Data/model/register_future_ad.dart';

abstract class IHomeRepository {
  Future<Either<String, List<RegisterFutureAd>>> getAdvertising();
  Future<Either<String, List<AdvertisingFacilities>>> getDiplayFacilitiesAd();
}

class HomeRepository extends IHomeRepository {
  IHomeDataSoure dataSoure;

  HomeRepository(this.dataSoure);

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
  Future<Either<String, List<AdvertisingFacilities>>>
      getDiplayFacilitiesAd() async {
    try {
      var response = await dataSoure.getDiplayAdvertisingFacilities();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
