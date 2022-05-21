import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(64.0),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(360.0),
                        child: Image.network('https://ui-avatars.com/api/?name=William%20Herring&background=00437d&color=fff')
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('testuser', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                )
            ),
            ListView(shrinkWrap: true, children: const [])
          ],
        ),
      ),
    );
  }
}
