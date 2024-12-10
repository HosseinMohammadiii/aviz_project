import 'package:dio/dio.dart';

// Custom exception class for handling API errors
class ApiException implements Exception {
  int code;
  String? message;
  Response<dynamic>? response;

  // Constructor to initialize the exception with the code, message, and optional response
  ApiException(this.code, this.message, {this.response}) {
    
    // Custom error message for a specific HTTP status code 413
    if (code == 413) {
      message = 'حجم تصویر بیشتر از 1 مگابایت است!';
    }
    // Custom error message if exist user
    if (message == "User already exists.") {
      message = 'نام‌کاربری قبلا ثبت شده است!';
    }
    // Custom error message if not correct username or password
    if (message == 'Failed to authenticate.') {
      message = 'نام کاربری یا رمز عبور اشتباه است';
    }
    // Custom error message if not create user account
    if (message == 'Failed to create record.') {
      message = 'متاسفانه نام کاربری ایجاد نشد!';
    }
    
    // Checking for specific error details in the API response
    if (response?.data['data']['username'] != null) {
      // If the username error message matches a specific condition
      if (response?.data['data']['username']['message'] ==
          'The username is invalid or already in use.') {
        message = 'نام‌کاربری نامعتبر است یا قبلا ثبت شده است!';
      }
    }
  }
}
