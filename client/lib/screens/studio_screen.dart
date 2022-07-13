import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wave/adaptive/adaptive_icons.dart';
import 'package:animations/animations.dart';
import 'package:wave/main.dart';
import 'package:wave/screens/create_screen.dart';
import 'package:wave/screens/plot_screen.dart';
import 'package:wave/screens/record_screen.dart';

class StudioScreen extends StatelessWidget {
  const StudioScreen({Key? key}) : super(key: key);

  Widget buildDraftsList(BuildContext context) {
    final waves = prefs.getStringList('waves');
    final List<Widget> drafts = [];

    waves?.forEach((element) => drafts.add(
        ListTile(onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (BuildContext context) => PlotScreen(title: jsonDecode(element)['title'], frequency: jsonDecode(element)['frequency'],
              balance: jsonDecode(element)['balance'], amplitude: jsonDecode(element)['amplitude']),
        )), title: Text(jsonDecode(element)['title'])))
    );

    return waves == null? Container() : ListView(
      shrinkWrap: true,
      children: drafts,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context) => const RecordScreen(title: 'New recording'),
      )), child: Icon(AdaptiveIcons.mic)),
      appBar: AppBar(
        title: const Text('Studio'),
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => Scaffold.of(context).openDrawer()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Drafts', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 32.0)),
            const SizedBox(height: 16.0),
            OpenContainer<String>(
              transitionDuration: const Duration(milliseconds: 500),
              openBuilder: (_, closeContainer) => CreateScreen(closeContainer: closeContainer),
              closedColor: Colors.transparent,
              closedElevation: 0,
              tappable: false,
              closedBuilder: (_, openContainer) => InkWell(
                onTap: () => openContainer(),
                borderRadius: const BorderRadius.all(Radius.circular(22)),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Icon(Icons.add, size: 32.0, color: Theme.of(context).primaryColor.withOpacity(0.5)),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(22)),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            buildDraftsList(context)
          ],
        ),
      ),
    );
  }
}
