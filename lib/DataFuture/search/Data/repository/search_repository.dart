import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:aviz_project/DataFuture/search/Data/dataSource/search_datasource.dart';
import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';

abstract class ISearchRepository {
  Future<Either<String, List<AdvertisingHome>>> search(String query);
}

class SearchRepository extends ISearchRepository {
  ISearchDataSource dataSource;
  SearchRepository(this.dataSource);
  @override
  Future<Either<String, List<AdvertisingHome>>> search(String query) async {
    try {
      var response = await dataSource.getSearchResult(query);
      return right(response);
    } on ApiExeption catch (ex) {
      return left(ex.message = 'آگهی مورد نظر وجود ندارد');
    }
  }
}
