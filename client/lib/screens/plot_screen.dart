import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:wave/adaptive/adaptive_dialog.dart';
import '../adaptive/adaptive_icons.dart';

class MyPainter extends CustomPainter {
  final List<int> oneCycleData;

  MyPainter(this.oneCycleData);

  @override
  void paint(Canvas canvas, Size size) {
    var i = 0;
    List<Offset> maxPoints = [];

    final t = size.width / (oneCycleData.length - 1);
    for (var _i = 0, _len = oneCycleData.length; _i < _len; _i++) {
      maxPoints.add(Offset(
          t * i,
          size.height / 2 -
              oneCycleData[_i].toDouble() / 32767.0 * size.height / 2));
      i++;
    }

    final paint = Paint()
      ..color = Colors.red.shade400
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, maxPoints, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    if (oneCycleData != oldDelegate.oneCycleData) {
      return true;
    }
    return false;
  }
}

class PlotScreen extends StatefulWidget {
  final String title;
  const PlotScreen({Key? key, required this.title}) : super(key: key);

  @override
  _PlotScreenState createState() => _PlotScreenState(title);
}

class _PlotScreenState extends State<PlotScreen> {
  String title;
  bool isPlaying = false;
  double frequency = 20;
  double balance = 0;
  double volume = 1;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  int sampleRate = 96000;
  List<int>? oneCycleData;

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
      body: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.white54,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 0,
                    ),
                    child: oneCycleData != null
                        ? CustomPaint(
                      painter: MyPainter(oneCycleData!),
                    )
                        : Container()),
                const SizedBox(height: 2),
                Text("A Cycle Data Length is " +
                    (sampleRate / frequency).round().toString() +
                    " on sample rate " +
                    sampleRate.toString()),
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.red,
                ),
                const SizedBox(height: 5),
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.lightBlueAccent,
                    child: IconButton(
                        icon: Icon(
                            isPlaying ? Icons.stop : Icons.play_arrow),
                        onPressed: () {
                          isPlaying
                              ? SoundGenerator.stop()
                              : SoundGenerator.play();
                        })),
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.red,
                ),
                const SizedBox(height: 5),
                const Text("Wave Form"),
                Center(
                    child: DropdownButton<waveTypes>(
                        value: waveType,
                        onChanged: (waveTypes? newValue) {
                          setState(() {
                            waveType = newValue!;
                            SoundGenerator.setWaveType(waveType);
                          });
                        },
                        items:
                        waveTypes.values.map((waveTypes classType) {
                          return DropdownMenuItem<waveTypes>(
                              value: classType,
                              child: Text(
                                  classType.toString().split('.').last));
                        }).toList())),
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.red,
                ),
                const SizedBox(height: 5),
                const Text("Frequency"),
                SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Center(
                                child: Text(
                                    frequency.toStringAsFixed(2) +
                                        " Hz")),
                          ),
                          Expanded(
                            flex: 8, // 60%
                            child: Slider(
                                min: 20,
                                max: 10000,
                                value: frequency,
                                onChanged: (_value) {
                                  setState(() {
                                    frequency = _value.toDouble();
                                    SoundGenerator.setFrequency(
                                        frequency);
                                  });
                                }),
                          )
                        ])),
                const SizedBox(height: 5),
                const Text("Balance"),
                SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Center(
                                child: Text(
                                    balance.toStringAsFixed(2))),
                          ),
                          Expanded(
                            flex: 8,
                            child: Slider(
                                min: -1,
                                max: 1,
                                value: balance,
                                onChanged: (_value) {
                                  setState(() {
                                    balance = _value.toDouble();
                                    SoundGenerator.setBalance(
                                        balance);
                                  });
                                }),
                          )
                        ])),
                const SizedBox(height: 5),
                const Text("Volume"),
                SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Center(
                                child:
                                Text(volume.toStringAsFixed(2))),
                          ),
                          Expanded(
                            flex: 8,
                            child: Slider(
                                min: 0,
                                max: 1,
                                value: volume,
                                onChanged: (_value) {
                                  setState(() {
                                    volume = _value.toDouble();
                                    SoundGenerator.setVolume(volume);
                                  });
                                }),
                          )
                        ]))
              ])
      )
    );
  }
}
