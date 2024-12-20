import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/advertising_save/model/advertising_save.dart';
import 'package:aviz_project/Hive/Advertising/register_id.dart';
import 'package:dio/dio.dart';

import '../../ad_details/Data/model/ad_facilities.dart';
import '../../add_advertising/Data/model/register_future_ad.dart';

abstract class ISaveAdItemsDatasource {
  Future<List<RegisterFutureAd>> getDisplayAd();

  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities();

  Future<List<AdvertisingSave>> getSaveAd();
  Future<String> postSaveAd(String adId);
  Future<String> deleteSaveAd(String adId);
  Future<String> existsSaveAd(String userId, String id);
}

final class ISaveAdItemsDatasourceRemoot extends ISaveAdItemsDatasource {
  final Dio dio;
  ISaveAdItemsDatasourceRemoot(this.dio);
  @override
  Future<List<RegisterFutureAd>> getDisplayAd() async {
    try {
      var recent = await dio.get(
        'advertising_home',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );

      return recent.data['items']
          .map<RegisterFutureAd>(
            (jsonObject) => RegisterFutureAd.fromJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode ?? 0, ex.message ?? 'Error');
    } catch (ex) {
      throw ApiException(0, 'Unknown');
    }
  }

  @override
  Future<String> postSaveAd(String adId) async {
    try {
      Map<String, dynamic> query = {
        'filter': 'user_id=${Authmanager().getId()} & id_ad=$adId'
      };

      var response = await dio.get(
        'adsave',
        queryParameters: query,
      );

      if (response.data['items'].isEmpty) {
        var save = await dio.post(
          'adsave',
          data: {
            'user_id': Authmanager().getId(),
            'id_ad': adId,
          },
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ),
        );
        RegisterId().saveId(save.data['data']['id']);

        return save.data['data']['id'];
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode ?? 0, ex.message ?? 'Error');
    } catch (ex) {
      throw ApiException(0, 'Unknown');
    }
    return '';
  }

  @override
  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities() async {
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

  @override
  Future<List<AdvertisingSave>> getSaveAd() async {
    try {
      Map<String, String> query = {
        'filter': 'user_id=${Authmanager().getId()}',
        'sort': 'updated'
      };

      var response = await dio.get(
        'adsave',
        queryParameters: query,
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );

      return response.data['items']
          .map<AdvertisingSave>(
              (jsonObject) => AdvertisingSave.fromJsonObject(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }

  @override
  Future<String> deleteSaveAd(String adId) async {
    try {
      await dio.delete(
        'adsave/$adId',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return '';
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }

  @override
  Future<String> existsSaveAd(String userId, String id) async {
    try {
      Map<String, dynamic> query = {'filter': 'user_id=$userId & id_ad=$id'};
      var response = await dio.get(
        'adsave',
        queryParameters: query,
      );

      if (response.data['items'].isNotEmpty) {
        return response.data['items'][0]['id_ad'];
      } else {
        return '';
      }
    } on DioException catch (ex) {
      throw ApiException(
        ex.response?.statusCode ?? 0,
        ex.response?.statusMessage ?? 'Error',
      );
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }
}
