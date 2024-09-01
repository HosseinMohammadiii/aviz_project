import 'package:hive/hive.dart';

part 'user_login.g.dart';

@HiveType(typeId: 0)
class UserLogin extends HiveObject {
  @HiveField(0)
  bool? isLogin;

  @HiveField(1)
  String? token;

  @HiveField(2)
  String? id;
  UserLogin({this.isLogin, this.token, this.id});
}
