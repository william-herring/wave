import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:wave/adaptive/adaptive_dialog.dart';
import 'package:wave/main.dart';
import '../adaptive/adaptive_icons.dart';
import 'app_view.dart';

class WavePainter extends CustomPainter {
  double maxAmplitude; // Amplitude is the highest point a wave can reach to. It is also referred to as the volume of a sound.
  double frequency; // Frequency is the rate at which a cycle will repeat itself.
  double balance; // Balance can be used to shift the wave horizontally.
  Color waveColor;

  WavePainter(this.maxAmplitude, this.frequency, this.balance, this.waveColor);

  @override
  void paint(Canvas canvas, Size size) {
    double getY(time) => maxAmplitude * sin(2 * pi * frequency * time + balance); // Returns Y value at any given point in time. See: https://en.wikipedia.org/wiki/Sine_wave
    List<Offset> points = [];

    for (double t = 0; t <= size.width / 10000; t += 0.0001) {
      points.add(Offset(t * 10000, getY(t) * 100));
    }

    final paint = Paint()
      ..color = waveColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => false;
}

class PlotScreen extends StatefulWidget {
  final String title;
  final double frequency;
  final double balance;
  final double amplitude;
  const PlotScreen({Key? key, required this.title, this.frequency = 20, this.balance = 0, this.amplitude = 1}) : super(key: key);

  @override
  _PlotScreenState createState() => _PlotScreenState(title, frequency, balance, amplitude);
}

class _PlotScreenState extends State<PlotScreen> {
  String title;
  bool isPlaying = false;
  double frequency;
  double balance;
  double amplitude;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  int sampleRate = 96000;
  List<int>? oneCycleData;

  _PlotScreenState(this.title, this.frequency, this.balance, this.amplitude);

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
        leading: InkWell(child: Icon(Icons.adaptive.more), onTapDown: (details) => showMenu(context: context, position: RelativeRect.fromLTRB(details.globalPosition.dx, details.globalPosition.dy, double.infinity, double.infinity), color: Theme.of(context).scaffoldBackgroundColor,
            items: <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                  value: 0,
                  child: Text('Rename')
              ),
            ])),
        actions: [
          IconButton(icon: Icon(AdaptiveIcons.check), onPressed: () {SoundGenerator.stop(); showAdaptiveAlertDialog(context, () {
            final waves = prefs.getStringList('waves');
            final data = jsonEncode({
              'title': title,
              'frequency': frequency,
              'balance': balance,
              'amplitude': amplitude
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
          });})
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
          size: MediaQuery.of(
            context).size,
                      painter: WavePainter(amplitude, frequency, balance, Theme.of(context).primaryColor),
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
                const Text("Frequency", style: TextStyle(fontWeight: FontWeight.bold)),
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
                                        " Hz", textAlign: TextAlign.center)),
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
                const Text("Balance", style: TextStyle(fontWeight: FontWeight.bold)),
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
                const Text("Amplitude", style: TextStyle(fontWeight: FontWeight.bold)),
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
