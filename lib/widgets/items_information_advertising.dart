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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: listTextTitle.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 33.5),
                  child: textWidget(
                    listTextTitle[index],
                    CustomColor.grey500,
                    14,
                    FontWeight.w400,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWidget(
                  '${widget.advertising.yearBuild}',
                  CustomColor.black,
                  15,
                  FontWeight.w400,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: textWidget(
                    '${widget.advertising.floor}',
                    CustomColor.black,
                    15,
                    FontWeight.w400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: textWidget(
                    '${widget.advertising.countRom}',
                    CustomColor.black,
                    15,
                    FontWeight.w400,
                  ),
                ),
                textWidget(
                  '${widget.advertising.metr}',
                  CustomColor.black,
                  15,
                  FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
