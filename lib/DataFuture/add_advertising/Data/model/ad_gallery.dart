class RegisterFutureAdGallery {
  String id;
  List<String> images;

  RegisterFutureAdGallery({
    required this.id,
    required this.images,
  });

  factory RegisterFutureAdGallery.fromJson(Map<String, dynamic> jsonObject) {
    List<String> images = (jsonObject['images'] as List<dynamic>).map((images) {
      return '$images';
    }).toList();
    return RegisterFutureAdGallery(
      id: jsonObject['id'],
      images: images,
    );
  }
}
