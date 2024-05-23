import 'package:aviz_project/DataFuture/NetworkUtil/base_url.dart';
import 'package:dio/dio.dart';

class DioProvider {
  static Dio crateDio() {
    return Dio(
      BaseOptions(baseUrl: BaseUrl.baseUrl),
    );
  }
}
