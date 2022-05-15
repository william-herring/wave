import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wave/auth/tokens.dart';

void requestLogin(String email, String password, [Function()? onSuccess, Function(Exception e)? onError]) async {
  final data = await http.post(
      Uri.parse("http://localhost:8000/api-token-auth/"),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({
        'email': email,
        'password': password,
      })
  );

  print(json.decode(data.body));

  if (json.decode(data.body)['status'] != 200) {
    onError;
    return;
  }

  setToken(json.decode(data.body)['token']);
  onSuccess;
}