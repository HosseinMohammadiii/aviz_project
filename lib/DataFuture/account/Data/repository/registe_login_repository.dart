import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../NetworkUtil/api_exeption.dart';
import '../datasource/register_login_datasource.dart';
import '../model/account.dart';

abstract class IAuthRepository {
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm);

  Future<Either<String, String>> login(String username, String password);

  Future<Either<String, AccountInformation>> getDisplayUserInfo();

  Future<Either<String, String>> getUpdateUserInfo(File? avatar);

  Future<Either<String, String>> getUpdateNameUser(String name);

  Future<Either<String, String>> getUpdateEmailUser(String email);

  Future<Either<String, String>> getUpdatePhoneNumberUser(int phoneNumber);

  Future<Either<String, String>> getUpdateProvinceUser(String province);
}

class AuthencticationRepository extends IAuthRepository {
  final IAuthenticationDatasource _datasource;
  AuthencticationRepository(this._datasource);
  @override
  Future<Either<String, String>> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right('ثبت نام انجام شد!');
    } on ApiException catch (ex) {
      return left(ex.message ?? 'خطا محتوای متنی ندارد');
    }
  }

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

  @override
  Future<Either<String, AccountInformation>> getDisplayUserInfo() async {
    try {
      var response = await _datasource.getDisplayUserInfo();
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> getUpdateUserInfo(File? avatar) async {
    try {
      var response = await _datasource.getUpdateUserInfo(avatar);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> getUpdateNameUser(String name) async {
    try {
      var response = await _datasource.getUpdateNameUser(name);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> getUpdateEmailUser(String email) async {
    try {
      var response = await _datasource.getUpdateEmailUser(email);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

  @override
  Future<Either<String, String>> getUpdatePhoneNumberUser(
      int phoneNumber) async {
    try {
      var response = await _datasource.getUpdatePhoneNumberUser(phoneNumber);
      return right(response);
    } on ApiException catch (ex) {
      return left(ex.message = 'خطا محتوای متنی ندارد');
    }
  }

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
