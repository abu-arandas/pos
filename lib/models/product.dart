class ProductModel {
  int id, category;
  String title, image;
  double price;
  int cartQuantity;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.category,
    this.cartQuantity = 0,
  });

  factory ProductModel.fromMap(Map data) {
    return ProductModel(
      id: data['id'],
      title: data['title'],
      image: data['image'],
      price: double.parse(data['price'].toString()),
      category: data['category'],
      cartQuantity: data['cartQuantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'price': price,
      'category': category,
      'cartQuantity': cartQuantity,
    };
  }
}
