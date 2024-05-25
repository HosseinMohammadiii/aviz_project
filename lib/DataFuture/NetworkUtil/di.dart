import 'package:aviz_project/DataFuture/NetworkUtil/dio_provider.dart';
import 'package:aviz_project/DataFuture/home/Data/datasource/home_datasource.dart';
import 'package:aviz_project/DataFuture/home/Data/repository/home_repository.dart';
import 'package:aviz_project/DataFuture/search/Data/dataSource/search_datasource.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../search/Data/repository/search_repository.dart';

var locator = GetIt.instance;

Future<void> getInInit() async {
  locator.registerSingleton<Dio>(DioProvider.crateDio());

  //locator Datasource
  locator.registerFactory<IHomeDataSoure>(
    () => HomeRemoteDataSource(
      locator.get(),
    ),
  );
  locator.registerFactory<ISearchDataSource>(
    () => SearchRemootDataSorce(
      locator.get(),
    ),
  );

  //locator Repository
  locator.registerFactory<IHomeRepository>(
    () => HomeRepository(
      locator.get(),
    ),
  );
  locator.registerFactory<ISearchRepository>(
    () => SearchRepository(
      locator.get(),
    ),
  );
}
