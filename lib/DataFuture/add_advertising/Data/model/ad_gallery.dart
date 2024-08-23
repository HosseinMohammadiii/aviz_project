import '../../../NetworkUtil/base_url.dart';

class RegisterFutureAdGallery {
  String id;
  String collectionId;
  List<String> images;

  RegisterFutureAdGallery({
    required this.id,
    required this.collectionId,
    required this.images,
  });

  factory RegisterFutureAdGallery.fromJson(Map<String, dynamic> jsonObject) {
    List<String> images = (jsonObject['images'] as List<dynamic>).map((images) {
      return '${BaseUrl.baseUrl}files/${jsonObject['collectionId']}/${jsonObject['id']}/$images';
    }).toList();
    return RegisterFutureAdGallery(
      id: jsonObject['id'],
      collectionId: jsonObject['collectionId'],
      images: images,
    );
  }
}
