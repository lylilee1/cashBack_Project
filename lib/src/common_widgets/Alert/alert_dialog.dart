

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAlertDialog {
  static void showMyDialog(
      {required BuildContext context,
        required String title,
        required String content,
        required Function() onPressedNo,
        required Function() onPressedYes}) {
    showCupertinoDialog<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            child: const Text('Non'),
            onPressed: onPressedNo,
          ),
          CupertinoDialogAction(
            child: const Text('Oui'),
            isDestructiveAction: true,
            onPressed: onPressedYes,
          ),
        ],
      ),
    );
  }
}