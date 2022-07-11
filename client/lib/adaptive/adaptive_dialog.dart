import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import '../screens/app_view.dart';

void showAdaptiveAlertDialog(BuildContext context, void Function() onSave) {
  Platform.isAndroid?
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Save changes?', style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppView(page: 1))),
          child: const Text('Discard'),
        ),
        TextButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
      ],
    ),
  ) :
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: const Text('Save changes?'),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppView(page: 1))),
          child: const Text('Discard'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: onSave,
          child: const Text('Save'),
        )
      ],
    ),
  );
}
