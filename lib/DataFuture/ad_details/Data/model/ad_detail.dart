class AdvertisingFeatures {
  String id;
  String document;
  String direction;
  AdvertisingFeatures({
    required this.id,
    required this.document,
    required this.direction,
  });

  factory AdvertisingFeatures.fromJson(Map<String, dynamic> jsonObject) {
    return AdvertisingFeatures(
      id: jsonObject['id'],
      document: jsonObject['document'] ?? "",
      direction: jsonObject['direction'] ?? "",
    );
  }
}
