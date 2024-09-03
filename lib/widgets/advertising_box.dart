import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:aviz_project/widgets/cached_network_image.dart';
import 'package:aviz_project/widgets/price_widget.dart';
import 'package:flutter/material.dart';

import '../class/colors.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
class AdvertisingSearchWidget extends StatelessWidget {
  AdvertisingSearchWidget({
    super.key,
    required this.advertisingHome,
  });
  AdvertisingHome advertisingHome;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: CustomColor.white,
        boxShadow: const [
          BoxShadow(
            color: CustomColor.black,
            blurRadius: 40,
            spreadRadius: -50,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 111,
            child: CachedNetworkImageWidget(
              imgUrl: advertisingHome.idGallery,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 5,
                ),
                textWidget(
                  advertisingHome.title,
                  CustomColor.black,
                  14,
                  FontWeight.w700,
                ),
                textWidget(
                  advertisingHome.description,
                  CustomColor.black,
                  12,
                  FontWeight.w400,
                ),
                const SizedBox(
                  height: 10,
                ),
                PriceWidget(context: context, adHome: advertisingHome)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
