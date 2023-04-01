import '/exports.dart';
import 'package:intl/intl.dart';

errorSnackBar(String text) {
  return Get.snackbar(
    'Error',
    text,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color(0xFFFF3333),
    colorText: white,
  );
}

successSnackBar(String text) {
  return Get.snackbar(
    'Success',
    text,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color(0xFF4BB543),
    colorText: white,
  );
}

Center waitContainer() {
  return Center(
    child: SizedBox(
      width: 100,
      height: 100,
      child: CircularProgressIndicator(color: primary),
    ),
  );
}

dialog({required String title, required Widget content, List<Widget>? actions}) {
  Get.dialog(
    AlertDialog(
      backgroundColor: secondary,

      // Title
      title: Text(
        title,
        style: TextStyle(color: white, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      titlePadding: EdgeInsets.all(dPadding),

      // Content
      content: content,
      contentPadding: EdgeInsets.symmetric(horizontal: dPadding),

      // Actions
      actionsAlignment: MainAxisAlignment.spaceAround,
      actionsPadding: EdgeInsets.all(dPadding),
      actions: actions,
    ),
  );
}

String dateFormat({required DateTime date, required bool isFull}) =>
    isFull ? DateFormat('d M yyyy : h mm s').format(date) : DateFormat('d M yyyy').format(date);
