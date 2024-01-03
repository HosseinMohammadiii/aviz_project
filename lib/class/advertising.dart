import 'dart:io';

class Advertising {
  num? metr;
  num? countRom;
  num? floor;
  num? yearBuild;
  String? title;
  String? address;

  Advertising({
    this.metr,
    this.countRom,
    this.floor,
    this.yearBuild,
    this.title,
    this.address,
  });
}

class AdvertisingData {
  String? title;
  String? description;
  File? img;
  num? price;

  AdvertisingData({
    this.title,
    this.description,
    this.img,
    this.price,
  });
}
