class ProvinceModel {
  String name;
  ProvinceModel({required this.name});

  factory ProvinceModel.fromJson(Map<String, dynamic> jsonObject) {
    return ProvinceModel(
      name: jsonObject['name'] ?? "نام موجود نیست",
    );
  }
}
