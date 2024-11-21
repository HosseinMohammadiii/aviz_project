import 'package:flutter/material.dart';

import '../class/colors.dart';

// ignore: must_be_immutable
class AppProvinceSection extends StatelessWidget {
  AppProvinceSection({
    super.key,
    required this.province,
    this.isShowIcon,
  });
  bool? isShowIcon;
  String province;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Spacer(),
        Text(
          province,
          style: const TextStyle(
            fontSize: 17,
            color: CustomColor.black,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Visibility(
          visible: isShowIcon == true,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ),
      ],
    );
  }
}
