import 'package:hive/hive.dart';

part 'advertising_hive.g.dart';

@HiveType(typeId: 1)
class AdvertisingHive {
  @HiveField(0)
  String? idFacilities;

  @HiveField(1)
  String? idGallery;

  AdvertisingHive({this.idFacilities, this.idGallery});
}
