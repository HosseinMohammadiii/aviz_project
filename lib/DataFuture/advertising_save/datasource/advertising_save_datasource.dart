import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/advertising_save/model/advertising_save.dart';
import 'package:aviz_project/Hive/Advertising/register_id.dart';
import 'package:dio/dio.dart';

import '../../ad_details/Data/model/ad_facilities.dart';
import '../../add_advertising/Data/model/ad_gallery.dart';
import '../../add_advertising/Data/model/register_future_ad.dart';

abstract class ISaveAdItemsDatasource {
  Future<List<RegisterFutureAd>> getDisplayRecentAd();
  Future<List<RegisterFutureAdGallery>> getDiplayImagesAd();

  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities();

  Future<List<AdvertisingSave>> getSaveAd();
  Future<String> postSaveAd(String adId);
  Future<String> deleteSaveAd(String adId);
}

final class ISaveAdItemsDatasourceRemoot extends ISaveAdItemsDatasource {
  final Dio dio;
  ISaveAdItemsDatasourceRemoot(this.dio);
  @override
  Future<List<RegisterFutureAd>> getDisplayRecentAd() async {
    try {
      var recent = await dio.get(
        'advertising_home',
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
      // print();

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
        // print(RegisterId().getSaveId());
        RegisterId().saveId(save.data['data']['id']);

        return save.data['id'];
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
      Map<String, dynamic> query = {
        'filter': 'user_id="${Authmanager().getId()}"'
      };

      var response = await dio.get(
        'adsave',
        queryParameters: query,
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
  Future<List<RegisterFutureAdGallery>> getDiplayImagesAd() async {
    try {
      var response = await dio.get(
        'advertising_gallery',
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

  @override
  Future<String> deleteSaveAd(String adId) async {
    try {
      var response = await dio.delete(
        'adsave/$adId',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      return response.data['items'];
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }
}
