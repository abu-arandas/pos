import '/exports.dart';

class Bind implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(CategoryController());
    Get.put(ProductController());
    Get.put(OrderController());
  }
}

class AuthController extends GetxController with StateMixin<bool> {
  static AuthController instance = Get.find();

  @override
  void onInit() {
    super.onInit();
    change(false, status: RxStatus.success());
  }

  /* === Sign In === */
  void signIn({required String email, required String password}) {
    if (email == 'admin@pos.com' && password == 'adminPOS') {
      change(true, status: RxStatus.success());
      successSnackBar('Welcome Back');
    } else {
      errorSnackBar('Wrong email or password');
    }
  }

  /* === Sign Out === */
  void signOut() {
    change(false, status: RxStatus.success());
    successSnackBar('Good Bye');
  }
}
