import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void clearData() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  const storage = FlutterSecureStorage();

  prefs.clear();
  storage.deleteAll();
}