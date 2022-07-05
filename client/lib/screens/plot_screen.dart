import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:wave/adaptive/adaptive_dialog.dart';
import '../adaptive/adaptive_icons.dart';
import 'app_view.dart';

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double maxAmplitude = 1;
    double frequency = 20;
    double getY(time) => maxAmplitude * 0.01 * sin(2 * pi * frequency * time); // Returns Y value at any given point in time. See: https://en.wikipedia.org/wiki/Sine_wave
    
    print(getY(1));

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => false;
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
  double amplitude = 1;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  int sampleRate = 96000;
  List<int>? oneCycleData;

  _PlotScreenState(this.title);

  @override
  void initState() {
    super.initState();
    isPlaying = false;

    SoundGenerator.init(sampleRate);

    SoundGenerator.onIsPlayingChanged.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    SoundGenerator.onOneCycleDataHandler.listen((value) {
      setState(() {
        oneCycleData = value;
      });
    });

    SoundGenerator.setAutoUpdateOneCycleSample(true);
    SoundGenerator.refreshOneCycleData();
  }

  @override
  void dispose() {
    super.dispose();
    SoundGenerator.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(icon: Icon(Icons.adaptive.more), onPressed: () {}),
        actions: [
          IconButton(icon: Icon(AdaptiveIcons.check), onPressed: () => showAdaptiveAlertDialog(context, () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppView(page: 1)))))
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 0,
                    ),
                    child: CustomPaint(
                      size: MediaQuery.of(context).size,
                      painter: WavePainter(),
                    )),
                const SizedBox(height: 2),
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.red,
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(4.0),
                  margin: const EdgeInsets.only(right: 6),
                  child: IconButton(onPressed: () {
                    isPlaying
                        ? SoundGenerator.stop()
                        : SoundGenerator.play();
                  }, icon: Icon(isPlaying? AdaptiveIcons.pause : AdaptiveIcons.play)),
                  decoration: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(22),
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.red,
                ),
                const SizedBox(height: 5),
                const Text("Wave type"),
                Center(
                    child: DropdownButton<waveTypes>(
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
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
                              child: Text(classType.toString().split('.').last));
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
                const Text("Amplitude"),
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
                                Text(amplitude.toStringAsFixed(2))),
                          ),
                          Expanded(
                            flex: 8,
                            child: Slider(
                                min: 0,
                                max: 1,
                                value: amplitude,
                                onChanged: (_value) {
                                  setState(() {
                                    amplitude = _value.toDouble();
                                    SoundGenerator.setVolume(amplitude);
                                  });
                                }),
                          )
                        ]))
              ])
      )
    );
  }
}
