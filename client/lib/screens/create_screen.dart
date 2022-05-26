import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wave/adaptive/adaptive_icons.dart';

class CreateScreen extends StatefulWidget {
  final VoidCallback closeContainer;
  const CreateScreen({Key? key, required this.closeContainer}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState(closeContainer);
}

class _CreateScreenState extends State<CreateScreen> {
  final VoidCallback closeContainer;
  String mode = 'record';
  _CreateScreenState(this.closeContainer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a Wave'),
          leading: IconButton(icon: const Icon(Icons.close), onPressed: closeContainer),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                        label: Text('Title'),
                    )
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(45),
                    onTap: () => setState(() {
                      mode = 'record';
                    }),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(AdaptiveIcons.mic, size: 64.0, color: mode == 'record'? Colors.red[400] : null),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(45),
                    onTap: () => setState(() {
                      mode = 'plot';
                    }),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(CupertinoIcons.waveform, size: 64.0, color: mode == 'plot'? Colors.red[400] : null),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(360),
                child: Ink(
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                  child: const Text(
                    'Create',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.red[500],
                      borderRadius: BorderRadius.circular(360)
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
