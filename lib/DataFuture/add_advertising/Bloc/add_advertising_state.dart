import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../ad_details/Data/model/ad_facilities.dart';
import '../../advertising_save/model/advertising_save.dart';
import '../Data/model/ad_gallery.dart';
import '../Data/model/register_future_ad.dart';

abstract class AddAdvertisingState {}

final class AddAdvertisingInitializedData extends AddAdvertisingState {}

final class AddAdvertisingLoading extends AddAdvertisingState {}

final class DisplayInfoAdvertisingStateResponse extends AddAdvertisingState {
  Either<String, List<RegisterFutureAd>> displayAdvertising;
  Either<String, List<RegisterFutureAdGallery>> displayImagesAdvertising;
  Either<String, List<AdvertisingFacilities>> displayAdvertisingFacilities;
  Either<String, List<AdvertisingSave>> displayAdvertisingSave;

  DisplayInfoAdvertisingStateResponse(
    this.displayAdvertising,
    this.displayImagesAdvertising,
    this.displayAdvertisingFacilities,
    this.displayAdvertisingSave,
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
  bool isUpdate;
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
    required this.isUpdate,
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
      bool? isUpdate,
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
      isUpdate: isUpdate ?? this.isUpdate,
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
  String province;
  String title;
  String description;
  num? price;
  final List<File>? images;
  final String idFeature;
  String document;
  String view;
  String city;

  RegisterInfoAd({
    required this.metr,
    required this.countRoom,
    required this.floor,
    required this.yearBuild,
    required this.idCt,
    required this.province,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.idFeature,
    required this.document,
    required this.view,
    required this.city,
  });
  RegisterInfoAd copyWith({
    final num? metr,
    final num? countRoom,
    final num? floor,
    final num? yearBuild,
    final String? idCt,
    final String? province,
    final String? title,
    final String? description,
    final num? price,
    final List<File>? images,
    final String? idFeature,
    final String? document,
    final String? view,
    final String? city,
  }) {
    return RegisterInfoAd(
      metr: metr ?? this.metr,
      countRoom: countRoom ?? this.countRoom,
      floor: floor ?? this.floor,
      yearBuild: yearBuild ?? this.yearBuild,
      idCt: idCt ?? this.idCt,
      province: province ?? this.province,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      idFeature: idFeature ?? this.idFeature,
      document: document ?? this.document,
      view: view ?? this.view,
      city: city ?? this.city,
    );
  }
}
