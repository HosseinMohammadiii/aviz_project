abstract class AdFeaturesEvent {}

abstract class UserAdEvent {}

class AdFeaturesGetInitializeData extends AdFeaturesEvent {
  String facilitiesId;
  String idFeatures;

  AdFeaturesGetInitializeData(this.facilitiesId, this.idFeatures);
}

class AdExistsGetInitializeData extends AdFeaturesEvent {
  String id;
  AdExistsGetInitializeData(this.id);
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
