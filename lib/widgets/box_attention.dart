import 'package:flutter/material.dart';

import '../class/colors.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
class BoxAttention extends StatelessWidget {
  BoxAttention({
    super.key,
    required this.txt,
    required this.color,
  });
  final String txt;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.grey350),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.arrow_back_ios_rounded,
            color: color,
          ),
          const Spacer(),
          textWidget(
            txt,
            CustomColor.black,
            16,
            FontWeight.w500,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
