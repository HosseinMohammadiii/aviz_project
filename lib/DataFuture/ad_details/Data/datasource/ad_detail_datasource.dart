import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_detail.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../add_advertising/Data/model/ad_gallery.dart';
import '../model/ad_facilities.dart';

abstract class IAdvertisingFeaturesDataSoure {
  Future<List<AdvertisingFeatures>> getAdvertisinFeatures(String id);
  Future<List<AdvertisingFacilities>> getAdvertisinFacilities(String id);
  Future<List<RegisterFutureAdGallery>> getDiplayImagesAd(String id);
}

class IAdFeaturesRemoteDataSource extends IAdvertisingFeaturesDataSoure {
  final Dio dio;
  IAdFeaturesRemoteDataSource(this.dio);
  @override
  Future<List<AdvertisingFeatures>> getAdvertisinFeatures(String id) async {
    try {
      Map<String, dynamic> query = {'filter': 'id="$id"'};
      var response = await dio.get(
        'features',
        queryParameters: query,
      );
      return response.data['items']
          .map<AdvertisingFeatures>(
              (jsonObject) => AdvertisingFeatures.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }

  @override
  Future<List<AdvertisingFacilities>> getAdvertisinFacilities(String id) async {
    try {
      Map<String, dynamic> query = {'filter': 'id="$id"'};
      var response = await dio.get(
        'facilities',
        queryParameters: query,
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
  Future<List<RegisterFutureAdGallery>> getDiplayImagesAd(String id) async {
    try {
      Map<String, dynamic> query = {'filter': 'id=$id'};
      var response = await dio.get(
        'advertising_gallery',
        queryParameters: query,
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
