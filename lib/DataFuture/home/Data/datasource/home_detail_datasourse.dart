import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../ad_details/Data/model/ad_facilities.dart';

abstract class IHomeDetailDataSource {
  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities(String id);
}

class HomeDetailRemoteDataSource extends IHomeDetailDataSource {
  Dio dio;
  HomeDetailRemoteDataSource(this.dio);
  @override
  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities(
      String id) async {
    try {
      Map<String, String> qParams = {'filter': 'id="$id"'};
      var response = await dio.get(
        'collections/facilities/records',
        queryParameters: qParams,
      );
      print('DataSourceHome');
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
