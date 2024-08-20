import 'package:flutter/material.dart';

import '../class/colors.dart';

class TextFieldBox extends StatefulWidget {
  TextFieldBox({
    super.key,
    required this.hint,
    required this.textInputType,
    required this.countLine,
    required this.focusNode,
    this.controller,
    required this.textInputAction,
  });
  String hint;
  TextInputType textInputType;
  int countLine;
  FocusNode focusNode = FocusNode();
  TextEditingController? controller;
  TextInputAction textInputAction;

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
        color: CustomColor.grey300,
      ),
      child: TextField(
        keyboardType: widget.textInputType,
        textInputAction: widget.textInputAction,
        maxLines: widget.countLine,
        focusNode: widget.focusNode,
        controller: widget.controller,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontFamily: 'SN',
          fontSize: 20,
          color: CustomColor.grey500,
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontFamily: 'SN',
            fontSize: 18,
            color: CustomColor.grey500,
          ),
        ),
        onTapOutside: (event) {
          widget.focusNode.unfocus();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();
  }
}
