import '/exports.dart';

class OrderModel extends GetxController {
  int id;
  DateTime date;
  Future<List<ProductModel>> products;

  OrderModel({
    required this.id,
    required this.date,
    required this.products,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) {
    return OrderModel(
      id: data['id'],
      date: DateTime.fromMillisecondsSinceEpoch(data['date']),
      products: OrderController.instance.orderProduct(data['id']),
    );
  }
}
