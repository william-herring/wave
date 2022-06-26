import 'package:flutter/material.dart';

import '../main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String theme = getThemeMode() == ThemeMode.light? 'light' : 'dark';

  void setTheme(String theme) {
    App.themeNotifier.value = theme == 'dark'? ThemeMode.dark : ThemeMode.light;
    prefs.setString('theme', theme);
    setState(() => theme = theme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(icon: const Icon(Icons.menu), onPressed: () => Scaffold.of(context).openDrawer()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Appearance', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 32.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Image.asset('assets/images/lightdeviceframe.png', scale: 11),
                          decoration: theme == 'light'? BoxDecoration(border: Border.all(color: Colors.red.shade400, width: 2), borderRadius: const BorderRadius.all(Radius.circular(11))) : null,
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.red[400]?.withOpacity(0.5),
                              onTap: () => setTheme('light'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Image.asset('assets/images/darkdeviceframe.png', scale: 11),
                          decoration: theme == 'dark'? BoxDecoration(border: Border.all(color: Colors.red.shade400, width: 2), borderRadius: const BorderRadius.all(Radius.circular(11))) : null,
                        ),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.red[400]?.withOpacity(0.5),
                              onTap: () => setTheme('dark'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ])
        )
    );
  }
}
