import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  final VoidCallback closeContainer;
  const CreateScreen({Key? key, required this.closeContainer}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState(closeContainer);
}

class _CreateScreenState extends State<CreateScreen> {
  final VoidCallback closeContainer;
  _CreateScreenState(this.closeContainer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a Wave'),
          leading: IconButton(icon: const Icon(Icons.close), onPressed: closeContainer),
        ),
    );
  }
}
