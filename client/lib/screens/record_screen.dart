import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import '../adaptive/adaptive_icons.dart';

class RecordScreen extends StatefulWidget {
  String title;
  RecordScreen({Key? key, required this.title}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState(title);
}

class _RecordScreenState extends State<RecordScreen> {
  String title;
  late final RecorderController recorderController;
  bool isRecording = false;
  _RecordScreenState(this.title);

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
  }

  void toggleRecording() async {
    setState(() {
      isRecording = !isRecording;
    });
    if (recorderController.isRecording) {
      await recorderController.pause();
      return;
    } else {
      await recorderController.record();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(icon: Icon(Icons.adaptive.more), onPressed: () {}),
        actions: [
          IconButton(icon: Icon(AdaptiveIcons.check), onPressed: () {}),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AudioWaveforms(
            size: const Size(double.infinity, 80.0),
            waveStyle: const WaveStyle(
              showMiddleLine: false,
              waveThickness: 4,
              extendWaveform: true,
            ),
            recorderController: recorderController,
          ),
          Container(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(onPressed: () => toggleRecording(), icon: Icon(isRecording? Icons.stop : AdaptiveIcons.mic)),
            decoration: BoxDecoration(
              color: Colors.red[400],
              borderRadius: BorderRadius.circular(22),
            ),
          )
        ]
      ),
    );
  }
}
