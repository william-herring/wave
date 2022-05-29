import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:wave/main.dart';

void showAdaptiveAlertDialog(BuildContext context) {
  Platform.isAndroid?
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Save changes?', style: TextStyle(color: Colors.black)),
      actions: <Widget>[
        TextButton(
        onPressed: () => Navigator.pop(context, 'Cancel'),
        child: const Text('Discard'),
        ),
        TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
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
          onPressed: () => Navigator.pop(context),
          child: const Text('Discard'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Save'),
        )
      ],
    ),
  );
}