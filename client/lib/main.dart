import 'package:flutter/material.dart';
import 'package:wave/auth/tokens.dart';
import 'package:wave/screens/app_view.dart';
import 'package:wave/screens/home_screen.dart';
import 'package:wave/screens/login_view.dart';
import 'package:wave/screens/setup_view.dart';

String? token = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  token = await getToken();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wave',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        primaryColor: Colors.black,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red[400]
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
        fontFamily: 'Ubuntu',
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
      home: token != null? const AppView() : const LoginView(),
      routes: {
        '/home': (context) => const AppView(),
        '/login': (context) => const LoginView(),
        '/setup': (context) => const SetupView(),
      },
    );
  }
}
