import 'package:flutter/material.dart';

class SetupView extends StatefulWidget {
  const SetupView({Key? key}) : super(key: key);

  @override
  _SetupViewState createState() => _SetupViewState();
}

class _SetupViewState extends State<SetupView> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Before we start, let's work out what suits you", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
                Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(360),
                    child: Ink(
                      padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                      child: const SizedBox(
                        width: 55,
                        child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red[500],
                          borderRadius: BorderRadius.circular(360)
                      ),
                    ),
                  ),
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
          )
      ),
    );
  }
}
