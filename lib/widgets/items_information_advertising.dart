import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ItemInformation extends StatefulWidget {
  ItemInformation({
    super.key,
    required this.advertising,
  });
  Advertising advertising;
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
            informationBoxItem('ساخت', widget.advertising.yearBuild!),
            informationBoxItem('طبقه', widget.advertising.floor!),
            informationBoxItem('اتاق', widget.advertising.countRom!),
            informationBoxItem('متراژ', widget.advertising.metr!),
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
        textWidget(
          title,
          CustomColor.grey500,
          15,
          FontWeight.w400,
        ),
        Container(
          width: 40,
          alignment: Alignment.center,
          child: Text(
            advertising.toString(),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'SN',
              color: CustomColor.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
