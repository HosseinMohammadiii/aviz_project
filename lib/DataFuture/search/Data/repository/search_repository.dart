import 'package:aviz_project/DataFuture/search/Data/dataSource/search_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../../add_advertising/Data/model/register_future_ad.dart';

abstract class ISearchRepository {
  Future<Either<String, List<RegisterFutureAd>>> search(String query);
  Future<Either<String, String>> getExistsAd(String id);
}

class SearchRepository extends ISearchRepository {
  ISearchDataSource dataSource;
  SearchRepository(this.dataSource);
  @override
  Future<Either<String, List<RegisterFutureAd>>> search(String query) async {
    try {
      var response = await dataSource.getSearchResult(query);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'آگهی مورد نظر وجود ندارد');
    }
  }

  @override
  Future<Either<String, String>> getExistsAd(String id) async {
    try {
      var response = await dataSource.getExistsAdvertising(id);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
