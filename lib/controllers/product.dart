import '/exports.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> cart = <ProductModel>[].obs;

  /* ====== Read ======*/
  Future<List<Map<String, dynamic>>> products() async {
    return await Db().readData(table: 'Products');
  }

  /* ====== Cart ======*/
  void addToCart({required ProductModel product}) {
    if (cart.contains(product)) {
      cart[cart.indexOf(product)].cartQuantity++;
    } else {
      product.cartQuantity++;
      cart.add(product);
    }

    update();
  }

  void removeFromCart({required ProductModel product}) {
    if (cart[cart.indexOf(product)].cartQuantity == 1) {
      product.cartQuantity--;
      cart.remove(product);
    } else {
      cart[cart.indexOf(product)].cartQuantity--;
    }

    update();
  }

  void clearCart() {
    for (var product in cart) {
      product.cartQuantity = 0;
      update();
    }

    cart.clear();
  }

  double cartTotal() {
    double total = 0;
    for (var product in cart) {
      total = total + (product.price * product.cartQuantity);

      update();
    }

    return total;
  }

  /* ====== Create ======*/
  void createProduct({required ProductModel product}) async {
    try {
      Db.insertData(
        table: 'Products',
        item: {
          'id': await products().then((value) => value.length + 1),
          'title': product.title,
          'image': product.image,
          'price': product.price,
          'category': product.category,
        },
      );

      successSnackBar('Done');
      page(page: const Setting());
    } catch (error) {
      errorSnackBar(error.toString());
    }
  }

  /* ====== Update ======*/
  void updateProduct({required ProductModel product}) {
    try {
      Db.updateData(
        table: 'Products',
        item: {
          'id': product.id,
          'title': product.title,
          'image': product.image,
          'price': product.price,
          'category': product.category,
        },
      );

      successSnackBar('Done');
      page(page: const Setting());
    } catch (error) {
      errorSnackBar(error.toString());
    }
  }

  /* ====== Delete ======*/
  void deleteProduct({required ProductModel product}) {
    dialog(
      title: 'Are you sure?',
      content: const SizedBox(),
      actions: [
        // Delete
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () async {
              try {
                await Db.deleteData(table: 'Products', id: product.id);

                successSnackBar('Done');
                page(page: const Setting());
              } catch (error) {
                errorSnackBar(error.toString());
              }
            },
            child: const Text('Yes'),
          ),
        ),

        // Cancel
        SizedBox(
          width: 100,
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(grey),
              side: MaterialStatePropertyAll(BorderSide(color: grey)),
            ),
            child: const Text('Cancel'),
          ),
        )
      ],
    );
  }
}
