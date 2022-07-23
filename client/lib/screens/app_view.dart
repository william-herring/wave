import 'package:flutter/material.dart';
import 'package:wave/screens/home_screen.dart';
import 'package:wave/screens/learn_screen.dart';
import 'package:wave/screens/settings_screen.dart';
import 'package:wave/screens/studio_screen.dart';
import '../adaptive/adaptive_icons.dart';
import 'package:flutter/services.dart';

class AppView extends StatefulWidget {
  AppView({Key? key, required this.page}) : super(key: key);
  int page;

  @override
  _AppViewState createState() => _AppViewState(page);
}

class _AppViewState extends State<AppView> {
  _AppViewState(this.page);
  late final PageController _pageController;
  int page;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: page);
  }

  List<Widget> buildNavigationItems() {
    List<Widget> items = [];

    final pages = [
      ['Home', AdaptiveIcons.home],
      ['Studio', AdaptiveIcons.mic],
      ['Learn', AdaptiveIcons.book],
      ['Settings', AdaptiveIcons.settings],
    ];

    for (int i = 0; i < pages.length; i++) {
      if (i == page) {
        items.add(ListTile(
          onTap: () {
            setState(() => page = i);
            _pageController.jumpToPage(i);
            HapticFeedback.mediumImpact();
            Navigator.pop(context);
          },
          leading: Icon(pages[i][1] as IconData, color: Colors.red[400]),
          title: Text(pages[i][0].toString(), style: TextStyle(color: Colors.red[400])),
        ));
        continue;
      }
      items.add(ListTile(
        onTap: () {
          setState(() => page = i);
          _pageController.jumpToPage(i);
          HapticFeedback.lightImpact();
          Navigator.pop(context);
        },
        leading: Icon(pages[i][1] as IconData, color: Theme.of(context).primaryColor),
        title: Text(pages[i][0].toString()),
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(48.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                      Colors.red.shade400,
                      Colors.red.shade600
                    ]),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(22), bottomRight: Radius.circular(22))
                ),
                child: Column(
                  children: [
                    Image.asset('assets/images/logo.png', scale: 24, color: Colors.white.withOpacity(0.4))
                  ],
                )
              ),
              ListView(shrinkWrap: true, children: buildNavigationItems()),
            ],
          ),
        ),
        body: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomeScreen(),
              StudioScreen(),
              LearnScreen(),
              SettingsScreen()
            ],
        ),
    );
  }
}
