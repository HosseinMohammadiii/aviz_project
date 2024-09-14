import 'package:hive/hive.dart';

import 'advertising_hive.dart';

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

  void saveId(String id) {
    adHive.idSaveAd = id;
    adBox.put(3, adHive);
  }

  String getSaveId() {
    return adBox.get(3)?.idSaveAd ?? '';
  }
}
