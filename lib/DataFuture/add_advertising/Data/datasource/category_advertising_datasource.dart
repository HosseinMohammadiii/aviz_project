import 'package:aviz_project/DataFuture/add_advertising/Data/model/category_advertising.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';

abstract class ICategoryAdvertisingDatasource {
  Future<List<CategoryAdvertising>> getCategory();
  Future<void> postCategory(String ctName);
}

class CategoryAdvertisingRemoot extends ICategoryAdvertisingDatasource {
  Dio dio;
  CategoryAdvertisingRemoot(this.dio);
  @override
  Future<List<CategoryAdvertising>> getCategory() async {
    try {
      var response = await dio.get('collections/category/records');
      return response.data['items']
          .map<CategoryAdvertising>(
            (jsonObject) => CategoryAdvertising.fromJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
  }

  @override
  Future<void> postCategory(String ctName) async {
    try {
      await dio.post('collections/category/records', data: {
        'category_name': ctName,
      });
    } on DioException catch (ex) {
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
  }
}
