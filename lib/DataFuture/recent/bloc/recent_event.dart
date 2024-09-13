abstract class RecentEvent {}

final class GetInitializedDataEvent extends RecentEvent {}

final class PostRecentEvent extends RecentEvent {
  String id;
  PostRecentEvent(this.id);
}
