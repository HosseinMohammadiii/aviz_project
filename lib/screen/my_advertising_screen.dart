import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/add_advertising_screen.dart';
import 'package:aviz_project/screen/information_advertising.dart';
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textWidget(
                  ' آگهی های من',
                  CustomColor.red,
                  16,
                  FontWeight.w500,
                ),
                Image.asset('images/icon_home_active.png'),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: advertisingBox.length,
                itemBuilder: (context, index) {
                  var advertising = advertisingBox.toList()[index];

                  return GestureDetector(
                    onTap: () {
                      print('object');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => InformationAdvertising(
                      //       advertising: advertising,
                      //       advertisingData: advertisingData,
                      //     ),
                      //   ),
                      // );
                    },
                    child: AdvertisingWidget(advertisingData: advertising),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
