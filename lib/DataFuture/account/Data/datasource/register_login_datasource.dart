import 'dart:io';

import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/account/Data/model/account.dart';
import 'package:dio/dio.dart';

import '../../../NetworkUtil/api_exeption.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(
      String userName, String password, String passwordConfirm);

  Future<String> login(String userName, String password);
  Future<AccountInformation> getDisplayUserInfo();
  Future<String> getUpdateUserInfo(File? avatar);
  Future<String> getUpdateNameUser(String name);
  Future<String> getUpdateEmailUser(String email);
  Future<String> getUpdatePhoneNumberUser(int phoneNumber);
}

class AuthenticationRemote extends IAuthenticationDatasource {
  final Dio dio;

  AuthenticationRemote(this.dio);

  @override
  Future<void> register(
      String userName, String password, String passwordConfirm) async {
    try {
      var request = await dio.post('collections/users/records', data: {
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
          await dio.post('collections/users/auth-with-password', data: {
        'identity': userName,
        'password': password,
      });
      if (response.statusCode == 200) {
        Authmanager().saveId(response.data?['record']['id']);
        Authmanager().saveToken(response.data?['token']);

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

  @override
  Future<AccountInformation> getDisplayUserInfo() async {
    try {
      var response = await dio.get(
        'collections/users/records/${Authmanager().getId()}',
        options: Options(
            headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'}),
      );

      // Assuming response data is directly the user object.
      return AccountInformation.fromJson(response.data);
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown error');
    }
  }

  @override
  Future<String> getUpdateUserInfo(File? avatar) async {
    try {
      String fileName = avatar!.path.split('/').last;
      MultipartFile imageFile = await MultipartFile.fromFile(
        avatar.path,
        filename: fileName,
      );

      FormData formData = FormData.fromMap({
        'avatar': imageFile,
      });

      var response = await dio.patch(
        'collections/users/records/${Authmanager().getId()}',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
        data: formData,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      // Assuming response data is directly the user object.
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown error');
    }
    return '';
  }

  @override
  Future<String> getUpdateNameUser(String name) async {
    try {
      var response = await dio.patch(
        'collections/users/records/${Authmanager().getId()}',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
        data: {
          'name': name,
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      // Assuming response data is directly the user object.
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown error');
    }
    return '';
  }

  @override
  Future<String> getUpdateEmailUser(String email) async {
    try {
      var response = await dio.patch(
        'collections/users/records/${Authmanager().getId()}',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
        data: {
          'email_user': email,
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      // Assuming response data is directly the user object.
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown error');
    }
    return '';
  }

  @override
  Future<String> getUpdatePhoneNumberUser(int phoneNumber) async {
    try {
      var response = await dio.patch(
        'collections/users/records/${Authmanager().getId()}',
        options: Options(
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
        data: {
          'phone_number': phoneNumber,
        },
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      // Assuming response data is directly the user object.
    } on DioException catch (ex) {
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      throw ApiException(0, 'Unknown error');
    }
    return '';
  }
}
