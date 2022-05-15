import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

void setToken(String token) {
  storage.write(key: "token", value: token);
}

void deleteToken() {
  storage.delete(key: "token");
}

Future<String?> getToken() async {
  String? newToken = await storage.read(key: "token");
  return newToken;
}