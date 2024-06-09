import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_detail.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';

abstract class IAdvertisingFeaturesDataSoure {
  Future<List<AdvertisingFeatures>> getAdvertisinFeatures(String adId);
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
}
