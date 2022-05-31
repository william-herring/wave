import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:wave/adaptive/adaptive_dialog.dart';
import '../adaptive/adaptive_icons.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

class RecordScreen extends StatefulWidget {
  final String title;
  const RecordScreen({Key? key, required this.title}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState(title);
}

class _RecordScreenState extends State<RecordScreen> {
  String title;
  late final RecorderController recorderController;
  final Record audioRecorder = Record();
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isEditing = false;
  bool isRecording = false;
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
      await audioRecorder.pause();
      await recorderController.pause();
      return;
    } else {
      if (await audioRecorder.hasPermission()) {
        await audioRecorder.start(
          path: 'aFullPath/myFile.m4a'
        );
      }

      recorderController.refresh();
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
          IconButton(icon: Icon(AdaptiveIcons.check), onPressed: () => showAdaptiveAlertDialog(context)),
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
          Container(
            width: MediaQuery.of(context).size.width - 40,
            margin: const EdgeInsets.all(12),
            padding: isEditing? const EdgeInsets.all(6) : null,
            child: AudioWaveforms(
              enableGesture: true,
              size: const Size(double.infinity, 80.0),
              waveStyle: const WaveStyle(
                showMiddleLine: false,
                waveThickness: 4,
              ),
              recorderController: recorderController,
            ),
            decoration: isEditing? BoxDecoration(
              border: Border(
                  left: const BorderSide(color: Colors.yellow, width: 5),
                  right: const BorderSide(color: Colors.yellow, width: 5),
                  top: BorderSide(color: Colors.yellow.withOpacity(0.4), width: 2),
                  bottom: BorderSide(color: Colors.yellow.withOpacity(0.4), width: 2),
              ),
            ) : null,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.only(right: 6),
                child: IconButton(onPressed: () {
                  audioPlayer.play('testurldoesnotwork.com');
                }, icon: Icon(AdaptiveIcons.play)),
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
              Container(
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.only(left: 6),
                child: IconButton(onPressed: () => setState(() => isEditing = !isEditing), icon: Icon(AdaptiveIcons.edit)),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(22),
                  border: isEditing? Border.all(color: Colors.yellow) : null
                ),
              ),
            ],
          )
        ]
      ),
    );
  }
}
