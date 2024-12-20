class AccountInformation {
  String id;
  String name;
  String avatar;
  String email;
  String phoneNumber;
  String province;
  //AccountInformatio constructor model
  AccountInformation({
    required this.id,
    required this.name,
    required this.avatar,
    required this.email,
    required this.phoneNumber,
    required this.province,
  });
//AccountInformatio factory constructor model
  factory AccountInformation.fromJson(Map<String, dynamic> jsonObject) {
    return AccountInformation(
      id: jsonObject['id'],
      name: jsonObject['name'],
      avatar: jsonObject['avatar'],
      email: jsonObject['email'] ?? "",
      phoneNumber: jsonObject['phone_number'],
      province: jsonObject['province'] ?? "",
    );
  }
}
