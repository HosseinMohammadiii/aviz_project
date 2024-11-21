import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';
import 'package:dartz/dartz.dart';

import '../../add_advertising/Data/model/register_future_ad.dart';

abstract class SearchState {}

final class SearchInitialState extends SearchState {}

final class SearchRequestSuccessState extends SearchState {
  Either<String, List<RegisterFutureAd>> searchResult;
  Either<String, List<AdvertisingFacilities>> adFacilities;
  SearchRequestSuccessState(this.searchResult, this.adFacilities);
}

final class SearchExistsRequestSuccessState extends SearchState {
  Either<String, String> getExistAd;
  SearchExistsRequestSuccessState(this.getExistAd);
}

final class SearchLoadingState extends SearchState {}
