import 'package:flutter/material.dart';

class TextFieldBox extends StatefulWidget {
  TextFieldBox({
    super.key,
    required this.hint,
    required this.textInputType,
    required this.countLine,
    required this.focusNode,
    this.controller,
  });
  String hint;
  TextInputType textInputType;
  int countLine;
  FocusNode focusNode = FocusNode();
  TextEditingController? controller;

  @override
  State<TextFieldBox> createState() => _TextFieldBoxState();
}

class _TextFieldBoxState extends State<TextFieldBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[300],
      ),
      child: TextField(
        keyboardType: widget.textInputType,
        maxLines: widget.countLine,
        focusNode: widget.focusNode,
        controller: widget.controller,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontFamily: 'SN',
          fontSize: 20,
          color: Colors.grey[500],
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontFamily: 'SN',
            fontSize: 18,
            color: Colors.grey[500],
          ),
        ),
        onTapOutside: (event) {
          widget.focusNode.unfocus();
        },
      ),
    );
  }
}
