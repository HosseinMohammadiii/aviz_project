import 'package:aviz_project/DataFuture/add_advertising/Data/model/category_advertising.dart';
import 'package:dartz/dartz.dart';

import '../../ad_details/Data/model/ad_facilities.dart';
import '../Data/model/register_future_ad.dart';

abstract class AddAdvertisingState {}

final class AddAdvertisingInitializedData extends AddAdvertisingState {}

final class AddAdvertisingLoading extends AddAdvertisingState {}

final class AddAdvertisingResponse extends AddAdvertisingState {
  Either<String, List<CategoryAdvertising>> categoryAdvertising;

  AddAdvertisingResponse(
    this.categoryAdvertising,
  );
}

final class AddInfoAdvertisingStateResponse extends AddAdvertisingState {
  Either<String, String> registerInfoAdvertising;
  Either<String, List<RegisterFutureAd>> registerAdvertising;
  AddInfoAdvertisingStateResponse(
    this.registerAdvertising,
    this.registerInfoAdvertising,
  );
}

final class RegisterFacilitiesInfoAdvertising extends AddAdvertisingState {
  Either<String, String> registerFacilitiesInfoAdvertising;
  Either<String, AdvertisingFacilities> registerFacilitiesAd;
  RegisterFacilitiesInfoAdvertising(
    this.registerFacilitiesInfoAdvertising,
    this.registerFacilitiesAd,
  );
}

class BoolState {
  final bool elevator;
  final bool parking;
  final bool storeroom;
  final bool balcony;
  final bool penthouse;

  BoolState({
    required this.elevator,
    required this.parking,
    required this.storeroom,
    required this.balcony,
    required this.penthouse,
  });

  BoolState copyWith({
    bool? elevator,
    bool? parking,
    bool? storeroom,
    bool? balcony,
    bool? penthouse,
  }) {
    return BoolState(
      elevator: elevator ?? this.elevator,
      parking: parking ?? this.parking,
      storeroom: storeroom ?? this.storeroom,
      balcony: balcony ?? this.balcony,
      penthouse: penthouse ?? this.penthouse,
    );
  }
}

class RegisterInfoAd {
  final num metr;
  final num countRoom;
  final num floor;
  final num yearBuild;
  final String idCt;
  final String address;

  RegisterInfoAd({
    required this.metr,
    required this.countRoom,
    required this.floor,
    required this.yearBuild,
    required this.idCt,
    required this.address,
  });
  RegisterInfoAd copyWith({
    final num? metr,
    final num? countRoom,
    final num? floor,
    final num? yearBuild,
    final String? idCt,
    final String? address,
  }) {
    return RegisterInfoAd(
      metr: metr ?? this.metr,
      countRoom: countRoom ?? this.countRoom,
      floor: floor ?? this.floor,
      yearBuild: yearBuild ?? this.yearBuild,
      idCt: idCt ?? this.idCt,
      address: address ?? this.address,
    );
  }
}
