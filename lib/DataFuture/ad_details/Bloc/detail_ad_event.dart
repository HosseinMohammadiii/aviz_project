abstract class AdFeaturesEvent {}

class AdFeaturesGetInitializeData extends AdFeaturesEvent {
  String adId;
  AdFeaturesGetInitializeData(this.adId);
}
