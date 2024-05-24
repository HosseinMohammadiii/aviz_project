import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

final class HomeInitializeState extends HomeState {}

final class HomeRequestSuccessState extends HomeState {
  Either<String, List<AdvertisingHome>> hotAdvertising;
  Either<String, List<AdvertisingHome>> recentAdvertising;

  HomeRequestSuccessState(this.hotAdvertising, this.recentAdvertising);
}

final class HomeLoadingState extends HomeState {}
