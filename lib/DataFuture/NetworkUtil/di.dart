import 'package:aviz_project/DataFuture/NetworkUtil/dio_provider.dart';
import 'package:aviz_project/DataFuture/home/Data/datasource/home_datasource.dart';
import 'package:aviz_project/DataFuture/home/Data/repository/home_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> getInInit() async {
  locator.registerSingleton<Dio>(DioProvider.crateDio());

  //locator Datasource
  locator.registerFactory<IHomeDataSoure>(
    () => HomeRemoteDataSource(
      locator.get(),
    ),
  );

  //locator Repository
  locator.registerFactory<IHomeRepository>(
    () => HomeRepository(
      locator.get(),
    ),
  );
}
