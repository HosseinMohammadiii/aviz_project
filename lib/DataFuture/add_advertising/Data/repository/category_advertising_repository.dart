import 'package:aviz_project/DataFuture/add_advertising/Data/datasource/category_advertising_datasource.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/model/category_advertising.dart';
import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';

abstract class ICategoryAdvertisingRepository {
  Future<Either<String, List<CategoryAdvertising>>> getCategoryAdvertising();
  Future<Either<String, void>> postCategoryAdvertising(String ctName);
}

class CategoryAdvertisingRepository extends ICategoryAdvertisingRepository {
  ICategoryAdvertisingDatasource datasource;
  CategoryAdvertisingRepository(this.datasource);
  @override
  Future<Either<String, List<CategoryAdvertising>>>
      getCategoryAdvertising() async {
    try {
      var response = await datasource.getCategory();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, void>> postCategoryAdvertising(String ctName) async {
    try {
      var response = await datasource.postCategory(ctName);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
