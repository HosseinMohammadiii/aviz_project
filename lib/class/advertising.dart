import 'dart:io';

class Advertising {
  num? metr;
  num? countRom;
  num? floor;
  num? yearBuild;
  String? title;
  String? address;
  DateTime? time;

  Advertising({
    this.metr,
    this.countRom,
    this.floor,
    this.yearBuild,
    this.title,
    this.address,
    this.time,
  });
}

class AdvertisingData {
  String? title;
  String? description;
  List<File>? img;
  num? price;

  AdvertisingData({
    this.title,
    this.description,
    this.img,
    this.price,
  });
}
