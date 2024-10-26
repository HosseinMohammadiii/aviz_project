class ProvinceModel {
  String name;
  ProvinceModel({required this.name});

  factory ProvinceModel.fromJson(Map<String, dynamic> jsonObject) {
    if (!jsonObject.containsKey('name') || jsonObject['name'] == null) {
      print("کلید 'name' یافت نشد یا مقدار null است.");
    }
    return ProvinceModel(
      name: jsonObject['name'] ?? "نام موجود نیست",
    );
  }
}
