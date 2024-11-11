import 'package:flutter/material.dart';

void showMessage(String message, BuildContext context, int duration) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      textDirection: TextDirection.rtl,
    ),
    duration: Duration(seconds: duration),
  ));
}
