import 'package:hive/hive.dart';

import '../../Hive/UsersLogin/user_login.dart';

// Class for managing user authentication
class Authmanager {
  // A UserLogin object to store user-related data
  UserLogin user = UserLogin();
  
  // Reference to Hive box for user data
  final Box<UserLogin> userLogin = Hive.box('user_login');

  // Save the authentication token and update the login status
  void saveToken(String token) {
    user.token = token;
    user.isLogin = true;
    userLogin.put(1, user);
  }
  
  // Retrieve the saved authentication token
  String getToken() {
    return userLogin.get(1)?.token ?? '';
  }

  // Save the user ID to the Hive box
  void saveId(String id) {
    user.id = id;
    userLogin.put(2, user);
  }
  
  // Retrieve the saved user ID
  String getId() {
    return userLogin.get(2)!.id ?? '';
  }
  
  // Log out the user by clearing the token
  void logOut() {
    user.token = null;

    userLogin.put(1, user);
  }
  
  // Check if the user is logged in by verifying the token's existence
  bool isLogin() {
    return userLogin.get(1)?.token?.isNotEmpty ?? false;
  }
}
