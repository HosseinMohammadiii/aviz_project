import 'dart:io';

abstract class AddAdvertisingEvent {}

class AddAdvertisingGetInitializeData extends AddAdvertisingEvent {}

class AddImagesToGallery extends AddAdvertisingEvent {
  List<File> images;

  AddImagesToGallery(this.images);
}

class InitializedDisplayAdvertising extends AddAdvertisingEvent {}

class InitializedDisplayAdvertisingFacilities extends AddAdvertisingEvent {
  String id;
  InitializedDisplayAdvertisingFacilities(this.id);
}

class AddInfoAdvertising extends AddAdvertisingEvent {
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
