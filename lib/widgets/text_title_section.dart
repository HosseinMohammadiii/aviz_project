import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../class/colors.dart';

class TextTitleSection extends StatelessWidget {
  const TextTitleSection({
    super.key,
    required this.txt,
    required this.img,
  });

  final String txt;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          textWidget(
            txt,
            CustomColor.black,
            16,
            FontWeight.w700,
          ),
          const SizedBox(
            width: 10,
          ),
          Image.asset(img),
        ],
      ),
    );
  }
}
