import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wave/auth/tokens.dart';

void requestLogin(String email, String password, [Function()? onSuccess, Function()? onError]) {
  http.post(
      Uri.parse("http://localhost:3000/api-token-auth/"),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode({
        'email': email,
        'password': password,
      })
  ).then((value) async {
    setToken(json.decode(value.body)['token']);
  });
}