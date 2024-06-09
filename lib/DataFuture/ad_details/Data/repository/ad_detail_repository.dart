import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_detail.dart';
import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../datasource/ad_detail_datasource.dart';

abstract class IAddDetailFuturesRepository {
  Future<Either<String, List<AdvertisingFeatures>>> getAdvertisinFeatures(
      String adId);
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
}
