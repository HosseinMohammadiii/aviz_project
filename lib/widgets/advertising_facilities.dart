import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../class/colors.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
class AdvertisingFacilitiesWidget extends StatelessWidget {
  AdvertisingFacilitiesWidget({
    super.key,
    required this.adFacilities,
  });
  AdvertisingFacilities adFacilities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            textWidget(
              'امکانات',
              CustomColor.black,
              16,
              FontWeight.w700,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('images/magicpen.png'),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: CustomColor.grey350),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (adFacilities.elevator) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: textWidget(
                    'آسانسور',
                    CustomColor.grey500,
                    16,
                    FontWeight.w400,
                  ),
                ),
                _dottedLineWidget(),
              ],
              if (adFacilities.parking) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: textWidget(
                    'پارکینگ',
                    CustomColor.grey500,
                    16,
                    FontWeight.w400,
                  ),
                ),
                _dottedLineWidget(),
              ],
              if (adFacilities.storeroom) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: textWidget(
                    'انباری',
                    CustomColor.grey500,
                    16,
                    FontWeight.w400,
                  ),
                ),
                _dottedLineWidget(),
              ],
              if (adFacilities.balcony) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: textWidget(
                    'بالکن',
                    CustomColor.grey500,
                    16,
                    FontWeight.w400,
                  ),
                ),
                _dottedLineWidget(),
              ],
              if (adFacilities.penthouse) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: textWidget(
                    'پنت هاوس',
                    CustomColor.grey500,
                    16,
                    FontWeight.w400,
                  ),
                ),
                _dottedLineWidget(),
              ],
              if (adFacilities.duplex) ...[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: textWidget(
                    'دوبلکس',
                    CustomColor.grey500,
                    16,
                    FontWeight.w400,
                  ),
                ),
                _dottedLineWidget(),
              ],
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: textWidget(
                  'جنس کف: ${adFacilities.floormaterial}',
                  CustomColor.grey500,
                  16,
                  FontWeight.w400,
                ),
              ),
              _dottedLineWidget(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: textWidget(
                  'سرویس بهداشتی: ${adFacilities.wc}',
                  CustomColor.grey500,
                  16,
                  FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//Widget For Display Dotted Line
  Padding _dottedLineWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: DottedLine(
        dashColor: CustomColor.grey350,
        lineThickness: 1.5,
        dashLength: 6,
      ),
    );
  }
}
