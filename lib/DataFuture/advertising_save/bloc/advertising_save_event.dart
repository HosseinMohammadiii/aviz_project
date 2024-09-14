abstract class SaveAdEvent {}

final class GetInitializedSaveDataEvent extends SaveAdEvent {}

final class PostSaveAdEvent extends SaveAdEvent {
  String id;
  PostSaveAdEvent(this.id);
}

final class DeleteSaveAdEvent extends SaveAdEvent {
  String id;
  DeleteSaveAdEvent(this.id);
}
