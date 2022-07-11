import 'package:animations/animations.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

import 'create_screen.dart';

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
            const QuickRecordItem(),
            const SizedBox(height: 16.0),
            OpenContainer<String>(
                transitionDuration: const Duration(milliseconds: 500),
                openBuilder: (_, closeContainer) => CreateScreen(closeContainer: closeContainer),
                closedColor: Colors.transparent,
                closedElevation: 0,
                tappable: false,
                closedBuilder: (_, openContainer) => InkWell(
                    onTap: () => openContainer(),
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      width: MediaQuery.of(context).size.width - 40,
                      child: Center(
                        child: Icon(Icons.add, size: 32.0, color: Theme.of(context).primaryColor.withOpacity(0.5)),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(22),
                      ),
                    )
                )
            )
          ]
        ),
      )
    );
  }
}

class QuickRecordItem extends StatefulWidget {
  const QuickRecordItem({Key? key}) : super(key: key);

  @override
  _QuickRecordItemState createState() => _QuickRecordItemState();
}

class _QuickRecordItemState extends State<QuickRecordItem> {
  late final RecorderController recorderController;
  bool recordingHasStarted = false;

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
    if (recorderController.isRecording) {
      await recorderController.pause();
    } else {
      recorderController.refresh();
      await recorderController.record();
    }

    setState(() => recordingHasStarted = true);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleRecording,
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        child: !recorderController.isRecording && !recordingHasStarted? Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text('Tap to start/stop recording', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.5))),
        ) : AudioWaveforms(
          size: const Size(double.infinity, 80.0),
          waveStyle: WaveStyle(
            waveColor: Theme.of(context).primaryColor == Colors.white? Colors.blueGrey : Colors.grey,
            extendWaveform: true,
            showMiddleLine: false,
            waveThickness: 4,
          ),
          recorderController: recorderController,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(22),
        ),
      ),
    );
  }
}
