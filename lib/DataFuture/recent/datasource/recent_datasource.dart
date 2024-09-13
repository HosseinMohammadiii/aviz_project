import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:dio/dio.dart';

import '../../ad_details/Data/model/ad_facilities.dart';
import '../../add_advertising/Data/model/ad_gallery.dart';
import '../../add_advertising/Data/model/register_future_ad.dart';
import '../model/recent_model.dart';

abstract class IRecentAdItems {
  Future<List<RegisterFutureAd>> getDisplayRecentAd();
  Future<List<RegisterFutureAdGallery>> getDiplayImagesAd();

  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities();

  Future<List<RecentModel>> getRecentAd();
  Future<String> postRecentAd(String adId);
}

final class IRecentAdItemsDatasourceRemoot extends IRecentAdItems {
  final Dio dio;
  IRecentAdItemsDatasourceRemoot(this.dio);
  @override
  Future<List<RegisterFutureAd>> getDisplayRecentAd() async {
    try {
      var recent = await dio.get(
        'collections/inforegisteredhomes/records',
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
  Future<String> postRecentAd(String adId) async {
    try {
      Map<String, dynamic> query = {
        'filter': 'user_id="${Authmanager().getId()}" && id_ad="$adId"'
      };

      var response = await dio.get(
        'collections/recent_ad_items/records',
        queryParameters: query,
      );

      if (response.data['items'].isEmpty) {
        var recent = await dio.post(
          'collections/recent_ad_items/records',
          data: {
            'user_id': Authmanager().getId(),
            'id_ad': adId,
          },
        );
        return recent.data['id'];
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
        'collections/facilities/records',
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
  Future<List<RecentModel>> getRecentAd() async {
    try {
      Map<String, dynamic> query = {
        'filter': 'user_id="${Authmanager().getId()}"'
      };

      var response = await dio.get(
        'collections/recent_ad_items/records',
        queryParameters: query,
      );
      return response.data['items']
          .map<RecentModel>(
              (jsonObject) => RecentModel.fromJsonObject(jsonObject))
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
