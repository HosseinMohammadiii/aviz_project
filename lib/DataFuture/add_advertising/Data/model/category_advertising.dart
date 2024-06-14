class CategoryAdvertising {
  String id;
  String categoryname;
  CategoryAdvertising({
    required this.id,
    required this.categoryname,
  });

  factory CategoryAdvertising.fromJson(Map<String, dynamic> jsonObject) {
    return CategoryAdvertising(
      id: jsonObject['id'],
      categoryname: jsonObject['category_name'],
    );
  }
}
