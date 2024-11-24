import 'package:flutter/material.dart';

import 'colors.dart';

//List Invalid Characters
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

//List Valid Characters
List<String> validCharacters = [
  "@",
  ".",
  "_",
  "-",
];

// Production invalid characters for validate iput Email characters
final List<String> invalidCharactersEmail =
    List.generate(65536, (i) => String.fromCharCode(i))
        .where((char) => !RegExp(r'[a-zA-Z0-9]').hasMatch(char))
        .where((char) => !validCharacters.contains(char))
        .toList();

// Generate a list of all characters that are not alphanumeric and not in invalidCharacters
final List<String> allCharacters =
    List.generate(65536, (i) => String.fromCharCode(i))
        .where((char) => !RegExp(r'[a-zA-Z0-9]').hasMatch(char))
        .toList()
        .where((char) => !invalidCharacters.contains(char))
        .toList();

// Widget for username input field
Widget textFieldUserNAme(
  TextEditingController userNamecontroller,
  FocusNode userNameFocusNode,
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
      ),
    ),
  );
}
