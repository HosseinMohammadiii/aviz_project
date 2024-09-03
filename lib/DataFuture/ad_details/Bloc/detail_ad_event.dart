abstract class AdFeaturesEvent {}

abstract class AdImagesEvent {}

class AdFeaturesGetInitializeData extends AdFeaturesEvent {
  String adId;
  String facilitiesId;
  AdFeaturesGetInitializeData(this.adId, this.facilitiesId);
}

class AdGalleryImagesDataEvent extends AdImagesEvent {
  String id;
  AdGalleryImagesDataEvent(this.id);
}

final class AdGalleryListHomeEvent extends AdImagesEvent {
  List<String> id;
  AdGalleryListHomeEvent(this.id);
}
