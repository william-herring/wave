import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => Scaffold.of(context).openDrawer()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Quick actions', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 32.0)),
            const SizedBox(height: 16.0),
            Divider(
              thickness: 1.2,
              color: Colors.red[400],
            )
          ]
        ),
      )
    );
  }
}
