import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dartz/dartz.dart';

import '../../ad_details/Data/model/ad_detail.dart';

abstract class HomeState {}

final class HomeInitializeState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeRequestSuccessState extends HomeState {
  Either<String, List<AdvertisingHome>> getAdvertising;
  Either<String, List<AdvertisingHome>> hotAdvertising;
  Either<String, List<AdvertisingHome>> recentAdvertising;
  Either<String, List<AdvertisingFeatures>> advertisingdetails;

  HomeRequestSuccessState(
    this.getAdvertising,
    this.hotAdvertising,
    this.recentAdvertising,
    this.advertisingdetails,
  );
}
