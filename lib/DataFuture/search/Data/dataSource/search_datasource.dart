import 'package:dio/dio.dart';

import '../../../../Hive/Advertising/register_id.dart';
import '../../../NetworkUtil/api_exeption.dart';
import '../../../NetworkUtil/authmanager.dart';
import '../../../ad_details/Data/model/ad_facilities.dart';
import '../../../add_advertising/Data/model/register_future_ad.dart';

abstract class ISearchDataSource {
  Future<List<RegisterFutureAd>> getSearchResult(String query);
  Future<List<AdvertisingFacilities>> getAdFacilities();
  Future<String> getExistsAdvertising(String id);
}

class SearchRemootDataSorce extends ISearchDataSource {
  final Dio dio;
  SearchRemootDataSorce(this.dio);
  @override
  Future<List<RegisterFutureAd>> getSearchResult(String query) async {
    try {
      Map<String, dynamic> queryPromotion = {
        'filter':
            'title~"$query"&province=${RegisterId().getProvince()}&city=${RegisterId().getCity()}',
        'sort': 'updated'
      };
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
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );
      return response.data['items'][0]['ad_id'];
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }

  @override
  Future<List<AdvertisingFacilities>> getAdFacilities() async {
    try {
      var response = await dio.get(
        'facilities',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );
      return response.data['items']
          .map<AdvertisingFacilities>(
              (jsonObject) => AdvertisingFacilities.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }
}
