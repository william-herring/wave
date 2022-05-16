import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wave/auth/tokens.dart';

void requestLogin(String username, String password, {Function? onSuccess, Function? onError}) async {
  final data = await http.post(
      Uri.parse("http://127.0.0.1:8000/api-token-auth/"),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({
        'username': username,
        'password': password,
      })
  );

  if (data.statusCode != 200) {
    onError!();
    throw Exception('Failed to log in. ${jsonDecode(data.body)}');
  }

  setToken(json.decode(data.body)['token']);
  onSuccess!();
}