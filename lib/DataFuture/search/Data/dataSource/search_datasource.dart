import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../add_advertising/Data/model/register_future_ad.dart';

abstract class ISearchDataSource {
  Future<List<RegisterFutureAd>> getSearchResult(String query);
  Future<String> getExistsAdvertising(String id);
}

class SearchRemootDataSorce extends ISearchDataSource {
  final Dio dio;
  SearchRemootDataSorce(this.dio);
  @override
  Future<List<RegisterFutureAd>> getSearchResult(String query) async {
    try {
      Map<String, dynamic> queryPromotion = {'filter': 'title~"$query"'};
      var response = await dio.get(
        'advertising_home',
        queryParameters: queryPromotion,
      );

      return response.data['items']
          .map<RegisterFutureAd>(
            (jsonObject) => RegisterFutureAd.fromJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }

  @override
  Future<String> getExistsAdvertising(String id) async {
    try {
      Map<String, dynamic> query = {'filter': 'ad_id=$id'};
      var response = await dio.get(
        'advertising_home',
        queryParameters: query,
      );
      return response.data['items'][0]['ad_id'];
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }
}
