import 'package:flutter/material.dart';

import '../DataFuture/province/model/province.dart';
import '../class/colors.dart';

// ignore: must_be_immutable
class PRovinceAndCitiesWidget extends StatelessWidget {
  PRovinceAndCitiesWidget({
    super.key,
    required this.province,
    required this.index,
    required this.onTap,
  });
  List<ProvinceModel> province;
  int index;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          splashColor: CustomColor.grey350,
          onTap: () {
            onTap();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  province[index].name,
                  style: const TextStyle(
                    fontSize: 15,
                    color: CustomColor.black,
                  ),
                ),
                const Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: CustomColor.red,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            thickness: 1,
            height: 5,
          ),
        ),
      ],
    );
  }
}
