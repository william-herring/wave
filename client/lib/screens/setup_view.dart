import 'package:flutter/material.dart';

class SetupView extends StatefulWidget {
  const SetupView({Key? key}) : super(key: key);

  @override
  _SetupViewState createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                const Text('Skip'),
                Container(
                    margin: const EdgeInsets.only(right: 14, left: 6),
                    child: const Icon(Icons.arrow_forward_ios)
                ),
              ],
            ),
          )
        ],
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: PageView(
              controller: _pageController,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Before we start, let's work out what suits you", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                    Container(
                      margin: const EdgeInsets.only(top: 14.0),
                      child: Text('(Swipe to navigate)', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor.withOpacity(0.5)))
                    ),
                    const SizedBox(height: 26.0),
                      Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 6.0,
                      children: [
                        const Icon(Icons.circle, size: 12),
                        Icon(Icons.circle, size: 12, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                        Icon(Icons.circle, size: 12, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                        Icon(Icons.circle, size: 12, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                        Icon(Icons.circle, size: 12, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Choose a theme', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Image.asset('assets/images/lightdeviceframe.png', scale: 9),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Image.asset('assets/images/darkdeviceframe.png', scale: 9),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26.0),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 6.0,
                      children: [
                        Icon(Icons.circle, size: 12, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                        const Icon(Icons.circle, size: 12),
                        Icon(Icons.circle, size: 12, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                        Icon(Icons.circle, size: 12, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                        Icon(Icons.circle, size: 12, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('3'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('4'),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}
