import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wave/screens/home_screen.dart';
import '../adaptive/adaptive_icons.dart';
import '../auth/tokens.dart';
import '../objects/user.dart';
import 'package:http/http.dart' as http;

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final PageController _pageController;
  late final Future<User> user;

  Future<User> getUser() async {
    final data = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/get-user'),
      headers: { 'Content-Type': 'application/json', 'Authorization': 'Token ${await getToken()}' },
    );

    if (data.statusCode == 200) {
      return User.fromJson(jsonDecode(data.body));
    }

    throw Exception('Failed to load user data: ${data.body}');
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    user = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
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
                          decoration: BoxDecoration(
                              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                                Colors.red.shade400,
                                Colors.red.shade600
                              ]),
                              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(360.0),
                                  child: Image.network(
                                      'https://ui-avatars.com/api/?name=${snapshot.data!.username}&color=575757')
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(snapshot.data!.username, style: const TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.white)),
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
              ListView(shrinkWrap: true, children: [
                ListTile(
                  onTap: () {},
                  leading: Icon(AdaptiveIcons.home, color: Colors.red[400]),
                  title: Text('Home', style: TextStyle(color: Colors.red[400])),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(AdaptiveIcons.mic, color: Theme.of(context).primaryColor),
                  title: const Text('Studio'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(AdaptiveIcons.library, color: Theme.of(context).primaryColor),
                  title: const Text('Library'),
                ),
                ListTile(
                  onTap: () {},
                  leading: Icon(AdaptiveIcons.book, color: Theme.of(context).primaryColor),
                  title: const Text('Learn'),
                )
              ])
            ],
          ),
        ),
        body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomeScreen(),
            ],
        ),
    );
  }
}
