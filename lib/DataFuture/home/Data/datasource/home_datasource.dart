import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:dio/dio.dart';

import '../../../../Hive/Advertising/register_id.dart';
import '../../../NetworkUtil/authmanager.dart';
import '../../../ad_details/Data/model/ad_facilities.dart';
import '../../../add_advertising/Data/model/register_future_ad.dart';

abstract class IHomeDataSoure {
  Future<List<RegisterFutureAd>> getAdvertising();
  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities();
}

class HomeRemoteDataSource extends IHomeDataSoure {
  final Dio dio;
  HomeRemoteDataSource(this.dio);

  @override
  Future<List<RegisterFutureAd>> getAdvertising() async {
    try {
      Map<String, dynamic> query = {
        'filter':
            'province=${RegisterId().getProvince()}&city=${RegisterId().getCity()}'
      };
      var response = await dio.get(
        'advertising_home',
        queryParameters: query,
        options: Options(
          // contentType: Headers.formUrlEncodedContentType,
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
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
  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities() async {
    try {
      var response = await dio.get(
        'facilities',
        options: Options(
          // contentType: Headers.formUrlEncodedContentType,
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
