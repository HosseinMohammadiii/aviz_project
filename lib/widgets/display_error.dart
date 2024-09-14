import 'package:flutter/material.dart';

import '../class/colors.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
class DisplayError extends StatelessWidget {
  DisplayError({
    super.key,
    required this.error,
  });
  String error;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: textWidget(
          error,
          CustomColor.black,
          16,
          FontWeight.w500,
        ),
      ),
    );
  }
}
