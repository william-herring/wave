import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:wave/adaptive/adaptive_dialog.dart';
import '../adaptive/adaptive_icons.dart';
import 'app_view.dart';

class PlotScreen extends StatefulWidget {
  final String title;
  const PlotScreen({Key? key, required this.title}) : super(key: key);

  @override
  _PlotScreenState createState() => _PlotScreenState(title);
}

class _PlotScreenState extends State<PlotScreen> {
  String title;
  _PlotScreenState(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(icon: Icon(Icons.adaptive.more), onPressed: () {}),
        actions: [
          IconButton(icon: Icon(AdaptiveIcons.check), onPressed: () => showAdaptiveAlertDialog(context, () {}))
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [],
      ),
    );
  }
}
