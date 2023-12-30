import 'package:flutter/material.dart';

//Widget For Show Alert Dialog
Future<void> displayDialog(String txt, BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Colors.blueGrey[50],
        title: Text(
          txt,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'SM',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blueGrey),
            ),
            child: const Text(
              'قبول',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'SM',
                fontSize: 18,
              ),
            ),
          ),
        ],
      );
    },
  );
}
