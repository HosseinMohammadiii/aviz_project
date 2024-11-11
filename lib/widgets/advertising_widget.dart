import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../DataFuture/ad_details/Data/model/ad_facilities.dart';
import '../DataFuture/add_advertising/Data/model/register_future_ad.dart';

import 'price_widget.dart';

// ignore: must_be_immutable
class AdvertisingWidget extends StatefulWidget {
  AdvertisingWidget({
    super.key,
    required this.advertising,
    required this.advertisingImages,
    required this.advertisingFacilities,
    required this.screen,
  });
  RegisterFutureAd advertising;
  String advertisingImages;
  AdvertisingFacilities advertisingFacilities;
  Widget screen;

  @override
  State<AdvertisingWidget> createState() => _AdvertisingWidgetState();
}

class _AdvertisingWidgetState extends State<AdvertisingWidget> {
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'fa-IR', symbol: '');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => widget.screen,
          ),
        );
      },
      child: Container(
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
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.advertisingImages,
                    height: 107,
                    width: 107,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Center(
                      child: CircularProgressIndicator(
                        color: CustomColor.normalRed,
                      ),
                    ),
                    placeholder: (context, url) => Center(
                      child: Shimmer.fromColors(
                        baseColor: const Color(0xffE1E1E1),
                        highlightColor: const Color(0xffF3F3F2),
                        child: Container(
                          height: 107,
                          width: 107,
                          color: Colors.blue,
                        ),
                      ),
                    ),
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
                        widget.advertising.titlehome,
                        CustomColor.black,
                        14,
                        FontWeight.w700,
                      ),
                      textWidget(
                        widget.advertising.description,
                        CustomColor.black,
                        12,
                        FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PriceWidget(
                          context: context,
                          adPrice: widget.advertising.homeprice),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ItemInformation extends StatefulWidget {
  ItemInformation({
    super.key,
    required this.advertising,
  });
  RegisterFutureAd advertising;
  @override
  State<ItemInformation> createState() => _ItemInformationState();
}

class _ItemInformationState extends State<ItemInformation> {
  List listTextTitle = [
    'متراژ',
    'اتاق',
    'طبقه',
    'ساخت',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            informationBoxItem('ساخت', widget.advertising.yearBiuld),
            informationBoxItem('طبقه', widget.advertising.floor),
            informationBoxItem('اتاق', widget.advertising.countRoom),
            informationBoxItem('متراژ', widget.advertising.metr),
          ],
        ),
      ),
    );
  }

  Column informationBoxItem(
    String title,
    num advertising,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 14,
        ),
        textWidget(
          title,
          CustomColor.grey500,
          15,
          FontWeight.w400,
        ),
        Container(
          width: 40,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 12),
          child: SizedBox(
            height: 40,
            child: Text(
              advertising.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'SN',
                color: CustomColor.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
