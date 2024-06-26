import 'package:aviz_project/DataFuture/NetworkUtil/base_url.dart';

class AdvertisingHome {
  String id;
  String collectionId;
  String title;
  String description;
  String created;
  int price;
  int metr;
  int room;
  int floor;
  int yerbuild;
  List<String> images;

  AdvertisingHome({
    required this.id,
    required this.collectionId,
    required this.title,
    required this.description,
    required this.created,
    required this.price,
    required this.metr,
    required this.room,
    required this.floor,
    required this.yerbuild,
    required this.images,
  });
  factory AdvertisingHome.fromJson(Map<String, dynamic> jsonObject) {
    List<String> images =
        (jsonObject['home_image'] as List<dynamic>).map((images) {
      return '${BaseUrl.baseUrl}files/${jsonObject['collectionId']}/${jsonObject['id']}/$images';
    }).toList();
    return AdvertisingHome(
      id: jsonObject['id'],
      collectionId: jsonObject['collectionId'],
      title: jsonObject['home_name'],
      description: jsonObject['home_description'],
      created: jsonObject['created'],
      price: jsonObject['home_price'],
      metr: jsonObject['metr'],
      room: jsonObject['room'],
      floor: jsonObject['floor'],
      yerbuild: jsonObject['year_build'],
      images: images,
    );
  }
}
