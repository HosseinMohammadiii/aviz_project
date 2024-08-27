import 'package:aviz_project/DataFuture/NetworkUtil/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  final ValueNotifier<String?> authChangeNotifire = ValueNotifier(null);

  final SharedPreferences _sharedPreferences = locator.get();

  void saveToken(String token) {
    _sharedPreferences.setString('access_token', token);
    authChangeNotifire.value = token;
  }

  String getId() {
    return _sharedPreferences.getString('user_id') ?? '';
  }

  String readAuth() {
    return _sharedPreferences.getString('access_token') ?? '';
  }

  void logOut() {
    _sharedPreferences.clear();
    authChangeNotifire.value = null;
  }

  bool isLogin() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}
