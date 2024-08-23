import 'dart:io';

import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../ad_details/Data/model/ad_facilities.dart';
import '../model/ad_gallery.dart';

abstract class IInfoRegisterAdDatasource {
  Future<List<RegisterFutureAd>> getDiplayAd(String idCt);
  Future<List<RegisterFutureAd>> getDiplayAdvertising();
  Future<List<RegisterFutureAdGallery>> getDiplayImagesAd();
  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilitiesItems(
      String id);
  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities();
  Future<String> postRegisterAd(
    String idCT,
    String location,
    String title,
    String description,
    num price,
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
    bool duplex,
    bool water,
    bool electricity,
    bool gas,
    String floorMaterial,
    String wc,
  );
  Future<String> postImagesToGallery(
    List<File> images,
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
      Map<String, dynamic> query = {'filter': 'id_category="$idCt"'};
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
    String title,
    String description,
    num price,
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
      var idf = adf.last.id;

      //This Variable is For Receiving the Gallery Records
      var responseGallery =
          await dio.get('collections/advertising_gallery/records');

      List<RegisterFutureAdGallery> adg = responseGallery.data['items']
          .map<RegisterFutureAdGallery>(
            (jsonObject) => RegisterFutureAdGallery.fromJson(jsonObject),
          )
          .toList();

      //This variable is For Take the last Id From Gallery Collections
      var idg = adg.last.id;

      var response = await dio.post(
        'collections/inforegisteredhomes/records',
        data: {
          'id_category': idCT,
          'id_facilities': idf,
          'id_gallery': idg,
          'title': title,
          'price': price,
          'description': description,
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
    bool duplex,
    bool water,
    bool electricity,
    bool gas,
    String floorMaterial,
    String wc,
  ) async {
    try {
      var response = await dio.post('collections/facilities/records', data: {
        'elevator': elevator,
        'parking': parking,
        'storeroom': storeroom,
        'balcony': balcony,
        'penthouse': penthouse,
        'duplex': duplex,
        'water': water,
        'electricity': electricity,
        'gas': gas,
        'floor_material': floorMaterial,
        'wc': wc,
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

  @override
  Future<String> postImagesToGallery(List<File> images) async {
    try {
      List<MultipartFile> imageFiles = [];
      for (var image in images) {
        String fileName = image.path.split('/').last;
        imageFiles
            .add(await MultipartFile.fromFile(image.path, filename: fileName));
      }

      FormData formData = FormData.fromMap({
        'images': imageFiles,
      });
      var response = await dio.post(
        'collections/advertising_gallery/records',
        data: formData,
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
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
  }

  @override
  Future<List<RegisterFutureAd>> getDiplayAdvertising() async {
    try {
      var response = await dio.get(
        'collections/inforegisteredhomes/records',
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
  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilitiesItems(
      String id) async {
    try {
      Map<String, dynamic> query = {'filter': 'id="$id"'};
      var response = await dio.get(
        'collections/facilities/records',
        queryParameters: query,
      );
      return response.data['items']
          .map<AdvertisingFacilities>(
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
      throw ApiExeption(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiExeption(0, 'Unknown');
    }
  }
}
