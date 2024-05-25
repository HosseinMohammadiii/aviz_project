import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/home/Data/datasource/home_datasource.dart';
import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dartz/dartz.dart';

abstract class IHomeRepository {
  Future<Either<String, List<AdvertisingHome>>> getAdvertising();
  Future<Either<String, List<AdvertisingHome>>> getHotAdvertising();
  Future<Either<String, List<AdvertisingHome>>> getRecentAdvertising();
}

class HomeRepository extends IHomeRepository {
  IHomeDataSoure dataSoure;

  HomeRepository(this.dataSoure);
  @override
  Future<Either<String, List<AdvertisingHome>>> getHotAdvertising() async {
    try {
      var response = await dataSoure.getHotAdvertising();
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingHome>>> getRecentAdvertising() async {
    try {
      var response = await dataSoure.getRecentAdvertising();
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingHome>>> getAdvertising() async {
    try {
      var response = await dataSoure.getAdvertising();
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
