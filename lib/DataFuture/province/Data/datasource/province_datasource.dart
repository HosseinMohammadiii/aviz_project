import 'package:aviz_project/DataFuture/NetworkUtil/api_exeption.dart';
import 'package:aviz_project/DataFuture/province/model/province.dart';
import 'package:dio/dio.dart';

abstract class IProvinceDatasource {
  Future<List<ProvinceModel>> provices(String province);
  Future<List<ProvinceModel>> provicesCities(String city);
}

final class ProvinceDatasourceRemoot extends IProvinceDatasource {
  Dio dio = Dio(BaseOptions(baseUrl: 'https://iran-locations-api.ir/api/'));

  @override
  Future<List<ProvinceModel>> provices(String province) async {
    try {
      Map<String, dynamic> query = {'state': province};

      var response = await dio.get(
        'v1/fa/states',
        queryParameters: query,
      );
      return response.data
          .map<ProvinceModel>(
            (jsonObject) => ProvinceModel.fromJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode!, ex.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'Unknown Message');
    }
  }

  @override
  Future<List<ProvinceModel>> provicesCities(String city) async {
    try {
      Map<String, dynamic> query = {'state': city};

      var response = await dio.get(
        'v1/fa/cities',
        queryParameters: query,
      );
      if (city.isNotEmpty) {
        return response.data[0]['cities']
            .map<ProvinceModel>(
              (jsonObject) => ProvinceModel.fromJson(jsonObject),
            )
            .toList();
      }

      return response.data
          .map<ProvinceModel>(
            (jsonObject) => ProvinceModel.fromJson(jsonObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode ?? 0,
          ex.response?.statusMessage ?? 'Unknown Error');
    } catch (ex) {
      throw ApiException(0, 'Unknown Message');
    }
  }
}
