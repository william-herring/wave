import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/screens/app_view.dart';
import 'package:wave/screens/setup_view.dart';
import 'dev/tool/clear_data.dart';

late final SharedPreferences prefs;
bool? completedIntro = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Uncomment below to clear all user data/preferences
  // clearData();
  prefs = await SharedPreferences.getInstance();
  completedIntro = prefs.getBool('completedIntro');
  completedIntro ??= false;
  runApp(const App());
}

ThemeMode getThemeMode() {
  final theme = prefs.getString('theme');

  if (theme != null) {
    return theme == 'light'? ThemeMode.light : ThemeMode.dark;
  }

  return ThemeMode.system;
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(getThemeMode());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, ThemeMode theme, widget) {
        return MaterialApp(
          title: 'Wave',
          debugShowCheckedModeBanner: false,
          themeMode: theme,
          theme: ThemeData(
            primaryColor: Colors.black,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.red[400],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)
                ),
            ),
            appBarTheme: AppBarTheme(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 0,
                toolbarTextStyle: TextStyle(fontSize: 16, color: Colors.red[400]),
                iconTheme: IconThemeData(size: 16, color: Colors.red[400]),
                foregroundColor: Colors.red[400]
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.red[400],
            ),
          ),

          darkTheme: ThemeData(
            primaryColor: Colors.white,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.red[400],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)
              ),
            ),
            textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
            appBarTheme: AppBarTheme(
                backgroundColor: const Color.fromRGBO(12, 17, 28, 1),
                elevation: 0,
                titleTextStyle: TextStyle(fontSize: 16, color: Colors.red[400], fontWeight: FontWeight.bold),
                toolbarTextStyle: TextStyle(fontSize: 16, color: Colors.red[400]),
                iconTheme: IconThemeData(size: 16, color: Colors.red[400]),
                foregroundColor: Colors.red[400]
            ),
            iconTheme: const IconThemeData(
                color: Colors.white
            ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.grey.shade700),
              floatingLabelStyle: TextStyle(color: Colors.red.shade400),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade700),
                borderRadius: BorderRadius.circular(16.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.red[400],
            ),
            scaffoldBackgroundColor: const Color.fromRGBO(12, 17, 28, 1),
          ),
          home: completedIntro!? AppView(page: 0) : const SetupView(),
          routes: {
            '/home': (context) => AppView(page: 0),
            '/setup': (context) => const SetupView(),
          },
        );
      }
    );
  }
}
