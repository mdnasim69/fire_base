import 'package:flutter/material.dart';

class Utils {
  static Message(String msg, BuildContext context, [IsError = false]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: IsError ? Colors.red : Colors.green,
      ),
    );
  }
}
