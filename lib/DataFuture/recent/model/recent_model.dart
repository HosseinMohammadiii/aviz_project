class RecentModel {
  String id;
  String userId;
  String idAd;

  RecentModel(this.id, this.userId, this.idAd);

  factory RecentModel.fromJsonObject(Map<String, dynamic> jsonObject) {
    return RecentModel(
      jsonObject['id'],
      jsonObject['user_id'],
      jsonObject['id_ad'],
    );
  }
}
