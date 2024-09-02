import 'dart:io';

import 'package:aviz_project/DataFuture/add_advertising/Data/datasource/info_register_ad_datasource.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../ad_details/Data/model/ad_facilities.dart';
import '../model/ad_gallery.dart';

abstract class IInfoAdRepository {
  Future<Either<String, List<RegisterFutureAd>>> getDiplayAdvertising();
  Future<Either<String, String>> postRegisterAd(
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
  Future<Either<String, String>> getDeleteAd(String id);

  Future<Either<String, List<RegisterFutureAdGallery>>> getImagesAdvertising();
  Future<Either<String, String>> postImagesToGallery(
    List<File> images,
  );
  Future<Either<String, String>> getUpdateAdImagesAd(
    List<File> images,
  );
  Future<Either<String, String>> getDeleteAdImagesAd(String id);

  Future<Either<String, List<AdvertisingFacilities>>> getDiplayAdFacilities();
  Future<Either<String, String>> postRegisterFacilities(
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
  Future<Either<String, String>> getDeleteAdFacilities(String id);
  Future<Either<String, String>> getUpdateAdFacilities(
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
}

final class InfoAdRepository extends IInfoAdRepository {
  IInfoAdDatasource datasource;
  InfoAdRepository(this.datasource);

  @override
  Future<Either<String, String>> postRegisterAd(
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
      var response = await datasource.postRegisterAd(
        idCT,
        location,
        title,
        description,
        price,
        metr,
        countRoom,
        floor,
        yearBuild,
      );
      if (response.isNotEmpty) {
        return right(response);
      } else {
        return left('خطایی پیش آمده! ');
      }
      // return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> postRegisterFacilities(
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
      var response = await datasource.postRegisterFacilities(
        elevator,
        parking,
        storeroom,
        balcony,
        penthouse,
        duplex,
        water,
        electricity,
        gas,
        floorMaterial,
        wc,
      );
      if (response.isNotEmpty) {
        return right(response);
      } else {
        return left('خطایی پیش آمده! ');
      }
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> postImagesToGallery(List<File> images) async {
    try {
      var response = await datasource.postImagesToGallery(
        images,
      );
      if (response.isNotEmpty) {
        return right(response);
      } else {
        return left('خطایی پیش آمده! ');
      }
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<RegisterFutureAdGallery>>>
      getImagesAdvertising() async {
    try {
      var response = await datasource.getDiplayImagesAd();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<RegisterFutureAd>>> getDiplayAdvertising() async {
    try {
      var response = await datasource.getDiplayAdvertising();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, List<AdvertisingFacilities>>>
      getDiplayAdFacilities() async {
    try {
      var response = await datasource.getDiplayAdvertisingFacilities();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> getDeleteAd(String id) async {
    try {
      var response = await datasource.getDeleteAd(id);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> getDeleteAdFacilities(String id) async {
    try {
      var response = await datasource.getDeleteAdFacilities(id);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> getDeleteAdImagesAd(String id) async {
    try {
      var response = await datasource.getDeleteAdImagesAd(id);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> getUpdateAdImagesAd(
    List<File> images,
  ) async {
    try {
      var response = await datasource.getUpdateAdImagesAd(images);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطال محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> getUpdateAdFacilities(
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
      var response = await datasource.getUpdateAdFacilities(
        elevator,
        parking,
        storeroom,
        balcony,
        penthouse,
        duplex,
        water,
        electricity,
        gas,
        floorMaterial,
        wc,
      );
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطال محتوای متنی ندارد');
    }
  }
}
