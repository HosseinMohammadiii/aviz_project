import 'package:flutter/material.dart';

class CustomColor {
  static const Color red = Color(0xffE60023);
  static const Color pink = Color(0xffff6269);
  static const Color normalRed = Color(0xffe57373);

  static const Color black = Colors.black;

  static const Color grey = Color(0xffF9FAFB);
  static Color grey200 = Colors.grey[200]!;
  static Color grey300 = Colors.grey[300]!;
  static Color grey350 = Colors.grey[350]!;
  static const Color grey400 = Color(0xffD0D5DD);
  static Color grey500 = Colors.grey[500]!;

  static Color bluegrey = Colors.blueGrey;
  static Color bluegrey50 = Colors.blueGrey[50]!;

  static Color white = Colors.white;
}

Color colorShow(
  FocusNode focusNode,
  TextEditingController controller,
) {
  if (focusNode.hasFocus || controller.text.isNotEmpty) return Colors.pink;

  return CustomColor.grey500;
}
