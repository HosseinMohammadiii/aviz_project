import 'package:aviz_project/class/colors.dart';
import 'package:flutter/material.dart';

extension ButtonClick on GestureDetector {
  GestureDetector textButton(
    Function()? function,
    String txt,
    Color colorcontain,
    Color colortxt,
    bool showIcon,
  ) {
    return GestureDetector(
      onTap: function,
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 15),
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colorcontain,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: CustomColor.red,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: showIcon,
              child: const Icon(
                Icons.arrow_back_ios,
                color: CustomColor.grey,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              txt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colortxt,
                fontSize: 16,
                fontFamily: 'SN',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
