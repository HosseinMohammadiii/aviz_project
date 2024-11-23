import 'dart:io';

import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/account/Data/model/account.dart';
import 'package:dio/dio.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../../class/firebase_messsaging.dart';
import '../../../NetworkUtil/api_exeption.dart';

abstract class IAuthenticationDatasource {
  Future<void> register(String userName, String password);

  Future<String> login(String userName, String password);
  Future<AccountInformation> getDisplayUserInfo();
  Future<String> getUpdateUserInfo(File? avatar);
  Future<String> getUpdateNameUser(String name);
  Future<String> getUpdateEmailUser(String email);
  Future<String> getUpdatePhoneNumberUser(String phoneNumber);
  Future<String> getUpdateProvinceUser(String province);
}

class AuthenticationRemote extends IAuthenticationDatasource {
  final Dio dio;

  AuthenticationRemote(this.dio);

  @override
  Future<void> register(String userName, String password) async {
    try {
      var request = await dio.post(
        'user/registerUser',
        data: {
          'username': userName,
          'password': password,
          'password_confirm': password,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (request.statusCode == 201) {
        await login(userName, password);
      }
    } on DioException catch (ex) {
      throw ApiException(
        ex.response!.statusCode!,
        ex.response?.data['message'],
        response: ex.response,
      );
    } catch (ex) {
      throw ApiException(0, 'لطفا برنامه را کامل بسته و مجدد باز کنید');
    }
  }

  @override
  Future<String> login(String userName, String password) async {
    Jalali dt = Jalali.now();
    try {
      var response = await dio.post(
        'user/logIn',
        data: {
          'username': userName,
          'password': password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      if (response.statusCode == 200) {
        Authmanager().saveId(response.data?['data']['id']);
        Authmanager().saveToken(response.data?['data']['token']);
        showLocalNotification('آویز',
            '${dt.year}.${dt.month}.${dt.day} ${dt.hour}:${dt.minute} . ${response.data?['data']['name']} خوش آمدید');

        return response.data?['data']['token'];
      }
    } on DioException catch (ex) {
      throw ApiException(
        ex.response!.statusCode!,
        ex.response?.data['message'],
        response: ex.response,
      );
    } catch (ex) {
      throw ApiException(0, 'لطفا برنامه را کامل بسته و مجدد باز کنید');
    }
    return '';
  }

  @override
  Future<AccountInformation> getDisplayUserInfo() async {
    try {
      var response = await dio.get(
        'usersInfo/${Authmanager().getId()}',
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

      var response = await dio.post(
        'userupdate/${Authmanager().getId()}',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['data']['avatar'];
      }
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
      var response = await dio.post(
        'userupdate/${Authmanager().getId()}',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
        data: {
          'name': name,
        },
      );

      if (response.statusCode == 200) {
        return response.data['data']['name'];
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
      var response = await dio.post(
        'userupdate/${Authmanager().getId()}',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return response.data['data']['email'];
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
  Future<String> getUpdatePhoneNumberUser(String phoneNumber) async {
    try {
      var response = await dio.post(
        'userupdate/${Authmanager().getId()}',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
        data: {
          'phone_number': phoneNumber,
        },
      );
      print(response.data['data']['phone_number']);
      if (response.statusCode == 200) {
        return response.data['data']['phone_number'];
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
  Future<String> getUpdateProvinceUser(String province) async {
    try {
      var response = await dio.post(
        'userupdate/${Authmanager().getId()}',
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Authorization': 'Bearer ${Authmanager().getToken()}'},
        ),
        data: {
          'province': province,
        },
      );

      if (response.statusCode == 200) {
        return response.data['data']['province'];
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
