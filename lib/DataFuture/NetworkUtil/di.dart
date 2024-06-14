import 'package:aviz_project/DataFuture/NetworkUtil/dio_provider.dart';
import 'package:aviz_project/DataFuture/ad_details/Data/datasource/ad_detail_datasource.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/repository/category_advertising_repository.dart';
import 'package:aviz_project/DataFuture/home/Data/datasource/home_datasource.dart';
import 'package:aviz_project/DataFuture/home/Data/repository/home_repository.dart';
import 'package:aviz_project/DataFuture/search/Data/dataSource/search_datasource.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../ad_details/Data/repository/ad_detail_repository.dart';
import '../add_advertising/Data/datasource/category_advertising_datasource.dart';
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
  locator.registerFactory<IAdvertisingFeaturesDataSoure>(
    () => IAdFeaturesRemoteDataSource(
      locator.get(),
    ),
  );
  locator.registerFactory<ICategoryAdvertisingDatasource>(
    () => CategoryAdvertisingRemoot(
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
  locator.registerFactory<IAddDetailFuturesRepository>(
    () => AdDetailRepository(
      locator.get(),
    ),
  );
  locator.registerFactory<ICategoryAdvertisingRepository>(
    () => CategoryAdvertisingRepository(
      locator.get(),
    ),
  );
}
