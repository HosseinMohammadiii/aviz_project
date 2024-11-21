import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../class/colors.dart';

//Display the title of the sections of the RegisterAdvertising & RegisterHomeFeatureScreen
Widget textTitleSections({required String txt, required String img}) {
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
