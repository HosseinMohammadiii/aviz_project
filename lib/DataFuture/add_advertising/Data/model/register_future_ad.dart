import 'package:aviz_project/Hive/Advertising/advertising_hive.dart';
import 'package:hive/hive.dart';

class RegisterFutureAd {
  String id;
  String created;
  String categoryId;
  String idFeatures;
  String idFacilities;
  String idGallery;
  String collectionId;
  String location;
  String titlehome;
  String description;
  String province;
  int homeprice;
  int metr;
  int countRoom;
  int floor;
  int yearBiuld;
  RegisterFutureAd({
    required this.id,
    required this.created,
    required this.categoryId,
    required this.idFeatures,
    required this.idFacilities,
    required this.idGallery,
    required this.collectionId,
    required this.location,
    required this.titlehome,
    required this.description,
    required this.province,
    required this.homeprice,
    required this.metr,
    required this.countRoom,
    required this.floor,
    required this.yearBiuld,
  });

  factory RegisterFutureAd.fromJson(Map<String, dynamic> jsonObject) {
    return RegisterFutureAd(
      id: jsonObject['id'],
      created: jsonObject['created'],
      idFacilities: jsonObject['id_facilities'],
      idFeatures: jsonObject['id_features'],
      categoryId: jsonObject['id_category'],
      idGallery: jsonObject['id_gallery'],
      collectionId: jsonObject['collectionId'],
      titlehome: jsonObject['title'],
      location: jsonObject['location'],
      metr: jsonObject['metr'],
      countRoom: jsonObject['count_room'],
      floor: jsonObject['floor'],
      yearBiuld: jsonObject['year_build'],
      homeprice: jsonObject['price'],
      description: jsonObject['description'],
      province: jsonObject['province'],
    );
  }
}

class RegisterId {
  AdvertisingHive adHive = AdvertisingHive();
  final Box<AdvertisingHive> adBox = Hive.box('ad_hive');

  void clearID() {
    adHive.idFacilities = null;
    adHive.idGallery = null;
    adBox.put(1, adHive);
    adBox.put(2, adHive);
  }

  void saveIdFacilities(String id) {
    adHive.idFacilities = id;
    adBox.put(1, adHive);
  }

  String getIdFacilities() {
    return adBox.get(1)?.idFacilities ?? '';
  }

  void saveIdGallery(String id) {
    adHive.idGallery = id;
    adBox.put(2, adHive);
  }

  String getIdGallery() {
    return adBox.get(2)?.idGallery ?? '';
  }
}
