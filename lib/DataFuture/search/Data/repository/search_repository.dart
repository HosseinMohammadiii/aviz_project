import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:aviz_project/DataFuture/search/Data/dataSource/search_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../add_advertising/Data/model/ad_gallery.dart';

abstract class ISearchRepository {
  Future<Either<String, List<AdvertisingHome>>> search(String query);
  Future<Either<String, List<RegisterFutureAdGallery>>> getDiplayImagesAd();
}

class SearchRepository extends ISearchRepository {
  ISearchDataSource dataSource;
  SearchRepository(this.dataSource);
  @override
  Future<Either<String, List<AdvertisingHome>>> search(String query) async {
    try {
      var response = await dataSource.getSearchResult(query);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'آگهی مورد نظر وجود ندارد');
    }
  }

  @override
  Future<Either<String, List<RegisterFutureAdGallery>>>
      getDiplayImagesAd() async {
    try {
      var response = await dataSource.getDiplayImagesAd();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'آگهی مورد نظر وجود ندارد');
    }
  }
}
