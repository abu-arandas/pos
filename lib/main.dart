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
        useMaterial3: true,
        fontFamily: 'Montserrat',
        colorSchemeSeed: primary,
        brightness: Brightness.dark,
        buttonTheme: const ButtonThemeData(height: 50, minWidth: 200),
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
      home: const Home(),
    );
  }
}
