import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/province/model/province.dart';
import 'package:dartz/dartz.dart';

import '../datasource/province_datasource.dart';

abstract class IProvinceRepository {
  Future<Either<String, List<ProvinceModel>>> provices(String? province);
  Future<Either<String, List<ProvinceModel>>> provicesCities(String? city);
}

final class ProvinceRepositoryRemoot extends IProvinceRepository {
  IProvinceDatasource datasource;
  ProvinceRepositoryRemoot(this.datasource);
  @override
  Future<Either<String, List<ProvinceModel>>> provices(String? province) async {
    try {
      var response = await datasource.provices(province);

      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<ProvinceModel>>> provicesCities(
      String? city) async {
    try {
      var response = await datasource.provicesCities(city);

      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
