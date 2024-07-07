import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_detail.dart';
import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../datasource/ad_detail_datasource.dart';
import '../model/ad_facilities.dart';

abstract class IAddDetailFuturesRepository {
  Future<Either<String, List<AdvertisingFeatures>>> getAdvertisinFeatures(
      String adId);
  Future<Either<String, List<AdvertisingFacilities>>> getAdvertisinFacilities(
      String adId);
  Future<Either<String, List<AdvertisingFacilities>>>
      getAdvertisinFacilitiesList();
}

class AdDetailRepository extends IAddDetailFuturesRepository {
  IAdvertisingFeaturesDataSoure dataSoure;
  AdDetailRepository(this.dataSoure);
  @override
  Future<Either<String, List<AdvertisingFeatures>>> getAdvertisinFeatures(
      String adId) async {
    try {
      var response = await dataSoure.getAdvertisinFeatures(adId);
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingFacilities>>> getAdvertisinFacilities(
      String adId) async {
    try {
      var response = await dataSoure.getAdvertisinFacilities(adId);
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingFacilities>>>
      getAdvertisinFacilitiesList() async {
    try {
      var response = await dataSoure.getAdvertisinFacilitiesList();
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
