import 'dart:io';

import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:dio/dio.dart';

import '../../../../Hive/Advertising/register_id.dart';
import '../../../NetworkUtil/api_exeption.dart';
import '../../../ad_details/Data/model/ad_facilities.dart';
import '../../../advertising_save/model/advertising_save.dart';
import '../model/ad_gallery.dart';

abstract class IInfoAdDatasource {
  Future<List<RegisterFutureAd>> getDiplayAdvertising();
  Future<String> postRegisterAd(
    String idCT,
    String idFeature,
    String province,
    String location,
    String title,
    String description,
    num price,
    int metr,
    int countRoom,
    int floor,
    int yearBuild,
  );
  Future<String> getDeleteAd(String id);

  Future<List<RegisterFutureAdGallery>> getDiplayImagesAd();
  Future<String> postImagesToGallery(
    List<File> images,
  );
  Future<String> getDeleteAdImagesAd(String id);
  Future<String> getUpdateAdImagesAd(
    List<File> images,
  );

  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities();
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
  Future<String> getDeleteAdFacilities(String id);
  Future<String> getUpdateAdFacilities(
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

  Future<List<AdvertisingSave>> getSaveAd();
}

final class InfoAdDatasourceRemmot extends IInfoAdDatasource {
  Dio dio;
  InfoAdDatasourceRemmot(this.dio);

  @override
  Future<String> postRegisterAd(
    String idCT,
    String idFeature,
    String province,
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
      var response = await dio.post(
        'collections/inforegisteredhomes/records',
        data: {
          'user_id': Authmanager().getId(),
          'id_category': idCT,
          'id_features': idFeature,
          'province': province,
          'id_facilities': RegisterId().getIdFacilities(),
          'id_gallery': RegisterId().getIdGallery(),
          'title': title,
          'price': price,
          'description': description,
          'location': location,
          'metr': metr,
          'count_room': countRoom,
          'floor': floor,
          'year_build': yearBuild,
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );

      if (response.statusCode == 200 &&
          RegisterId().getIdGallery().isNotEmpty) {
        return response.data['items'];
      }
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
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
      var response = await dio.post(
        'collections/facilities/records',
        data: {
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
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );

      if (response.statusCode == 200) {
        RegisterId().saveIdFacilities(response.data['id']);
        return response.data['items'];
      }
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
    return '';
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
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );

      if (response.statusCode == 200) {
        RegisterId().saveIdGallery(response.data['id']);
        return response.data['items'];
      }
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
    return '';
  }

  @override
  Future<List<RegisterFutureAdGallery>> getDiplayImagesAd() async {
    try {
      var response = await dio.get(
        'advertising_gallery',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
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

  @override
  Future<List<RegisterFutureAd>> getDiplayAdvertising() async {
    try {
      Map<String, String> qParams = {
        'filter': 'user_id=${Authmanager().getId()}'
      };

      var response = await dio.get(
        'advertising_home',
        queryParameters: qParams,
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );

      return response.data['items']
          .map<RegisterFutureAd>(
              (jsonObject) => RegisterFutureAd.fromJson(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }

  @override
  Future<List<AdvertisingFacilities>> getDiplayAdvertisingFacilities() async {
    try {
      var response = await dio.get(
        'facilities',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
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
  Future<String> getDeleteAd(String id) async {
    try {
      var response = await dio.delete(
        'collections/inforegisteredhomes/records/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );
      return response.data['items'];
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }

  @override
  Future<String> getDeleteAdFacilities(String id) async {
    try {
      var response = await dio.delete(
        'collections/facilities/records/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
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
  Future<String> getDeleteAdImagesAd(String id) async {
    try {
      var response = await dio.delete(
        'collections/advertising_gallery/records/$id',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );
      return response.data['items'];
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
  }

  @override
  Future<String> getUpdateAdFacilities(
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
      var response = await dio.patch(
        'collections/facilities/records/${RegisterId().getIdFacilities()}',
        data: {
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
        },
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
      );
      if (response.statusCode == 200) {
        return response.data['items'];
      }
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
    return '';
  }

  @override
  Future<String> getUpdateAdImagesAd(
    List<File> images,
  ) async {
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
      var response = await dio.patch(
        'collections/advertising_gallery/records/${RegisterId().getIdGallery()}',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['items'];
      }
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown');
    }
    return '';
  }

  @override
  Future<List<AdvertisingSave>> getSaveAd() async {
    try {
      var response = await dio.get(
        'adsave',
      );

      return response.data['items']
          .map<AdvertisingSave>(
            (jsonObject) => AdvertisingSave.fromJsonObject(jsonObject),
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
