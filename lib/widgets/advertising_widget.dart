import 'package:aviz_project/class/advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/information_advertising.dart';
import 'package:aviz_project/widgets/items_information_advertising.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdvertisingWidget extends StatefulWidget {
  AdvertisingWidget({
    super.key,
    required this.advertisingData,
    required this.advertising,
  });
  AdvertisingData advertisingData;
  Advertising advertising;
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
        setState(() {
          ItemInformation(advertising: widget.advertising);
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InformationAdvertising(
              advertising: widget.advertising,
              advertisingData: widget.advertisingData,
            ),
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
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 40,
              spreadRadius: -35,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 107,
              width: 111,
              child: Image.file(
                widget.advertisingData.img!,
                fit: BoxFit.fill,
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
                    widget.advertisingData.title ?? 'Null',
                    Colors.black,
                    14,
                    FontWeight.w700,
                  ),
                  textWidget(
                    widget.advertisingData.description ?? 'Null',
                    Colors.black,
                    12,
                    FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  priceText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//Widget For display Price Advertising
  Row priceText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 26,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.grey[200],
          ),
          child: textWidget(
            currencyFormat.format(widget.advertisingData.price ?? 'Null'),
            CustomColor.red,
            12,
            FontWeight.w500,
          ),
        ),
        textWidget(
          'قیمت:',
          Colors.black,
          12,
          FontWeight.w500,
        ),
      ],
    );
  }
}
