import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:wave/adaptive/adaptive_dialog.dart';
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
  late final PlayerController playerController;
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
      await recorderController.pause();
      return;
    } else {
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
                extendWaveform: true,
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
                child: IconButton(onPressed: () {}, icon: Icon(AdaptiveIcons.play)),
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
                ),
              ),
            ],
          )
        ]
      ),
    );
  }
}
