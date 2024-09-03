abstract class HomeEvent {}

class HomeGetInitializeData extends HomeEvent {}

final class HomeGetInitializedFutureEvent extends HomeEvent {
  String id;
  HomeGetInitializedFutureEvent(this.id);
}
