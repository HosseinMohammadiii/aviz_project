import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../DataFuture/home/Data/model/advertising.dart';

// ignore: must_be_immutable
class ItemInformationFuture extends StatefulWidget {
  ItemInformationFuture({
    super.key,
    required this.advertising,
  });
  AdvertisingHome advertising;
  @override
  State<ItemInformationFuture> createState() => _ItemInformationFutureState();
}

class _ItemInformationFutureState extends State<ItemInformationFuture> {
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
            informationBoxItem('ساخت', widget.advertising.yerbuild),
            informationBoxItem('طبقه', widget.advertising.floor),
            informationBoxItem('اتاق', widget.advertising.room),
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
