import 'package:aviz_project/DataFuture/add_advertising/Data/datasource/info_register_ad_datasource.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../ad_details/Data/model/ad_facilities.dart';

abstract class IInfoRegisterAdRepository {
  Future<Either<String, List<RegisterFutureAd>>> getDiplayAd(String idCt);

  Future<Either<String, String>> postRegisterAd(
    String idCT,
    String location,
    int metr,
    int countRoom,
    int floor,
    int yearBuild,
  );

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
  Future<Either<String, AdvertisingFacilities>> getFacilitiesAd();
  Future<Either<String, AdvertisingFacilities>> getFacilitiesAdvertising();
}

final class InfoRegisterAdRepository extends IInfoRegisterAdRepository {
  IInfoRegisterAdDatasource datasource;
  InfoRegisterAdRepository(this.datasource);
  @override
  Future<Either<String, List<RegisterFutureAd>>> getDiplayAd(
      String idCt) async {
    try {
      var response = await datasource.getDiplayAd(idCt);
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> postRegisterAd(
    String idCT,
    String location,
    int metr,
    int countRoom,
    int floor,
    int yearBuild,
  ) async {
    try {
      var response = await datasource.postRegisterAd(
        idCT,
        location,
        metr,
        countRoom,
        floor,
        yearBuild,
      );
      if (response.isNotEmpty) {
        return right('شما وارد شده اید');
      } else {
        return left('خطایی در ورود پیش آمده! ');
      }
      // return right(response);
    } on ApiExeption catch (ex) {
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
        return right('شما وارد شده اید');
      } else {
        return left('خطایی در ورود پیش آمده! ');
      }
    } on ApiExeption catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, AdvertisingFacilities>> getFacilitiesAd() async {
    try {
      var response = await datasource.getFacilitiesAdvertising();
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, AdvertisingFacilities>>
      getFacilitiesAdvertising() async {
    try {
      var response = await datasource.getFacilitiesAdvertisingList();
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
