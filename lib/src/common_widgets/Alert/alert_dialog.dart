

import 'package:flutter/cupertino.dart';

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
            onPressed: onPressedNo,
            child: const Text('Non'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onPressedYes,
            child: const Text('Oui'),
          ),
        ],
      ),
    );
  }
}