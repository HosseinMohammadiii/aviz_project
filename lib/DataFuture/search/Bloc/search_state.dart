import 'package:dartz/dartz.dart';

import '../../add_advertising/Data/model/ad_gallery.dart';
import '../../add_advertising/Data/model/register_future_ad.dart';

abstract class SearchState {}

final class SearchInitialState extends SearchState {}

final class SearchRequestSuccessState extends SearchState {
  Either<String, List<RegisterFutureAd>> searchResult;
  Either<String, List<RegisterFutureAdGallery>> advertisingGalleryDetails;
  SearchRequestSuccessState(this.searchResult, this.advertisingGalleryDetails);
}

final class SearchLoadingState extends SearchState {}
