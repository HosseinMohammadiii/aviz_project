import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/NetworkUtil/base_url.dart';
import 'package:dio/dio.dart';

class DioProvider {
  // Creates and configures a `Dio` instance with headers.
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
   // Creates and configures a `Dio` instance without headers.
  // This can be used for requests that do not require authentication.
  static Dio createDioWithoutHeader() {
    Dio dio = Dio(BaseOptions(
      baseUrl: BaseUrl.baseUrl,
    ));

    return dio;
  }
}
