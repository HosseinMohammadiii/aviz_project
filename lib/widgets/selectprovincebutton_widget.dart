import 'package:flutter/material.dart';

import '../class/colors.dart';

class SelectProvinceAndCityButton extends StatelessWidget {
  const SelectProvinceAndCityButton({
    super.key,
    required this.isSelectProvinces,
    required this.onChanges,
  });

  final bool isSelectProvinces;

  final Function() onChanges;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      color: CustomColor.grey,
      alignment: Alignment.topCenter,
      transformAlignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          onChanges();
        },
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            color: isSelectProvinces ? CustomColor.red : CustomColor.grey300,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'انتخاب',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
