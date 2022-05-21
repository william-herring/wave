import 'dart:convert';

import 'package:flutter/material.dart';
import '../auth/tokens.dart';
import '../objects/user.dart';
import 'package:http/http.dart' as http;

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late final Future<User> user;

  Future<User> getUser() async {
    final data = await http.get(
      Uri.parse('http://127.0.0.1:8000/get-user/'),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Token ${await getToken()}' },
    );

    if (data.statusCode == 200) {
      return User.fromJson(jsonDecode(data.body));
    }

    throw Exception('Failed to load user data');
  }

  @override
  void initState() {
    super.initState();
    user = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          FutureBuilder<User>(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(64.0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(360.0),
                            child: Image.network(
                                'https://ui-avatars.com/api/?name=${snapshot.data!.username}&background=00437d&color=fff')
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(snapshot.data!.username, style: const TextStyle(
                              fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                );
              }
              return Padding(
                padding: const EdgeInsets.all(64.0),
                child: CircularProgressIndicator(color: Colors.red[400]),
              );
            }
          ),
          ListView(shrinkWrap: true, children: const [])
        ],
      ),
    );
  }
}
