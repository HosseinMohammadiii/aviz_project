import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../ad_details/Data/model/ad_facilities.dart';

abstract class IInfoRegisterAdDatasource {
  Future<List<RegisterFutureAd>> getDiplayAd(String idCt);
  Future<String> postRegisterAd(
    String idCT,
    String location,
    int metr,
    int countRoom,
    int floor,
    int yearBuild,
  );
  Future<String> postRegisterFacilities(
    bool elevator,
    bool parking,
    bool storeroom,
    bool balcony,
    bool penthouse,
  );
  Future<AdvertisingFacilities> getFacilitiesAdvertising();
  Future<AdvertisingFacilities> getFacilitiesAdvertisingList();
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
    int metr,
    int countRoom,
    int floor,
    int yearBuild,
  ) async {
    try {
      //This Variable is For Receiving the Facilities Records
      var responsee = await dio.get('collections/facilities/records');

      List<AdvertisingFacilities> adf = responsee.data['items']
          .map<AdvertisingFacilities>(
            (jsonObject) => AdvertisingFacilities.fromJson(jsonObject),
          )
          .toList();

      //This variable is For Take the last Id From Facilities Collections
      var id = adf.last.id;

      var response = await dio.post(
        'collections/inforegisteredhomes/records',
        data: {
          'category_name': idCT,
          'id_facilities': id,
          'location': location,
          'metr': metr,
          'count_room': countRoom,
          'floor': floor,
          'year_build': yearBuild,
        },
      );

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

  @override
  Future<String> postRegisterFacilities(
    bool elevator,
    bool parking,
    bool storeroom,
    bool balcony,
    bool penthouse,
  ) async {
    try {
      var response = await dio.post('collections/facilities/records', data: {
        'elevator': elevator,
        'parking': parking,
        'storeroom': storeroom,
        'balcony': balcony,
        'penthouse': penthouse,
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

  @override
  Future<AdvertisingFacilities> getFacilitiesAdvertising() async {
    try {
      var response = await dio.get(
        'collections/facilities/records',
      );
      return response.data['items']
          .map<AdvertisingFacilities>(
            (jsonObject) => AdvertisingFacilities.fromJson(jsonObject),
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
  Future<AdvertisingFacilities> getFacilitiesAdvertisingList() async {
    try {
      var response = await dio.get(
        'collections/facilities/records',
      );
      return response.data['items']
          .map<AdvertisingFacilities>(
            (jsonObject) => AdvertisingFacilities.fromJson(jsonObject),
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
