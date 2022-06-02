import 'package:flutter/material.dart';

class Alerts {
  static Future showDialogOK(BuildContext context,
      {required String title, required String message}) {
    TextButton textButton = TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text("OK"),
    );
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [textButton],
          );
        });
  }

  static Future showDialogYesNo(BuildContext context,
      {required String title,
      required String message,
      void Function()? onYes}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: onYes,
            child: const Text('Yes'),
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMessage(
      BuildContext context,
      {required String message}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
