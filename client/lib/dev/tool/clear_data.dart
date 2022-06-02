import 'package:shared_preferences/shared_preferences.dart';

void clearData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.clear();
}