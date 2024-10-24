class AdvertisingFacilities {
  String id;
  bool elevator;
  bool parking;
  bool storeroom;
  bool balcony;
  bool penthouse;
  bool duplex;
  bool water;
  bool electricity;
  bool gas;
  String floormaterial;
  String wc;
  AdvertisingFacilities({
    required this.id,
    required this.elevator,
    required this.parking,
    required this.storeroom,
    required this.balcony,
    required this.penthouse,
    required this.duplex,
    required this.water,
    required this.electricity,
    required this.gas,
    required this.floormaterial,
    required this.wc,
  });
  factory AdvertisingFacilities.fromJson(Map<String, dynamic> jsonObject) {
    return AdvertisingFacilities(
      id: jsonObject['id'],
      elevator: jsonObject['elevator'] == 1 ? true : false,
      parking: jsonObject['parking'] == 1 ? true : false,
      storeroom: jsonObject['storeroom'] == 1 ? true : false,
      balcony: jsonObject['balcony'] == 1 ? true : false,
      penthouse: jsonObject['penthouse'] == 1 ? true : false,
      duplex: jsonObject['duplex'] == 1 ? true : false,
      water: jsonObject['water'] == 1 ? true : false,
      electricity: jsonObject['electricity'] == 1 ? true : false,
      gas: jsonObject['gas'] == 1 ? true : false,
      floormaterial: jsonObject['floor_material'],
      wc: jsonObject['wc'],
    );
  }
}
