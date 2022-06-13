import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:wave/adaptive/adaptive_dialog.dart';
import 'package:wave/main.dart';
import '../adaptive/adaptive_icons.dart';

class RecordScreen extends StatefulWidget {
  final String title;
  const RecordScreen({Key? key, required this.title}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState(title);
}

class _RecordScreenState extends State<RecordScreen> {
  String title;
  late final RecorderController recorderController;
  bool isRecording = false;
  List<double> waveData = [];
  _RecordScreenState(this.title);

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
  }

  @override
  void dispose() {
    recorderController.disposeFunc();
    super.dispose();
  }

  void toggleRecording() async {
    setState(() {
      isRecording = !isRecording;
    });
    if (recorderController.isRecording) {
      await recorderController.pause();
      setState(() {
        waveData = recorderController.waveData;
      });
    } else {
      recorderController.refresh();
      await recorderController.record();
    }
  }

  void playRecording() async {
    await recorderController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(icon: Icon(Icons.adaptive.more), onPressed: () {}),
        actions: [
          IconButton(icon: Icon(AdaptiveIcons.check), onPressed: () => showAdaptiveAlertDialog(context, () {
            recorderController.pause().then((value) => setState(() {
              isRecording = false;
              waveData = recorderController.waveData;
            }));
            Navigator.pushReplacementNamed(context, '/home');
          })),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          !isRecording && recorderController.waveData.isEmpty? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text('Tap'), Icon(AdaptiveIcons.mic), const Text('to begin recording.')]),
          ) :
          SizedBox(
            width: MediaQuery.of(context).size.width - 40,
            child: AudioWaveforms(
              enableGesture: true,
              size: const Size(double.infinity, 80.0),
              waveStyle: const WaveStyle(
                extendWaveform: true,
                showMiddleLine: false,
                waveThickness: 4,
              ),
              recorderController: recorderController,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.only(right: 6),
                child: IconButton(onPressed: () => playRecording(), icon: Icon(AdaptiveIcons.play)),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.only(left: 6, right: 6),
                child: IconButton(onPressed: () => toggleRecording(), icon: Icon(isRecording? Icons.stop : AdaptiveIcons.mic)),
                decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ],
          )
        ]
      ),
    );
  }
}
