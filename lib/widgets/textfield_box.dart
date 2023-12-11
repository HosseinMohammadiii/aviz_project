import 'package:flutter/material.dart';

class TextFieldBox extends StatelessWidget {
  TextFieldBox({
    super.key,
    required this.hint,
    required this.textInputType,
    required this.countLine,
  });
  String hint;
  TextInputType textInputType;
  int countLine;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[300],
      ),
      child: TextField(
        keyboardType: textInputType,
        maxLines: countLine,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontFamily: 'SN',
          fontSize: 20,
          color: Colors.grey[500],
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'SN',
            fontSize: 18,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
