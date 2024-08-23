class RegisterFutureAd {
  String id;
  String categoryId;
  String idFacilities;
  String idGallery;
  String collectionId;
  String location;
  String titlehome;
  String description;
  int homeprice;
  RegisterFutureAd({
    required this.id,
    required this.categoryId,
    required this.idFacilities,
    required this.idGallery,
    required this.collectionId,
    required this.location,
    required this.titlehome,
    required this.description,
    required this.homeprice,
  });

  factory RegisterFutureAd.fromJson(Map<String, dynamic> jsonObject) {
    return RegisterFutureAd(
      id: jsonObject['id'],
      categoryId: jsonObject['id_category'],
      idFacilities: jsonObject['id_facilities'],
      idGallery: jsonObject['id_gallery'],
      collectionId: jsonObject['collectionId'],
      location: jsonObject['location'],
      titlehome: jsonObject['title'],
      description: jsonObject['description'],
      homeprice: jsonObject['price'],
    );
  }
}
