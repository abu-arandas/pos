import '/exports.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();

  /* ====== Read ======*/
  Future<List<Map<String, dynamic>>> orders() async {
    return await Db().readData(table: 'Orders');
  }

  Future<List<ProductModel>> orderProduct(int orderId) async {
    Database? myDb = await Db().db;
    List respose = await myDb!.query('Order_Products', where: 'orderId = $orderId');

    return List.generate(respose.length, (index) => ProductModel.fromMap(respose[index]));
  }

  /* ====== Create ======*/
  void createOrder() async {
    try {
      // Orders Table
      Db.insertData(
        table: 'Orders',
        item: {
          'id': await orders().then((value) => value.length + 1),
          'date': DateTime.now().millisecondsSinceEpoch,
        },
      );

      // Order Products
      for (int i = 0; i < ProductController.instance.cart.length; i++) {
        ProductModel product = ProductController.instance.cart[i];

        Db.insertData(
          table: 'Order_Products',
          item: {
            'id': i,
            'title': product.title,
            'image': product.image,
            'price': product.price,
            'orderId': product.id,
            'cartQuantity': product.cartQuantity,
          },
        );
      }

      /*
      'INSERT INTO Order_Products (id, title, image, price, orderId, cartQuantity) VALUES (?, ?, ?, ?, ?, ?)' args [0, Original Burger, assets/images/products/Original Burger.png, 5.99, 0, 1])*/

      // Clear Cart
      ProductController.instance.clearCart();

      successSnackBar('Done');
      page(page: const Home());
    } catch (error) {
      errorSnackBar(error.toString());
    }
  }

  /* ====== Update ======*/
  void updateOrder({required OrderModel order}) async {
    try {} catch (error) {
      errorSnackBar(error.toString());
    }
  }

  /* ====== Delete ======*/
  void deleteOrder({required OrderModel order}) async {
    try {} catch (error) {
      errorSnackBar(error.toString());
    }
  }
}
