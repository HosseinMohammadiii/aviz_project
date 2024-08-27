import 'package:aviz_project/DataFuture/NetworkUtil/dio_provider.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../../authmanager.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(
      String userName, String password, String passwordConfirm);

  Future<String> login(String userName, String password);
}

class AuthenticationRemote implements IAuthenticationDatasource {
  final Dio _dio = DioProvider.createDioWithoutHeader();
  @override
  Future<String> login(String userName, String password) async {
    try {
      var response =
          await _dio.post('collections/users/auth-with-password', data: {
        'username': userName,
        'password': password,
      });
      if (response.statusCode == 200) {
        AuthManager().saveToken(response.data?['token']);
        return response.data?['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.data['message'],
          response: ex.response);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
    return '';
  }

  @override
  Future<void> register(
      String userName, String password, String passwordConfirm) async {
    try {
      var request = await _dio.post('collections/users/records', data: {
        'username': userName,
        'name': userName,
        'password': password,
        'passwordConfirm': passwordConfirm,
      });
      if (request.statusCode == 200) {
        login(userName, password);
      }
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.data['message'],
          response: ex.response);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
