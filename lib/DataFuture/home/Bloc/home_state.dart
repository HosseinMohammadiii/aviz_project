import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dartz/dartz.dart';

abstract class HomeState {}

final class HomeInitializeState extends HomeState {}

final class HomeRequestSuccessState extends HomeState {
  Either<String, List<AdvertisingHome>> hotAdvertising;

  HomeRequestSuccessState(this.hotAdvertising);
}

final class HomeLoadingState extends HomeState {}
