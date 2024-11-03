import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:dio/dio.dart';

import '../../../ad_details/Data/model/ad_facilities.dart';
import '../../../add_advertising/Data/model/register_future_ad.dart';
import '../../../advertising_save/model/advertising_save.dart';

abstract class IHomeDataSoure {
  Future<List<RegisterFutureAd>> getAdvertising();
  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities();
  Future<List<AdvertisingSave>> getSaveAd();
}

class HomeRemoteDataSource extends IHomeDataSoure {
  final Dio dio;
  HomeRemoteDataSource(this.dio);

  @override
  Future<List<RegisterFutureAd>> getAdvertising() async {
    try {
      var response = await dio.get(
        'advertising_home',
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

  @override
  Future<List<AdvertisingSave>> getSaveAd() async {
    try {
      var response = await dio.get(
        'adsave',
      );

      return response.data['items']
          .map<AdvertisingSave>(
            (jsonObject) => AdvertisingSave.fromJsonObject(jsonObject),
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
