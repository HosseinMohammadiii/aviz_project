import '../../../NetworkUtil/base_url.dart';

class AccountInformation {
  String id;
  String name;
  String avatar;
  String email;
  int phoneNumber;
  String province;
  AccountInformation({
    required this.id,
    required this.name,
    required this.avatar,
    required this.email,
    required this.phoneNumber,
    required this.province,
  });

  factory AccountInformation.fromJson(Map<String, dynamic> jsonObject) {
    return AccountInformation(
      id: jsonObject['id'],
      name: jsonObject['name'],
      avatar:
          '${BaseUrl.baseUrl}files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['avatar']}',
      email: jsonObject['email_user'],
      phoneNumber: jsonObject['phone_number'],
      province: jsonObject['province'],
    );
  }
}
