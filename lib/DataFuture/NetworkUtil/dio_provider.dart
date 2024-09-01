import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/NetworkUtil/base_url.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static Dio crateDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: BaseUrl.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Authmanager().getToken()}',
        },
      ),
    );
    return dio;
  }

  static Dio createDioWithoutHeader() {
    Dio dio = Dio(BaseOptions(
      baseUrl: BaseUrl.baseUrl,
    ));

    return dio;
  }
}
