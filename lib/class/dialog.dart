import 'package:aviz_project/class/colors.dart';
import 'package:flutter/material.dart';

//Widget For Show Alert Dialog
Future<void> displayDialog(String txt, BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: CustomColor.bluegrey50,
        title: Text(
          txt,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'SM',
            fontSize: 20,
            color: CustomColor.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(CustomColor.bluegrey),
            ),
            child: Text(
              'قبول',
              style: TextStyle(
                color: CustomColor.white,
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
