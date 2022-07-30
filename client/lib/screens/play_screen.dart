import 'dart:convert';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../adaptive/adaptive_icons.dart';
import '../main.dart';

class PlayScreen extends StatefulWidget {
  final String title;
  final String path;
  PlayScreen({Key? key, required this.title, required this.path}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState(title, path);
}

class _PlayScreenState extends State<PlayScreen> {
  String title;
  final String path;
  bool isPlaying = false;
  late final PlayerController playerController;
  _PlayScreenState(this.title, this.path);

  @override
  void initState() {
    super.initState();
    playerController = PlayerController();
    playerController.preparePlayer(path!);
  }

  void togglePlay() async {
    if (isPlaying) {
      await playerController.pausePlayer();
      setState(() {
        isPlaying = false;
      });
      return;
    }
    await playerController.startPlayer();
    setState(() {
      isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: InkWell(child: Icon(Icons.adaptive.more), onTapDown: (details) => showMenu(context: context,
            position: RelativeRect.fromLTRB(details.globalPosition.dx, details.globalPosition.dy, double.infinity, double.infinity), color: Theme.of(context).scaffoldBackgroundColor,
            items: <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Rename')
              ),
            ]).then((value) {
              if (value == 0) {
                showDialog<bool>(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: const Text('Rename'),
                      content: Card(
                        color: Colors.transparent,
                        elevation: 0.0,
                        child: Column(
                          children: [
                            CupertinoTextField(
                              placeholder: 'Title',
                              onSubmitted: (value) {
                                final waves = prefs.getStringList('waves');
                                final data = jsonEncode({
                                  'title': value,
                                  'type': 'Recording',
                                  'path': path,
                                });
                                waves?.forEach((element) {
                                  if (jsonDecode(element)['title'] == title) {
                                    waves[waves.indexOf(element)] = data;
                                    prefs.setStringList('waves', waves);
                                    return;
                                  }
                                });
                                setState(() => title = value);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
        })),
        actions: [
          IconButton(icon: Icon(AdaptiveIcons.check), onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AudioFileWaveforms(
              size: const Size(double.infinity, 80.0),
              playerWaveStyle: const PlayerWaveStyle(
                waveThickness: 4,
              ),
              playerController: playerController,
            ),
            Center(
              child:
                Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.only(right: 6),
                  child: IconButton(onPressed: () => togglePlay(), icon: Icon(isPlaying? AdaptiveIcons.pause : AdaptiveIcons.play)),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
            )
          ]
      ),
    );
  }
}
