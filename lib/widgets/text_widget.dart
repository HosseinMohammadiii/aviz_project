import 'package:flutter/material.dart';

//Text Widget
Text textWidget(
  String txt,
  Color color,
  double fsize,
  FontWeight fweight,
) {
  return Text(
    txt,
    textAlign: TextAlign.right,
    textDirection: TextDirection.rtl,
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
    style: TextStyle(
      color: color,
      fontSize: fsize,
      decoration: TextDecoration.none,
      fontFamily: 'SN',
      fontWeight: fweight,
    ),
  );
}
