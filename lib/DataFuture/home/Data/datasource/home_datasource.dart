import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dio/dio.dart';

abstract class IHomeDataSoure {
  Future<List<AdvertisingHome>> getHotAdvertising();
}

class HomeRemoteDataSource extends IHomeDataSoure {
  final Dio dio;
  HomeRemoteDataSource(this.dio);
  @override
  Future<List<AdvertisingHome>> getHotAdvertising() async {
    try {
      Map<String, dynamic> query = {'filter': 'is_hot=true'};
      var response = await dio.get(
        'collections/home_screen/records',
        queryParameters: query,
      );
      return response.data['items']
          .map<AdvertisingHome>(
            (jsonObject) => AdvertisingHome.fromJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
  }
}
