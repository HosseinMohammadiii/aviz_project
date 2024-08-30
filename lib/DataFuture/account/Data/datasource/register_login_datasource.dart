import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../../Hive/UsersLogin/user_login.dart';
import '../../../NetworkUtil/api_exeption.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(
      String userName, String password, String passwordConfirm);

  Future<String> login(String userName, String password);
}

class AuthenticationRemote extends IAuthenticationDatasource {
  final Dio _dio;
  final Box<UserLogin> userLogin = Hive.box('user_login');

  AuthenticationRemote(this._dio);

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
        await login(userName, password);
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode!, ex.response?.data['message'],
          response: ex.response);
    } catch (ex) {
      throw ApiException(0, 'لطفا برنامه را کامل بسته و مجدد باز کنید');
    }
  }

  @override
  Future<String> login(String userName, String password) async {
    try {
      var response =
          await _dio.post('collections/users/auth-with-password', data: {
        'identity': userName,
        'password': password,
      });
      if (response.statusCode == 200) {
        UserLogin userLoginState = UserLogin(
          isLogin: true,
          token: response.data?['token'],
        );
        await userLogin.put(1, userLoginState);
        return response.data?['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response!.statusCode!, ex.response?.data['message'],
          response: ex.response);
    } catch (ex) {
      throw ApiException(0, 'لطفا برنامه را کامل بسته و مجدد باز کنید');
    }
    return '';
  }
}
