import 'exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Db().db;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bootstrapGridParameters(gutterSize: 12);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      title: App.name,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: primary,
        scaffoldBackgroundColor: bg,

        // Buttons
        buttonTheme: const ButtonThemeData(height: 50, minWidth: 200),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            animationDuration: const Duration(seconds: 1),
            elevation: const MaterialStatePropertyAll(0),
            padding: MaterialStatePropertyAll(EdgeInsets.all(dPadding / 2)),
            textStyle: const MaterialStatePropertyAll(
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            backgroundColor: MaterialStatePropertyAll(transparent),
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.hovered) ||
                      states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)
                  ? white
                  : primary,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            animationDuration: const Duration(seconds: 1),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.5),
              ),
            ),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.hovered) ||
                      states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)
                  ? white
                  : primary,
            ),
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.hovered) ||
                      states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)
                  ? primary
                  : white,
            ),
            padding: MaterialStatePropertyAll(EdgeInsets.all(dPadding / 2)),
            textStyle: const MaterialStatePropertyAll(
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            animationDuration: const Duration(seconds: 1),
            padding: MaterialStatePropertyAll(EdgeInsets.all(dPadding / 2)),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.5),
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(transparent),
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.hovered) ||
                      states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)
                  ? white
                  : primary,
            ),
            side: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.hovered) ||
                      states.contains(MaterialState.focused) ||
                      states.contains(MaterialState.pressed)
                  ? BorderSide(color: white)
                  : BorderSide(color: primary),
            ),
            textStyle: const MaterialStatePropertyAll(
              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Input
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: white),
          hintStyle: TextStyle(color: white),
          focusColor: white,
          hoverColor: white,
          contentPadding: EdgeInsets.all(dPadding),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.5),
            borderSide: BorderSide(color: white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.5),
            borderSide: BorderSide(color: white),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.5),
            borderSide: BorderSide(color: white),
          ),
        ),
      ),
      initialBinding: Bind(),
      home: OrientationBuilder(builder: (context, orientation) => const Home()),
    );
  }
}
