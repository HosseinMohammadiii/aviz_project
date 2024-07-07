import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_detail.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../model/ad_facilities.dart';

abstract class IAdvertisingFeaturesDataSoure {
  Future<List<AdvertisingFeatures>> getAdvertisinFeatures(String adId);
  Future<List<AdvertisingFacilities>> getAdvertisinFacilities(String adId);
  Future<List<AdvertisingFacilities>> getAdvertisinFacilitiesList();
}

class IAdFeaturesRemoteDataSource extends IAdvertisingFeaturesDataSoure {
  final Dio dio;
  IAdFeaturesRemoteDataSource(this.dio);
  @override
  Future<List<AdvertisingFeatures>> getAdvertisinFeatures(String adId) async {
    try {
      Map<String, dynamic> query = {'filter': 'id_advertising="$adId"'};
      var response = await dio.get(
        'collections/features/records',
        queryParameters: query,
      );
      return response.data['items']
          .map<AdvertisingFeatures>(
              (jsonObject) => AdvertisingFeatures.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
  }

  @override
  Future<List<AdvertisingFacilities>> getAdvertisinFacilities(
      String adId) async {
    try {
      Map<String, dynamic> query = {'filter': 'id_advertising="$adId"'};
      var response = await dio.get(
        'collections/facilities/records',
        queryParameters: query,
      );
      return response.data['items']
          .map<AdvertisingFacilities>(
              (jsonObject) => AdvertisingFacilities.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
  }

  @override
  Future<List<AdvertisingFacilities>> getAdvertisinFacilitiesList() async {
    try {
      var response = await dio.get(
        'collections/facilities/records',
      );
      return response.data['items']
          .map<AdvertisingFacilities>(
              (jsonObject) => AdvertisingFacilities.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
  }
}
