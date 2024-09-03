import 'package:aviz_project/DataFuture/home/Data/datasource/home_detail_datasourse.dart';
import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../ad_details/Data/model/ad_facilities.dart';

abstract class IHomeDetailRepository {
  Future<Either<String, List<AdvertisingFacilities>>>
      getDiplayAdvertisingFacilities(String id);
}

class HomeDetialRepository extends IHomeDetailRepository {
  IHomeDetailDataSource dataSource;
  HomeDetialRepository(this.dataSource);
  @override
  Future<Either<String, List<AdvertisingFacilities>>>
      getDiplayAdvertisingFacilities(String id) async {
    try {
      var response = await dataSource.getDiplayAdvertisingFacilities(id);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
