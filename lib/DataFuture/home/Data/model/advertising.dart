import 'package:aviz_project/DataFuture/NetworkUtil/base_url.dart';

class AdvertisingHome {
  String id;
  String collectionId;
  String title;
  String description;
  int price;
  String images;
  AdvertisingHome({
    required this.id,
    required this.collectionId,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
  });
  factory AdvertisingHome.fromJson(Map<String, dynamic> jsonObject) {
    return AdvertisingHome(
      id: jsonObject['id'],
      collectionId: jsonObject['collectionId'],
      title: jsonObject['home_name'],
      description: jsonObject['home_description'],
      price: jsonObject['home_price'],
      images:
          '${BaseUrl.baseUrl}files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['home_image']}',
    );
  }
}
