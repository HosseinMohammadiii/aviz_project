import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../ad_details/Data/model/ad_facilities.dart';
import '../Data/model/register_future_ad.dart';

abstract class AddAdvertisingState {}

final class AddAdvertisingInitializedData extends AddAdvertisingState {}

final class AddAdvertisingLoading extends AddAdvertisingState {}

final class AddAdvertisingImageLoading extends AddAdvertisingState {}

final class DisplayInfoAdvertisingStateResponse extends AddAdvertisingState {
  Either<String, List<RegisterFutureAd>> displayAdvertising;
  Either<String, List<AdvertisingFacilities>> displayAdvertisingFacilities;

  DisplayInfoAdvertisingStateResponse(
    this.displayAdvertising,
    this.displayAdvertisingFacilities,
  );
}

final class PostImageAdState extends AddAdvertisingState {
  Either<String, String> postImage;
  PostImageAdState(this.postImage);
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
  bool? uploadProgress;
  bool? stateRentHome;
  num? metr;
  num? buildingMetr;
  num? countRoom;
  num? floor;
  num? yearBuild;
  num? price;
  num? rentPrice;
  String idCt;
  String province;
  String title;
  String description;
  List<File>? images;
  String idFeature;
  String document;
  String view;
  String city;

  RegisterInfoAd({
    this.uploadProgress,
    this.stateRentHome,
    required this.metr,
    required this.buildingMetr,
    required this.countRoom,
    required this.floor,
    required this.yearBuild,
    required this.idCt,
    required this.province,
    required this.title,
    required this.description,
    required this.price,
    required this.rentPrice,
    required this.images,
    required this.idFeature,
    required this.document,
    required this.view,
    required this.city,
  });
  RegisterInfoAd copyWith({
    final bool? uploadProgress,
    final bool? stateRentHome,
    final num? metr,
    final num? buildingMetr,
    final num? countRoom,
    final num? floor,
    final num? yearBuild,
    final String? idCt,
    final String? province,
    final String? title,
    final String? description,
    final num? price,
    final num? rentPrice,
    final List<File>? images,
    final String? idFeature,
    final String? document,
    final String? view,
    final String? city,
  }) {
    return RegisterInfoAd(
      uploadProgress: uploadProgress ?? this.uploadProgress,
      stateRentHome: stateRentHome ?? this.stateRentHome,
      metr: metr ?? this.metr,
      buildingMetr: buildingMetr ?? this.buildingMetr,
      countRoom: countRoom ?? this.countRoom,
      floor: floor ?? this.floor,
      yearBuild: yearBuild ?? this.yearBuild,
      idCt: idCt ?? this.idCt,
      province: province ?? this.province,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      rentPrice: rentPrice ?? this.rentPrice,
      images: images ?? this.images,
      idFeature: idFeature ?? this.idFeature,
      document: document ?? this.document,
      view: view ?? this.view,
      city: city ?? this.city,
    );
  }
}
