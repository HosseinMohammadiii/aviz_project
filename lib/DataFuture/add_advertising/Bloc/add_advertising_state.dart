import 'dart:io';

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

final class AddImagesToGalleryStateResponse extends AddAdvertisingState {
  Either<String, String> registerFutureImagesGallery;
  AddImagesToGalleryStateResponse(this.registerFutureImagesGallery);
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
  final bool duplex;
  final bool water;
  final bool electricity;
  final bool gas;
  final String floorMaterial;
  int fIndex;
  final String wc;
  int wIndex;

  BoolState({
    required this.elevator,
    required this.parking,
    required this.storeroom,
    required this.balcony,
    required this.penthouse,
    required this.duplex,
    required this.water,
    required this.electricity,
    required this.gas,
    required this.floorMaterial,
    required this.fIndex,
    required this.wc,
    required this.wIndex,
  });

  BoolState copyWith(
      {bool? elevator,
      bool? parking,
      bool? storeroom,
      bool? balcony,
      bool? penthouse,
      bool? duplex,
      bool? water,
      bool? electricity,
      bool? gas,
      String? floorMaterial,
      int? fIndex,
      String? wc,
      int? wIndex}) {
    return BoolState(
      elevator: elevator ?? this.elevator,
      parking: parking ?? this.parking,
      storeroom: storeroom ?? this.storeroom,
      balcony: balcony ?? this.balcony,
      penthouse: penthouse ?? this.penthouse,
      duplex: duplex ?? this.duplex,
      water: water ?? this.water,
      electricity: electricity ?? this.electricity,
      gas: gas ?? this.gas,
      floorMaterial: floorMaterial ?? this.floorMaterial,
      fIndex: fIndex ?? this.fIndex,
      wc: wc ?? this.wc,
      wIndex: wIndex ?? this.wIndex,
    );
  }
}

class RegisterInfoAd {
  final num? metr;
  final num? countRoom;
  final num? floor;
  final num? yearBuild;
  final String idCt;
  final String address;
  String title;
  String description;
  num? price;
  final List<File>? images;

  RegisterInfoAd({
    required this.metr,
    required this.countRoom,
    required this.floor,
    required this.yearBuild,
    required this.idCt,
    required this.address,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
  });
  RegisterInfoAd copyWith({
    final num? metr,
    final num? countRoom,
    final num? floor,
    final num? yearBuild,
    final String? idCt,
    final String? address,
    final String? title,
    final String? description,
    final num? price,
    final List<File>? images,
  }) {
    return RegisterInfoAd(
      metr: metr ?? this.metr,
      countRoom: countRoom ?? this.countRoom,
      floor: floor ?? this.floor,
      yearBuild: yearBuild ?? this.yearBuild,
      idCt: idCt ?? this.idCt,
      address: address ?? this.address,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
    );
  }
}
