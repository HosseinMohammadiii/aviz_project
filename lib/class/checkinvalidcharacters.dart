import 'package:flutter/material.dart';

import 'colors.dart';

List<String> invalidCharacters = [
  "@",
  "#",
  "\$",
  "%",
  "^",
  "&",
  "*",
  "(",
  ")",
  "-",
  "+",
  "=",
  "{",
  "}",
  "[",
  "]",
  "|",
  "\\",
  ":",
  ";",
  "\"",
  "'",
  "<",
  ">",
  ",",
  ".",
  "?",
  "/",
  "!",
  "~",
];

// Widget for username input field
Widget textFieldUserNAme(
  TextEditingController userNamecontroller,
  FocusNode userNameFocusNode,
  Function onChanges,
) {
  return LayoutBuilder(
    builder: (context, constraints) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: CustomColor.grey300,
      ),
      child: TextField(
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
        focusNode: userNameFocusNode,
        controller: userNamecontroller,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontFamily: 'SN',
          fontSize: 20,
          color: CustomColor.grey500,
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'نام کاربری',
          hintStyle: TextStyle(
            fontFamily: 'SN',
            fontSize: 18,
            color: CustomColor.grey500,
          ),
        ),
        onTapOutside: (event) {
          userNameFocusNode.unfocus();
        },
        onChanged: (value) {
          onChanges();
        },
      ),
    ),
  );
}
