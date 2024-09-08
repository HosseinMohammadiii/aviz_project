import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:dartz/dartz.dart';

import '../../add_advertising/Data/model/ad_gallery.dart';

abstract class SearchState {}

final class SearchInitialState extends SearchState {}

final class SearchRequestSuccessState extends SearchState {
  Either<String, List<AdvertisingHome>> searchResult;
  Either<String, List<RegisterFutureAdGallery>> advertisingGalleryDetails;
  SearchRequestSuccessState(this.searchResult, this.advertisingGalleryDetails);
}

final class SearchLoadingState extends SearchState {}
