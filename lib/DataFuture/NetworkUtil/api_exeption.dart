import 'package:dio/dio.dart';

class ApiException implements Exception {
  int code;
  String? message;
  Response<dynamic>? response;
  ApiException(this.code, this.message, {this.response}) {
    // if (code != 400) {
    //   return;
    // }

    if (code == 413) {
      message = 'حجم تصویر بیشتر از 1 مگابایت است!';
    }
    if (message == "User already exists.") {
      message = 'نام‌کاربری قبلا ثبت شده است!';
    }
    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبور اشتباه است';
    }
    if (message == 'Failed to create record.') {
      message = 'متاسفانه نام کاربری ایجاد نشد!';
    }
    if (response?.data['data']['username'] != null) {
      if (response?.data['data']['username']['message'] ==
          'The username is invalid or already in use.') {
        message = 'نام‌کاربری نامعتبر است یا قبلا ثبت شده است!';
      }
    }
  }
}
