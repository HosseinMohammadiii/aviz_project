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
      elevator: jsonObject['elevator'],
      parking: jsonObject['parking'],
      storeroom: jsonObject['storeroom'],
      balcony: jsonObject['balcony'],
      penthouse: jsonObject['penthouse'],
      duplex: jsonObject['duplex'],
      water: jsonObject['water'],
      electricity: jsonObject['electricity'],
      gas: jsonObject['gas'],
      floormaterial: jsonObject['floor_material'],
      wc: jsonObject['wc'],
    );
  }
}
