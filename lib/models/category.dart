class CategoryModel {
  int id;
  String title;

  CategoryModel({required this.id, required this.title});

  factory CategoryModel.fromMap(Map data) {
    return CategoryModel(id: data['id'], title: data['title']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'title': title};
}
