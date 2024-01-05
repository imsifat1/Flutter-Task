import 'package:flutter/material.dart';

class MyProgressIndicator {
  static void circularProgressIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(.2),
      builder: (context) {
        return WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: const Dialog(
            elevation: 10,
            backgroundColor: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ),
        );
      },
    );
  }

  static void dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
