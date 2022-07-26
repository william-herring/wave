import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:wave/adaptive/adaptive_dialog.dart';
import '../adaptive/adaptive_icons.dart';
import '../main.dart';
import 'app_view.dart';

class RecordScreen extends StatefulWidget {
  final String title;
  const RecordScreen({Key? key, required this.title}) : super(key: key);

  @override
  _RecordScreenState createState() => _RecordScreenState(title);
}

class _RecordScreenState extends State<RecordScreen> {
  String title;
  late final RecorderController recorderController;
  late final PlayerController playerController;
  bool isRecording = false;
  bool isPlaying = false;
  String path = '';
  bool paused = false;
  List<double> waveData = [];
  _RecordScreenState(this.title);

  @override
  void initState() {
    super.initState();
    recorderController = RecorderController();
    playerController = PlayerController();
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
      await playerController.stopPlayer();
      setState(() {
        isPlaying = false;
      });
    }
  }

  void togglePlay() async {
    if (isPlaying) {
      await playerController.pausePlayer();
      setState(() {
        isPlaying = false;
        paused = true;
      });
      return;
    }
    if (paused) {
      await playerController.startPlayer();
      setState(() {
        isPlaying = true;
        paused = false;
      });
    }
    var path = await recorderController.stop(false);
    path = path?.split('file://')[1];
    await playerController.preparePlayer(path!);
    await playerController.startPlayer();
    setState(() {
      isPlaying = true;
      path = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: InkWell(child: Icon(Icons.adaptive.more), onTapDown: (details) => showMenu(context: context, position: RelativeRect.fromLTRB(details.globalPosition.dx, details.globalPosition.dy, double.infinity, double.infinity), color: Theme.of(context).scaffoldBackgroundColor,
            items: <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Rename')
              ),
            ])),
        actions: [
          IconButton(icon: Icon(AdaptiveIcons.check), onPressed: () => showAdaptiveAlertDialog(context, () {
            recorderController.pause().then((value) => setState(() {
              isRecording = false;
              waveData = recorderController.waveData;
            }));
            final waves = prefs.getStringList('waves');
            final data = jsonEncode({
              'title': title,
              'type': 'Recording',
              'path': path,
            });
            bool save = false;
            waves?.forEach((element) {
              if (jsonDecode(element)['title'] == title) {
                waves[waves.indexOf(element)] = data;
                prefs.setStringList('waves', waves);
                save = true;
                return;
              }
            });
            if (!save) {
              prefs.setStringList(
                  'waves', waves == null ? [data] : waves + [data]);
            }
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppView(page: 1)));
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
                child: IconButton(onPressed: () => togglePlay(), icon: Icon(isPlaying? AdaptiveIcons.pause : AdaptiveIcons.play)),
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
