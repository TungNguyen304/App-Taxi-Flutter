import 'package:flutter/material.dart';

class MsgDialog {
  static void showMsgDialog(BuildContext context, String msg, String title) {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          ElevatedButton(
            onPressed: () { Navigator.of(context).pop(MsgDialog()); }, 
            child: const Text("OK"),
          )
        ],
      )
    );
  }

}