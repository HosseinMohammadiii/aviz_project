class AdvertisingFeatures {
  String id;
  String idAdvertising;
  String document;
  String direction;
  AdvertisingFeatures({
    required this.id,
    required this.idAdvertising,
    required this.document,
    required this.direction,
  });

  factory AdvertisingFeatures.fromJson(Map<String, dynamic> jsonObject) {
    return AdvertisingFeatures(
      id: jsonObject['id'],
      idAdvertising: jsonObject['id_advertising'],
      document: jsonObject['document'],
      direction: jsonObject['direction'],
    );
  }
}
