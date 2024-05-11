import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/advertising_widget.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MyAdvertisingScreen extends StatefulWidget {
  const MyAdvertisingScreen({super.key});

  @override
  State<MyAdvertisingScreen> createState() => _MyAdvertisingScreenState();
}

class _MyAdvertisingScreenState extends State<MyAdvertisingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                  'آگهی های من',
                  CustomColor.red,
                  16,
                  FontWeight.w500,
                ),
                Image.asset('images/icon_home_active.png'),
              ],
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: advertisingDataBox.length,
              itemBuilder: (context, index) {
                var advertisingData = advertisingDataBox.toList()[index];
                var advertising = advertisingBox.toList()[index];

                return AdvertisingWidget(
                  advertisingData: advertisingData,
                  advertising: advertising,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
