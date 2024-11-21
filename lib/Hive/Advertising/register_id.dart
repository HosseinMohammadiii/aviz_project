import 'package:hive/hive.dart';

import 'advertising_hive.dart';

class RegisterId {
  AdvertisingHive adHive = AdvertisingHive();
  final Box<AdvertisingHive> adBox = Hive.box('ad_hive');

  void clearID() {
    adBox.clear();
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

  void setProvince(String province) {
    adHive.province = province;
    adBox.put(4, adHive);
  }

  String getProvince() {
    return adBox.get(4)?.province ?? '';
  }

  void setCity(String city) {
    adHive.city = city;
    adBox.put(5, adHive);
  }

  String getCity() {
    return adBox.get(5)?.city ?? '';
  }

  void setPhoneNumber(String phoneNumber) {
    adHive.phoneNumber = phoneNumber;
    adBox.put(6, adHive);
  }

  String getPhoneNumber() {
    return adBox.get(6)?.phoneNumber ?? '';
  }
}
