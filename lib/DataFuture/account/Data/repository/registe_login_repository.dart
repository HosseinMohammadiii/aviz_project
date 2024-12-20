import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../datasource/register_login_datasource.dart';
import '../model/account.dart';

//Interface for the authentication repository.
abstract class IAuthRepository {
  Future<Either<String, String>> register(String username, String password);

  Future<Either<String, String>> login(String username, String password);

  Future<Either<String, AccountInformation>> getDisplayUserInfo();

  Future<Either<String, String>> getUpdateUserInfo(File? avatar);

  Future<Either<String, String>> getUpdateNameUser(String name);

  Future<Either<String, String>> getUpdateEmailUser(String email);

  Future<Either<String, String>> getUpdatePhoneNumberUser(String phoneNumber);

  Future<Either<String, String>> getUpdateProvinceUser(String province);
}

// Implementation of the authentication repository.
class AuthencticationRepository extends IAuthRepository {
  final IAuthenticationDatasource _datasource;
  // Constructor for data source for authentication-related operations.
  AuthencticationRepository(this._datasource);
  // Implements the register method to handle user registration using the datasource
  @override
  Future<Either<String, String>> register(
      String username, String password) async {
    try {
      await _datasource.register(username, password);
      return right('ثبت نام انجام شد!');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }
  // Implements the login method to handle user login using the datasource
  @override
  Future<Either<String, String>> login(String username, String password) async {
    try {
      String token = await _datasource.login(username, password);
      if (token.isNotEmpty) {
        return right('شما وارد شده اید');
      } else {
        return left('خطایی در ورود پیش آمده! ');
      }
    } on ApiException catch (ex) {
      return left('${ex.message}');
    }
  }
  // Fetches the user account information from the datasource and handles potenti
  @override
  Future<Either<String, AccountInformation>> getDisplayUserInfo() async {
    try {
      var response = await _datasource.getDisplayUserInfo();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
  // Updates the user's profile picture.
  @override
  Future<Either<String, String>> getUpdateUserInfo(File? avatar) async {
    try {
      var response = await _datasource.getUpdateUserInfo(avatar);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
  // Updates the user's name.
  @override
  Future<Either<String, String>> getUpdateNameUser(String name) async {
    try {
      var response = await _datasource.getUpdateNameUser(name);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
  // Updates the user's email.
  @override
  Future<Either<String, String>> getUpdateEmailUser(String email) async {
    try {
      var response = await _datasource.getUpdateEmailUser(email);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
  // Updates the user's phone number.
  @override
  Future<Either<String, String>> getUpdatePhoneNumberUser(
      String phoneNumber) async {
    try {
      var response = await _datasource.getUpdatePhoneNumberUser(phoneNumber);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
  // Updates the user's province information.
  @override
  Future<Either<String, String>> getUpdateProvinceUser(String province) async {
    try {
      var response = await _datasource.getUpdateProvinceUser(province);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }
}
