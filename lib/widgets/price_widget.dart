import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:aviz_project/extension/price_extension.dart';
import 'package:flutter/material.dart';

import '../class/colors.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.context,
    required this.adPrice,
  });

  final BuildContext context;
  final RegisterFutureAd adPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            boxDisplayPrice(
              context: context,
              price: adPrice.rentPrice != 0
                  ? adPrice.rentPrice
                  : adPrice.homeprice,
            ),
            Text(
              adPrice.rentPrice != 0 ? ':ودیعه' : ':قیمت',
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
        Visibility(
          visible: adPrice.rentPrice != 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              boxDisplayPrice(
                context: context,
                price: adPrice.homeprice,
              ),
              Text(
                ':اجاره',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

//Widget for Display Box Price Advertising
  Widget boxDisplayPrice({
    required BuildContext context,
    required int price,
  }) {
    return Container(
      width: 91,
      height: 24,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: CustomColor.grey200,
      ),
      child: Text(
        price.formatter(),
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: CustomColor.red,
              fontSize: 13,
            ),
      ),
    );
  }
}
