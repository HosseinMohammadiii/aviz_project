abstract class SaveAdEvent {}

final class GetInitializedSaveDataEvent extends SaveAdEvent {}

final class GetInitializedExistsSaveDataEvent extends SaveAdEvent {}

final class PostSaveAdEvent extends SaveAdEvent {
  String id;
  PostSaveAdEvent(this.id);
}

final class DeleteSaveAdEvent extends SaveAdEvent {
  String id;
  DeleteSaveAdEvent(this.id);
}

final class ExistsSaveAdEvent extends SaveAdEvent {
  String userId;
  String id;

  ExistsSaveAdEvent(this.userId, this.id);
}
