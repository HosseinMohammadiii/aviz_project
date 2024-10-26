import 'package:aviz_project/DataFuture/NetworkUtil/dio_provider.dart';
import 'package:aviz_project/DataFuture/ad_details/Data/datasource/ad_detail_datasource.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/datasource/info_register_ad_datasource.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/repository/info_register_ad_repository.dart';
import 'package:aviz_project/DataFuture/advertising_save/datasource/advertising_save_datasource.dart';
import 'package:aviz_project/DataFuture/advertising_save/repository/advertising_save_repository.dart';
import 'package:aviz_project/DataFuture/home/Data/datasource/home_datasource.dart';
import 'package:aviz_project/DataFuture/home/Data/repository/home_repository.dart';
import 'package:aviz_project/DataFuture/province/Data/datasource/province_datasource.dart';
import 'package:aviz_project/DataFuture/province/Data/repository/province_repository.dart';
import 'package:aviz_project/DataFuture/recent/datasource/recent_datasource.dart';
import 'package:aviz_project/DataFuture/recent/repository/recent_repository.dart';
import 'package:aviz_project/DataFuture/search/Data/dataSource/search_datasource.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../account/Data/datasource/register_login_datasource.dart';
import '../account/Data/repository/registe_login_repository.dart';
import '../ad_details/Data/repository/ad_detail_repository.dart';
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

  locator.registerFactory<IInfoAdDatasource>(
    () => InfoAdDatasourceRemmot(
      locator.get(),
    ),
  );

  locator.registerFactory<IAuthenticationDatasource>(
    () => AuthenticationRemote(DioProvider.createDioWithoutHeader()),
  );

  locator.registerFactory<IRecentAdItems>(
    () => IRecentAdItemsDatasourceRemoot(
      locator.get(),
    ),
  );

  locator.registerFactory<ISaveAdItemsDatasource>(
    () => ISaveAdItemsDatasourceRemoot(
      locator.get(),
    ),
  );
  locator.registerFactory<IProvinceDatasource>(
    () => ProvinceDatasourceRemoot(),
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

  locator.registerFactory<IInfoAdRepository>(
    () => InfoAdRepository(
      locator.get(),
    ),
  );
  locator.registerFactory<IAuthRepository>(
    () => AuthencticationRepository(
      locator.get(),
    ),
  );

  locator.registerFactory<IRecentRepository>(
    () => IRecentRepositoryRemoot(
      locator.get(),
    ),
  );

  locator.registerFactory<ISaveAdRepository>(
    () => ISaveAdRepositoryRemoot(
      locator.get(),
    ),
  );
  locator.registerFactory<IProvinceRepository>(
    () => ProvinceRepositoryRemoot(
      ProvinceDatasourceRemoot(),
    ),
  );
}
