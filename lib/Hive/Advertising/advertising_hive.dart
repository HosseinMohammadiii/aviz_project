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

  AdvertisingHive({this.idFacilities, this.idGallery, this.idSaveAd});
}
