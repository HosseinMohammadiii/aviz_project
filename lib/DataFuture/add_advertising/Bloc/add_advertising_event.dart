import 'dart:io';

abstract class AddAdvertisingEvent {}

class AddAdvertisingGetInitializeData extends AddAdvertisingEvent {}

class AddImagesToGallery extends AddAdvertisingEvent {
  List<File> images;

  AddImagesToGallery(this.images);
}

class AddInfoAdvertising extends AddAdvertisingEvent {
  String idCt;
  String location;
  int metr;
  int countRoom;
  int floor;
  int yearBuild;

  AddInfoAdvertising(
    this.idCt,
    this.location,
    this.metr,
    this.countRoom,
    this.floor,
    this.yearBuild,
  );
}

final class AddFacilitiesAdvertising extends AddAdvertisingEvent {
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
