abstract class AdFeaturesEvent {}

abstract class UserAdEvent {}

class AdFeaturesGetInitializeData extends AdFeaturesEvent {
  String adId;
  String facilitiesId;
  AdFeaturesGetInitializeData(this.adId, this.facilitiesId);
}

class AdGalleryImagesDataEvent extends UserAdEvent {
  String id;
  AdGalleryImagesDataEvent(this.id);
}

final class AdImageListHomeEvent extends UserAdEvent {
  String id;
  AdImageListHomeEvent(this.id);
}

class MyAdFeaturesGetInitializeData extends UserAdEvent {
  String adId;
  String facilitiesId;
  MyAdFeaturesGetInitializeData(this.adId, this.facilitiesId);
}
