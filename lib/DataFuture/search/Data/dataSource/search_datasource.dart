import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../add_advertising/Data/model/ad_gallery.dart';

abstract class ISearchDataSource {
  Future<List<AdvertisingHome>> getSearchResult(String query);
  Future<List<RegisterFutureAdGallery>> getDiplayImagesAd();
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
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }

  @override
  Future<List<RegisterFutureAdGallery>> getDiplayImagesAd() async {
    try {
      var response = await dio.get(
        'collections/advertising_gallery/records',
      );
      return response.data['items']
          .map<RegisterFutureAdGallery>(
            (jsonObject) => RegisterFutureAdGallery.fromJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }
}
