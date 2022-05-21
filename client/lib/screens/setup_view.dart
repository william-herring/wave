import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SetupView extends StatefulWidget {
  const SetupView({Key? key}) : super(key: key);

  @override
  _SetupViewState createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
  bool storeDataInCloud = true;
  String theme = 'dark'; // TODO: Update theme accordingly

  Widget buildBottomPageIndicator(int size, int page) {
    List<Widget> result = [];
    for (int i = 0; i <= size; i++) {
      result.add(Icon(Icons.circle, size: 12, color: i != page? Theme.of(context).iconTheme.color?.withOpacity(0.5) : Theme.of(context).iconTheme.color));
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6.0,
      children: result
    );
  }

  void launchRepo() async {
    if (!await launchUrl(Uri.parse('https://github.com/william-herring/wave/'))) throw 'Could not launch URL';
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
                    buildBottomPageIndicator(4, 0)
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
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                child: Image.asset('assets/images/lightdeviceframe.png', scale: 9),
                                decoration: theme == 'light'? BoxDecoration(border: Border.all(color: Colors.red.shade400, width: 2), borderRadius: const BorderRadius.all(Radius.circular(11))) : null,
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.red[400]?.withOpacity(0.5),
                                    onTap: () => setState(() => theme = 'light'),
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
                                  child: Image.asset('assets/images/darkdeviceframe.png', scale: 9),
                                  decoration: theme == 'dark'? BoxDecoration(border: Border.all(color: Colors.red.shade400, width: 2), borderRadius: const BorderRadius.all(Radius.circular(11))) : null,
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: Colors.red[400]?.withOpacity(0.5),
                                    onTap: () => setState(() => theme = 'dark'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26.0),
                    buildBottomPageIndicator(4, 1)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Where would you like us to store your data?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                    const SizedBox(height: 16.0),
                    Text('Selected: ${storeDataInCloud? 'store in the cloud' : 'keep on my device'}', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor.withOpacity(0.5)), textAlign: TextAlign.center),
                    Switch.adaptive(value: storeDataInCloud, onChanged: (value) => setState(() => storeDataInCloud = value), activeColor: Colors.red[400]),
                    const SizedBox(height: 26.0),
                    buildBottomPageIndicator(4, 2)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Do you want to contribute to Wave?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                    const SizedBox(height: 16.0),
                    Text('Contributors help this open-source app grow. If you have experience in software development, consider checking out the GitHub repository.', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor.withOpacity(0.5)), textAlign: TextAlign.center),
                    const SizedBox(height: 16.0),
                    InkWell(
                      onTap: launchRepo,
                      borderRadius: BorderRadius.circular(360),
                      child: Ink(
                        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                        child: const Text(
                          'Take me there',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red[500],
                            borderRadius: BorderRadius.circular(360)
                        ),
                      ),
                    ),
                    const SizedBox(height: 26.0),
                    buildBottomPageIndicator(4, 3)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Proceed to app', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                    const SizedBox(height: 16.0),
                    Text('All of your preferences will be saved.', style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor.withOpacity(0.5)), textAlign: TextAlign.center),
                    const SizedBox(height: 16.0),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(360),
                      child: Ink(
                        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                        child: const Text(
                          "Let's go",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red[500],
                            borderRadius: BorderRadius.circular(360)
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}
