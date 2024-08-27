import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/home/Data/datasource/home_datasource.dart';
import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dartz/dartz.dart';

import '../../../ad_details/Data/model/ad_detail.dart';

abstract class IHomeRepository {
  Future<Either<String, List<AdvertisingHome>>> getAdvertising();
  Future<Either<String, List<AdvertisingHome>>> getHotAdvertising();
  Future<Either<String, List<AdvertisingHome>>> getRecentAdvertising();
  Future<Either<String, List<AdvertisingFeatures>>> getAdvertisingDetail();
}

class HomeRepository extends IHomeRepository {
  IHomeDataSoure dataSoure;

  HomeRepository(this.dataSoure);
  @override
  Future<Either<String, List<AdvertisingHome>>> getHotAdvertising() async {
    try {
      var response = await dataSoure.getHotAdvertising();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingHome>>> getRecentAdvertising() async {
    try {
      var response = await dataSoure.getRecentAdvertising();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingHome>>> getAdvertising() async {
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
}
