class RegisterFutureAd {
  String id;
  String created;
  String categoryId;
  String idFeatures;
  String idFacilities;
  String idGallery;
  String titlehome;
  String description;
  String province;
  String city;
  String phoneNumber;
  int homeprice;
  int rentPrice;
  int metr;
  int buildingMetr;
  int countRoom;
  int floor;
  int yearBiuld;
  List<String> images;

  RegisterFutureAd({
    required this.id,
    required this.created,
    required this.categoryId,
    required this.idFeatures,
    required this.idFacilities,
    required this.idGallery,
    required this.titlehome,
    required this.description,
    required this.province,
    required this.city,
    required this.phoneNumber,
    required this.homeprice,
    required this.rentPrice,
    required this.metr,
    required this.buildingMetr,
    required this.countRoom,
    required this.floor,
    required this.yearBiuld,
    required this.images,
  });

  factory RegisterFutureAd.fromJson(Map<String, dynamic> jsonObject) {
    List<String> images = (jsonObject['images'] as List<dynamic>).map((images) {
      return '$images';
    }).toList();
    return RegisterFutureAd(
      id: jsonObject['ad_id'],
      created: jsonObject['created'],
      idFacilities: jsonObject['id_facilities'],
      idFeatures: jsonObject['id_features'],
      categoryId: jsonObject['id_category'],
      idGallery: jsonObject['id_gallery'],
      titlehome: jsonObject['title'],
      metr: jsonObject['metr'],
      buildingMetr: jsonObject['buildingmetr'],
      countRoom: jsonObject['count_room'],
      floor: jsonObject['floor'],
      yearBiuld: jsonObject['year_build'],
      homeprice: jsonObject['price'],
      rentPrice: jsonObject['rent_price'],
      description: jsonObject['description'],
      province: jsonObject['province'],
      city: jsonObject['city'],
      phoneNumber: jsonObject['phone_number'],
      images: images,
    );
  }
}
