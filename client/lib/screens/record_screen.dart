import 'package:flutter/material.dart';

class RecordScreen extends StatefulWidget {
  String title;
  RecordScreen({Key? key, required this.title}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState(title);
}

class _RecordScreenState extends State<RecordScreen> {
  String title;
  _RecordScreenState(this.title);

  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
