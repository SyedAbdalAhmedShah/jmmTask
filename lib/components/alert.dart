import 'package:flutter/material.dart';

class Alerts {
  static Future<dynamic> showMessage(
    BuildContext context,
    String message,
  ) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              actionsPadding: EdgeInsets.all(8),
              content: Text(message),
              title: Text('message'),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'ok',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ));
  }
}
