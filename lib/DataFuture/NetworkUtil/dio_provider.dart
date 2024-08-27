import 'package:aviz_project/DataFuture/NetworkUtil/base_url.dart';
import 'package:aviz_project/DataFuture/account/authmanager.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static Dio crateDio() {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: BaseUrl.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AuthManager().readAuth()}',
        },
      ),
    );
    return dio;
  }

  static Dio createDioWithoutHeader() {
    Dio dio = Dio(BaseOptions(
      baseUrl: 'https://startflutter.ir/api/',
    ));

    return dio;
  }
}
