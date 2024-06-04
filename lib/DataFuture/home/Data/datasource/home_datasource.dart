import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dio/dio.dart';

abstract class IHomeDataSoure {
  Future<List<AdvertisingHome>> getAdvertising();
  Future<List<AdvertisingHome>> getHotAdvertising();
  Future<List<AdvertisingHome>> getRecentAdvertising();
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

  @override
  Future<List<AdvertisingHome>> getRecentAdvertising() async {
    //This function returns the current time in ISO 8601 format, which includes the exact date and time.
    String currentDateTime() {
      DateTime dt = DateTime.now();
      return '${dt.toIso8601String()}';
    }

    try {
      Map<String, dynamic> query = {'filter': 'created<"${currentDateTime()}"'};
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

  @override
  Future<List<AdvertisingHome>> getAdvertising() async {
    try {
      var response = await dio.get(
        'collections/home_screen/records',
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
