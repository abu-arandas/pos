import '/exports.dart';

class App {
  static String name = 'Arandas POS';
  static Widget logo = InkWell(
    onTap: () => page(page: const Home()),
    hoverColor: secondary.withOpacity(0.5),
    child: Image.asset(
      'assets/images/logo.png',
      width: 100,
      height: 100,
    ),
  );
}

Color primary = const Color(0xFFCFA671);
Color secondary = const Color(0xff17181f);
Color bg = const Color(0xff1f2029);
Color white = const Color(0xFFF4F5F9);
Color black = const Color(0xFF1B1C1E);
Color grey = const Color(0xFF808080);
Color transparent = Colors.transparent;

double dPadding = 16.0;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
bool webScreen(BuildContext context) => screenWidth(context).isGreaterThan(992);

void page({required page}) {
  Get.offAll(
    page,
    duration: const Duration(milliseconds: 300),
    transition: Transition.fade,
    curve: Curves.fastOutSlowIn,
  );
}
