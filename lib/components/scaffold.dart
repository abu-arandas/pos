import '/exports.dart';

class MyScaffold extends StatefulWidget {
  final String pageName;
  final List<Widget> body;
  const MyScaffold({super.key, required this.pageName, required this.body});

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthControlle>(
      init: AuthControlle(),
      builder: (controller) {
        // Logged In
        if (controller.logged) {
          return SafeArea(
            child: Scaffold(
              key: scaffoldKey,

              // Cart Drawer
              endDrawer: const Drawer(child: Cart()),

              // App Bar
              appBar: AppBar(
                backgroundColor: secondary,
                toolbarHeight: 100,
                title: App.logo,
                actions: [
                  link(
                    context: context,
                    title: 'Home',
                    icon: Icons.home,
                    onPressed: () => page(page: const Home()),
                  ),
                  link(
                    context: context,
                    title: 'History',
                    icon: Icons.history,
                    onPressed: () => page(page: const History()),
                  ),
                  link(
                    context: context,
                    title: 'Settings',
                    icon: Icons.settings,
                    onPressed: () => page(page: const Setting()),
                  ),
                  link(
                    context: context,
                    title: 'Cart',
                    icon: Icons.shopping_cart,
                    onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
                  ),
                ],
              ),

              // Body
              body: SingleChildScrollView(
                child: BootstrapContainer(
                  fluid: true,
                  padding: EdgeInsets.all(dPadding),
                  decoration: BoxDecoration(
                    color: secondary,
                    borderRadius: BorderRadius.circular(12.5),
                  ),
                  children: widget.body,
                ),
              ),
            ),
          );
        }

        // Not
        else {
          return const Login();
        }
      },
    );
  }

  Widget link(
      {required BuildContext context,
      required String title,
      required IconData icon,
      required void Function()? onPressed}) {
    return InkWell(
      onTap: onPressed,
      hoverColor: transparent,
      child: Container(
        margin: EdgeInsets.only(left: dPadding),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: widget.pageName == title ? white : transparent)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Icon(icon), if (webScreen(context)) Text(title)],
        ),
      ),
    );
  }
}
