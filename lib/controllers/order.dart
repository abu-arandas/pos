import '/exports.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  /* ====== Read ======*/
  Future<List<Map<String, dynamic>>> orders() async => await Db().readData(table: 'Orders');

  Future<List<ProductModel>> orderProduct(int orderId) async {
    Database? myDb = await Db().db;
    List respose = await myDb!.query('Order_Products', where: 'orderId = $orderId');

    return List.generate(respose.length, (index) => ProductModel.fromMap(respose[index]));
  }

  /* ====== Create ======*/
  void createOrder() async {
    try {
      int id = await orders().then((value) => value.length + 1);

      // Orders Table
      Db.insertData(
        table: 'Orders',
        item: {'id': id, 'date': DateTime.now().millisecondsSinceEpoch},
      );

      // Order Products
      for (int i = 0; i < ProductController.instance.cart.length; i++) {
        ProductModel product = ProductController.instance.cart[i];

        product.orderId = id;

        Db.insertData(table: 'Order_Products', item: product.toJson());

        ProductController.instance.clearCart(product);
      }

      successSnackBar('Done');
      page(page: const Home());
    } catch (error) {
      errorSnackBar(error.toString());
    }
  }

  /* ====== Delete ======*/
  void deleteOrder({required OrderModel order}) async {
    try {
      await Db.deleteData(table: 'Orders', id: order.id);

      await orderProduct(order.id).then((value) async {
        for (var product in value) {
          await Db.deleteData(table: 'Order_Products', id: product.id);
        }
      });

      successSnackBar('Done');
      page(page: const Home());
    } catch (error) {
      errorSnackBar(error.toString());
    }
  }

  /* ====== Total ======*/
  RxDouble total = RxDouble(0);

  double ordersTotal({required List<OrderModel> orders}) {
    for (var order in orders) {
      order.products.then((value) {
        for (var product in value) {
          total.value = total.value + (product.price * product.cartQuantity);
          update();
        }
      });
    }

    return total.value;
  }
}

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
