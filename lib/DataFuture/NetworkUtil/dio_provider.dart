import 'package:aviz_project/DataFuture/NetworkUtil/base_url.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../Hive/UsersLogin/user_login.dart';

class DioProvider {
  static Dio crateDio() {
    final Box<UserLogin> userLogin = Hive.box('user_login');
    Dio dio = Dio(
      BaseOptions(
        baseUrl: BaseUrl.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${userLogin.get(1)!.token}',
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
