import 'package:flutter/material.dart';

import '../class/colors.dart';

// ignore: must_be_immutable
class ProvinceAndCityTextFeild extends StatelessWidget {
  ProvinceAndCityTextFeild({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.lable,
    required this.hint,
  });
  final String lable;
  final String hint;

  final TextEditingController controller;

  final FocusNode focusNode;

  Function(String value) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: TextInputType.streetAddress,
          autofocus: true,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            hintText: hint,
            labelText: lable,
            labelStyle: TextStyle(
              fontSize: 18,
              color: colorShow(focusNode, controller),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: colorShow(focusNode, controller),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1,
                color: colorShow(focusNode, controller),
              ),
            ),
          ),
          onChanged: (value) {
            onChanged(value);
          },
        ),
      ),
    );
  }
}
