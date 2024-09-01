import 'package:hive/hive.dart';

import '../../Hive/UsersLogin/user_login.dart';

class Authmanager {
  UserLogin user = UserLogin();
  final Box<UserLogin> userLogin = Hive.box('user_login');

  void saveToken(String token) {
    user.token = token;
    user.isLogin = true;
    userLogin.put(1, user);
  }

  String getToken() {
    return userLogin.get(1)?.token ?? '';
  }

  void saveId(String id) {
    user.id = id;
    userLogin.put(2, user);
  }

  String getId() {
    return userLogin.get(2)!.id ?? '';
  }

  void isLogout() {
    user.token = null;

    userLogin.put(1, user);
  }

  bool isLogin() {
    return userLogin.get(1)?.token?.isNotEmpty ?? false;
  }
}
