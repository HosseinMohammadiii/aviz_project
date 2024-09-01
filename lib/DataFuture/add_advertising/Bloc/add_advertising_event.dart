import 'dart:io';

abstract class InfoAdvertisingEvent {}

class AddAdvertisingGetInitializeData extends InfoAdvertisingEvent {}

class AddImagesToGallery extends InfoAdvertisingEvent {
  List<File> images;

  AddImagesToGallery(this.images);
}

class InitializedDisplayAdvertising extends InfoAdvertisingEvent {}

class AddInfoAdvertising extends InfoAdvertisingEvent {
  String idCt;
  String location;
  String title;
  String description;
  num price;
  int metr;
  int countRoom;
  int floor;
  int yearBuild;

  AddInfoAdvertising(
    this.idCt,
    this.location,
    this.title,
    this.description,
    this.price,
    this.metr,
    this.countRoom,
    this.floor,
    this.yearBuild,
  );
}

final class AddFacilitiesAdvertising extends InfoAdvertisingEvent {
  bool elevator;
  bool parking;
  bool storeroom;
  bool balcony;
  bool penthouse;
  bool duplex;
  bool water;
  bool electricity;
  bool gas;
  String floorMaterial;
  String wc;

  AddFacilitiesAdvertising(
    this.elevator,
    this.parking,
    this.storeroom,
    this.balcony,
    this.penthouse,
    this.duplex,
    this.water,
    this.electricity,
    this.gas,
    this.floorMaterial,
    this.wc,
  );
}

final class DeleteAdvertisingData extends InfoAdvertisingEvent {
  String idAd;
  String idAdFacilities;
  String idAdGallery;
  DeleteAdvertisingData({
    required this.idAd,
    required this.idAdFacilities,
    required this.idAdGallery,
  });
}

final class DeleteImageData extends InfoAdvertisingEvent {
  String idAdGallery;
  DeleteImageData(this.idAdGallery);
}
