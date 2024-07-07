import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';

abstract class IInfoRegisterAdDatasource {
  Future<List<RegisterFutureAd>> getDiplayAd(String idCt);
  Future<String> postRegisterAd(
    String idCT,
    String location,
    List<String> images,
    String titlehome,
    String description,
    int homeprice,
  );
}

final class InfoRegisterAdDatasourceRemmot extends IInfoRegisterAdDatasource {
  Dio dio;
  InfoRegisterAdDatasourceRemmot(this.dio);
  @override
  Future<List<RegisterFutureAd>> getDiplayAd(String idCt) async {
    try {
      Map<String, dynamic> query = {'filter': 'category_name="$idCt"'};
      var response = await dio.get(
        'collections/inforegisteredhomes/records',
        queryParameters: query,
      );
      return response.data['items']
          .map<RegisterFutureAd>(
              (jsonObject) => RegisterFutureAd.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
  }

  @override
  Future<String> postRegisterAd(
    String idCT,
    String location,
    List<String> images,
    String titlehome,
    String description,
    int homeprice,
  ) async {
    try {
      var response =
          await dio.post('collections/inforegisteredhomes/records', data: {
        'category_name': idCT,
        'location': location,
        'images': images,
        'title_home': titlehome,
        'description': description,
        'home_price': homeprice,
      });
      if (response.statusCode == 200) {
        return response.data['items'];
      }
    } on DioException catch (ex) {
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
    return '';
  }
}
