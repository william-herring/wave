import 'package:flutter/material.dart';
import 'package:wave/screens/login_view.dart';
import 'package:wave/screens/setup.dart';

void main() {
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
        primaryColor: Colors.white,
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
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
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
      home: const LoginView(),
      routes: {
        '/login': (context) => const LoginView(),
        '/setup': (context) => const SetupScreen()
      },
    );
  }
}
