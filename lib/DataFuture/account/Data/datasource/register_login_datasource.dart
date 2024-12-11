import 'dart:io';

import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/account/Data/model/account.dart';
import 'package:dio/dio.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../../../class/firebase_messsaging.dart';
import '../../../NetworkUtil/api_exeption.dart';

abstract class IAuthenticationDatasource {
  // Registers a new user with a username and password.
  Future<void> register(String userName, String password);

  // Logs in a user and returns a token.
  Future<String> login(String userName, String password);

  // Fetches and returns account information of the current user.
  Future<AccountInformation> getDisplayUserInfo();

  // Updates the user's avatar and returns the new avatar URL.
  Future<String> getUpdateUserInfo(File? avatar);

  // Updates the user's name and returns the updated name.
  Future<String> getUpdateNameUser(String name);

  // Updates the user's email and returns the updated email address.
  Future<String> getUpdateEmailUser(String email);

  // Updates the user's phone number and returns the updated phone number.
  Future<String> getUpdatePhoneNumberUser(String phoneNumber);

  // Updates the user's province and returns the updated province.
  Future<String> getUpdateProvinceUser(String province);
}

class AuthenticationRemote extends IAuthenticationDatasource {
  final Dio dio;

  AuthenticationRemote(this.dio);

  @override
  Future<void> register(String userName, String password) async {
    try {
      // Sending a POST request to register a new user.
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

      // Automatically logs in the user if registration is successful.
      if (request.statusCode == 201) {
        await login(userName, password);
      }
    } on DioException catch (ex) {
      // Handles API-specific exceptions.
      throw ApiException(
        ex.response!.statusCode!,
        ex.response?.data['message'],
        response: ex.response,
      );
    } catch (ex) {
      // Handles unknown errors.
      throw ApiException(0, 'Please restart the application completely.');
    }
  }

  @override
  Future<String> login(String userName, String password) async {
    Jalali dt = Jalali.now(); // Used for generating a welcome message timestamp.
    try {
      // Sending a POST request to authenticate the user.
      var response = await dio.post(
        'user/logIn',
        data: {
          'username': userName,
          'password': password,
        },
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      if (response.statusCode == 200) {
        // Saves user ID and token, and displays a welcome notification.
        Authmanager().saveId(response.data?['data']['id']);
        Authmanager().saveToken(response.data?['data']['token']);
        showLocalNotification('Welcome',
            '${dt.year}.${dt.month}.${dt.day} ${dt.hour}:${dt.minute} Welcome ${response.data?['data']['name']}');

        return response.data?['data']['token'];
      }
    } on DioException catch (ex) {
      // Handles API-specific exceptions.
      throw ApiException(
        ex.response!.statusCode!,
        ex.response?.data['message'],
        response: ex.response,
      );
    } catch (ex) {
      // Handles unknown errors.
      throw ApiException(0, 'Please restart the application completely.');
    }
    return '';
  }

  @override
  Future<AccountInformation> getDisplayUserInfo() async {
    try {
      // Fetching user information by ID.
      var response = await dio.get(
        'usersInfo/${Authmanager().getId()}',
      );

      return AccountInformation.fromJson(response.data);
    } on DioException catch (ex) {
      // Handles API-specific exceptions.
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      // Handles unknown errors.
      throw ApiException(0, 'Unknown error');
    }
  }

  @override
  Future<String> getUpdateUserInfo(File? avatar) async {
    try {
      // Preparing the file for upload.
      String fileName = avatar!.path.split('/').last;
      MultipartFile imageFile = await MultipartFile.fromFile(
        avatar.path,
        filename: fileName,
      );

      // Creating the request payload.
      FormData formData = FormData.fromMap({
        'avatar': imageFile,
      });

      // Sending a POST request to update the user's avatar.
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
      // Handles API-specific exceptions.
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      // Handles unknown errors.
      throw ApiException(0, 'Unknown error');
    }
    return '';
  }

  @override
  Future<String> getUpdateNameUser(String name) async {
    try {
      // Sending a POST request to update the user's name.
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
    } on DioException catch (ex) {
      // Handles API-specific exceptions.
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      // Handles unknown errors.
      throw ApiException(0, 'Unknown error');
    }
    return '';
  }

  @override
  Future<String> getUpdateEmailUser(String email) async {
    try {
      // Sending a POST request to update the user's email.
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
    } on DioException catch (ex) {
      // Handles API-specific exceptions.
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      // Handles unknown errors.
      throw ApiException(0, 'Unknown error');
    }
    return '';
  }

  @override
  Future<String> getUpdatePhoneNumberUser(String phoneNumber) async {
    try {
      // Sending a POST request to update the user's phone number.
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
      if (response.statusCode == 200) {
        return response.data['data']['phone_number'];
      }
    } on DioException catch (ex) {
      // Handles API-specific exceptions.
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      // Handles unknown errors.
      throw ApiException(0, 'Unknown error');
    }
    return '';
  }

  @override
  Future<String> getUpdateProvinceUser(String province) async {
    try {
      // Sending a POST request to update the user's province.
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
    } on DioException catch (ex) {
      // Handles API-specific exceptions.
      throw ApiException(
          ex.response?.statusCode ?? 0, ex.response?.statusMessage ?? 'Error');
    } catch (e) {
      // Handles unknown errors.
      throw ApiException(0, 'Unknown error');
    }
    return '';
  }
}
