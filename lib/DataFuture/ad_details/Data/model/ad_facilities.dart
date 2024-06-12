class AdvertisingFacilities {
  String id;
  String idadvertising;
  bool elevator;
  bool parking;
  bool storeroom;
  bool balcony;
  bool penthouse;
  String floormaterial;
  String wc;
  AdvertisingFacilities({
    required this.id,
    required this.idadvertising,
    required this.elevator,
    required this.parking,
    required this.storeroom,
    required this.balcony,
    required this.penthouse,
    required this.floormaterial,
    required this.wc,
  });
  factory AdvertisingFacilities.fromJson(Map<String, dynamic> jsonObject) {
    return AdvertisingFacilities(
      id: jsonObject['id'],
      idadvertising: jsonObject['id_advertising'],
      elevator: jsonObject['elevator'],
      parking: jsonObject['parking'],
      storeroom: jsonObject['storeroom'],
      balcony: jsonObject['balcony'],
      penthouse: jsonObject['penthouse'],
      floormaterial: jsonObject['floor_material'],
      wc: jsonObject['wc'],
    );
  }
}
