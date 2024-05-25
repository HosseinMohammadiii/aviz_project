import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dartz/dartz.dart';

abstract class SearchState {}

final class SearchInitialState extends SearchState {}

final class SearchRequestSuccessState extends SearchState {
  Either<String, List<AdvertisingHome>> searchResult;
  SearchRequestSuccessState(this.searchResult);
}

final class SearchLoadingState extends SearchState {}
