import '/exports.dart';

class Bind implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthControlle());
    Get.put(CategoryController());
    Get.put(ProductController());
    Get.put(OrderController());
  }
}

class AuthControlle extends GetxController {
  static AuthControlle instance = Get.find();
  bool logged = true;

  /* === Sign In === */
  void signIn({required String email, required String password}) {
    if (email == 'admin@pos.com' && password == 'adminPOS') {
      logged = true;
      update();
      successSnackBar('Welcome Back');
    } else {
      errorSnackBar('Wrong email or password');
    }
  }

  /* === Sign Out === */
  void signOut() {
    logged = false;
    update();
    successSnackBar('Good Bye');
  }
}
