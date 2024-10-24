import 'package:dartz/dartz.dart';

import '../../add_advertising/Data/model/register_future_ad.dart';

abstract class SearchState {}

final class SearchInitialState extends SearchState {}

final class SearchRequestSuccessState extends SearchState {
  Either<String, List<RegisterFutureAd>> searchResult;
  SearchRequestSuccessState(this.searchResult);
}

final class SearchLoadingState extends SearchState {}
