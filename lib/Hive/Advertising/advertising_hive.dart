import 'package:hive/hive.dart';

part 'advertising_hive.g.dart';

@HiveType(typeId: 1)
class AdvertisingHive {
  @HiveField(0)
  String? idFacilities;

  @HiveField(1)
  String? idGallery;

  @HiveField(2)
  String? idSaveAd;
  @HiveField(3)
  String? province;
  @HiveField(4)
  String? city;
  @HiveField(5)
  String? phoneNumber;

  AdvertisingHive({
    this.idFacilities,
    this.idGallery,
    this.idSaveAd,
    this.province,
    this.city,
  });
}
