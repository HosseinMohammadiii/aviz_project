import 'package:aviz_project/extension/price_extension.dart';
import 'package:flutter/material.dart';

import '../DataFuture/home/Data/model/advertising.dart';
import '../class/colors.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.context,
    required this.adHome,
  });

  final BuildContext context;
  final AdvertisingHome adHome;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 91,
          height: 26,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: CustomColor.grey200,
          ),
          child: Text(
            adHome.price.formatter(),
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: CustomColor.red,
                ),
          ),
        ),
        Text(
          ':قیمت',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
