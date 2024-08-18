import '../../../NetworkUtil/base_url.dart';

class RegisterFutureAd {
  String id;
  String categoryId;
  String idFacilities;
  String collectionId;
  String location;
  List<String> images;
  String titlehome;
  String description;
  int homeprice;
  RegisterFutureAd({
    required this.id,
    required this.categoryId,
    required this.idFacilities,
    required this.collectionId,
    required this.location,
    required this.images,
    required this.titlehome,
    required this.description,
    required this.homeprice,
  });

  factory RegisterFutureAd.fromJson(Map<String, dynamic> jsonObject) {
    List<String> images = (jsonObject['images'] as List<dynamic>).map((images) {
      return '${BaseUrl.baseUrl}files/${jsonObject['collectionId']}/${jsonObject['id']}/$images';
    }).toList();
    return RegisterFutureAd(
      id: jsonObject['id'],
      categoryId: jsonObject['category_name'],
      idFacilities: jsonObject['id_facilities'],
      collectionId: jsonObject['collectionId'],
      location: jsonObject['location'],
      images: images,
      titlehome: jsonObject['title_home'],
      description: jsonObject['description'],
      homeprice: jsonObject['home_price'],
    );
  }
}
