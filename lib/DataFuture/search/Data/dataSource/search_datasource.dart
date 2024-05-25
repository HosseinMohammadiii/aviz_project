import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';

abstract class ISearchDataSource {
  Future<List<AdvertisingHome>> getSearchResult(String query);
}

class SearchRemootDataSorce extends ISearchDataSource {
  final Dio dio;
  SearchRemootDataSorce(this.dio);
  @override
  Future<List<AdvertisingHome>> getSearchResult(String query) async {
    try {
      Map<String, dynamic> queryPromotion = {'filter': 'home_name~"$query"'};
      var response = await dio.get(
        'collections/home_screen/records',
        queryParameters: queryPromotion,
      );
      return response.data['items']
          .map<AdvertisingHome>(
            (jsonObject) => AdvertisingHome.fromJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
  }
}
