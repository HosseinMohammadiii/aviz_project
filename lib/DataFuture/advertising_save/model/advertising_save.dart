class AdvertisingSave {
  String id;
  String userId;
  String idAd;

  AdvertisingSave(this.id, this.userId, this.idAd);

  factory AdvertisingSave.fromJsonObject(Map<String, dynamic> jsonObject) {
    return AdvertisingSave(
      jsonObject['id'],
      jsonObject['user_id'],
      jsonObject['id_ad'],
    );
  }
}
